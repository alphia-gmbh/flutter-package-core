// Copyright 2024 Alphia GmbH
import 'package:flutter/cupertino.dart' show CupertinoPageRoute;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'crossplatform_io.dart' if (dart.library.js_interop) 'crossplatform_web.dart';
import 'service_functions.dart';
import 'service_theme.dart';
import 'service_widgets.dart';


/// Open [url] in internal webview if [appDomain] matches, otherwise open in external browser.
void coreOpenUrl({required String url, String appDomain = 'www.alphia.io', bool inAppBrowserView = false, bool webNewTab = true}) {
  if (!CorePlatform.isWeb && (Uri.parse(url).host == appDomain)) { // Open in internal webview
    Navigator.push(CoreInstance.context, CupertinoPageRoute(builder: (context) => WebViewPage(url: url)));
  } else { // Open in external browser
    _openUrlInExternalBrowser(url: url, inAppBrowserView: inAppBrowserView, webNewTab: webNewTab);
  }
  return;
}

void _openUrlInExternalBrowser({required String url, bool inAppBrowserView = false, bool webNewTab = true}) {
  try {
    launchUrl(Uri.parse(url), mode: inAppBrowserView ? LaunchMode.inAppBrowserView : LaunchMode.externalApplication, webOnlyWindowName: webNewTab ? null : '_self')
      .then((result) {if (!result && !CorePlatform.isWeb) {throw PlatformException(code: 'errorCode wing');}});
  } catch (_) {
    coreShowDialog(title: CoreInstance.text.dialogTitleNoBrowser, content: '${CoreInstance.text.dialogContentNoBrowser}\n$url', leftButton: null, rightButton: CoreInstance.text.buttonOk);
  }
  return;
}

class _WebViewNotifier with ChangeNotifier {
  bool _loading = true;
  bool _hasError = false;
  bool _animating = true;
  String _title = '';
  bool _onPageTop = true;

  bool get loading => _loading;
  set loading(bool loading) {
    _loading = loading;
    notifyListeners();
  }
  bool get hasError => _hasError;
  set hasError(bool hasError) {
    _hasError = hasError;
    notifyListeners();
  }
  bool get animating => _animating;
  set animating(bool animating) {
    _animating = animating;
    notifyListeners();
  }
  String get title => _title;
  set title(String title) {
    _title = title;
    notifyListeners();
  }
  bool get onPageTop => _onPageTop;
  set onPageTop(bool onPageTop) {
    _onPageTop = onPageTop;
    notifyListeners();
  }
}

/// Page with webview to display [url].
class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key, required this.url});
  final String url;
  @override
  State<WebViewPage> createState() => _WebViewPageState();
}
class _WebViewPageState extends State<WebViewPage> {
  final webViewNotifier = _WebViewNotifier();
  final webViewController = WebViewController();

  @override
  void initState() {
    super.initState();

    // Init webViewController
    webViewController.setJavaScriptMode(JavaScriptMode.unrestricted);
    webViewController.enableZoom(false);
    webViewController.setOnScrollPositionChange((scrollPositionChange) { // Animate app bar on scroll
      if ((scrollPositionChange.y > 1) && webViewNotifier.onPageTop) {webViewNotifier.onPageTop = false;}
      else if ((scrollPositionChange.y <= 1) && !webViewNotifier.onPageTop) {webViewNotifier.onPageTop = true;}
    });
    // webViewController.clearCache(); // For testing purpose only
    //..clearLocalStorage() // For testing purpose only

    // Initial behaviour for first url before webview is open
    if (widget.url.contains('datenschutz'))
      {webViewController.loadFlutterAsset('assets/local-datenschutz.html');}
    else if (widget.url.contains('impressum'))
      {webViewController.loadFlutterAsset('assets/local-impressum.html');}
    else
      {webViewController.loadRequest(Uri.parse(widget.url));}

    // Followup behavior
    webViewController.setNavigationDelegate(NavigationDelegate(
      // Second url request when webview already open
      onNavigationRequest: (request) {
        if (request.url.startsWith('file:///') && request.url.split('#').first.endsWith('flutter_assets/assets/local-datenschutz.html')) // Necessary because iOS always calling onNavigationRequest
          {return NavigationDecision.navigate;}
        else if (request.url.startsWith('file:///') && request.url.split('#').first.endsWith('flutter_assets/assets/local-impressum.html')) // Necessary because iOS always calling onNavigationRequest
          {return NavigationDecision.navigate;}
        else if (request.url.startsWith('file:///') && request.url.endsWith('flutter_assets/assets/datenschutz.html')) // Necessary because iOS always calling onNavigationRequest
            {webViewController.loadFlutterAsset('assets/local-datenschutz.html');}
        else if (request.url.startsWith('file:///') && request.url.endsWith('flutter_assets/assets/impressum.html')) // Necessary because iOS always calling onNavigationRequest
            {webViewController.loadFlutterAsset('assets/local-impressum.html');}
        else if (Uri.parse(request.url).host == Uri.parse(widget.url).host) {
          if (request.url.contains('datenschutz'))
            {webViewController.loadFlutterAsset('assets/local-datenschutz.html');}
          else if (request.url.contains('impressum'))
            {webViewController.loadFlutterAsset('assets/local-impressum.html');}
          else
            {return NavigationDecision.navigate;}
        }
        else {_openUrlInExternalBrowser(url: request.url);}
        return NavigationDecision.prevent;
      },

      // Finalize page
      onPageFinished: (url) async {
        if (!url.contains('#')) { // Scroll to language version id langElementId, if url is no page internal link
          await webViewController.runJavaScript(
            'const langId = navigator.language.substring(0, 2);'
            'if (document.getElementById(langId)) {'
            '  const sections = document.querySelectorAll("section");'
            '  sections.forEach(section => {'
            '    const h1Element = section.firstElementChild;'
            '    if (h1Element && h1Element.tagName === "H1") {'
            '      if (h1Element.id === langId) {'
            '        h1Element.style.display = "none";'
            '        const h4Element = section.querySelector("H4");'
            '        if (h4Element) {h4Element.style.display = "none";}'
            '      } else {'
            '        section.style.display = "none";'
            '      }'
            '    }'
            '    const hrElement = section.nextElementSibling;'
            '    if (hrElement && hrElement.tagName === "HR") {'
            '      hrElement.style.display = "none";'
            '    }'
            '  });'
            '  window.scrollTo(0, 0);'
            '}'
            'const noneElements = document.getElementsByClassName("onAppDisplayNone");'
            '[...noneElements].forEach(noneElement => {noneElement.style.display = "none";});'
          );
        }
        String title = await webViewController.getTitle() ?? '';
        if (mounted) {
          final splitTitle = title.split(' / ');
          if (splitTitle.length >= 2) { // More reliable than runJavaScript
            switch (Localizations.localeOf(context).languageCode) {
              case 'de': title = splitTitle[0]; break;
              case 'en': title = splitTitle[1]; break;
              default: break;
            }
          }
          if (title.split(' - ').length >= 2) {title = title.split(' - ').first;}
          if (!webViewNotifier.hasError) {webViewNotifier.title = title;}
          webViewNotifier.loading = false;
        }
        return;
      },

      // Handle errors
      onWebResourceError: (error) {
        if (mounted) webViewNotifier.hasError = true;
        if ([-2, -6, -1003, -1004, -1009, -1200].contains(error.errorCode)) { // Offline errors
          // Android: -6 net::ERR_CONNECTION_REFUSED
          // iOS: -1200 An SSL error has occurred and a secure connection to the server cannot be made.
          if (mounted) CoreShowDialog.offline().then((_) {if (mounted) Navigator.of(context).pop();});
        } else {
          CoreInstance.crashlytics.recordError(error, null, reason: 'errorCode grain -- ${error.errorCode} -- ${error.description}');
        }
        return;
      },
    ));
  }
  @override
  void dispose() {
    webViewNotifier.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    webViewController.setBackgroundColor(Theme.of(context).colorScheme.surface);
    return ListenableBuilder(
      listenable: webViewNotifier,
      builder: (BuildContext context, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            title: AnimatedOpacity(
              opacity: (webViewNotifier.title.isNotEmpty) ? 1 : 0,
              duration: CoreTheme.animationDuration,
              curve: Curves.easeInOutCubic,
              child: Text(webViewNotifier.title),
            ),
            leading: const CoreBackButton(),
            elevation: (webViewNotifier.onPageTop || webViewNotifier.loading) ? null : 3, // Animate app bar on scroll
            backgroundColor: (webViewNotifier.onPageTop || webViewNotifier.loading) ? null : Theme.of(context).colorScheme.surfaceContainer, // Animate app bar on scroll
          ),
          body: SafeArea(
            // bottom: false,
            child: Stack( // Stack error message above web view
              children: <Widget>[
                WebViewWidget(controller: webViewController),
                if (webViewNotifier.animating || webViewNotifier.hasError) // Disappear after animation completed
                  AnimatedOpacity(
                    opacity: (webViewNotifier.loading || webViewNotifier.hasError) ? 1 : 0,
                    duration: CoreTheme.animationDuration,
                    curve: Curves.easeInOutCubic,
                    onEnd: () {webViewNotifier.animating = false;},
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          color: Theme.of(context).colorScheme.surface,
                        ),
                        const CoreProgressIndicator(),
                      ]
                    )
                  ),
              ]
            )
          )
        );
      }
    );
  }
}
