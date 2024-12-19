/*
 * Software Name : OUDS Flutter
 * SPDX-FileCopyrightText: Copyright (c) Orange SA
 * SPDX-License-Identifier: MIT
 *
 * This software is distributed under the MIT license,
 * the text of which is available at https://opensource.org/license/MIT/
 * or see the "LICENSE" file for more details.
 *
 * Software description: Flutter library of reusable graphical components for Android and iOS
 */

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:ouds_flutter_demo/main_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AboutFileScreen extends StatefulWidget {
  final String title;
  final String fileMenuItem;
  final bool darkModeEnabled;

  const AboutFileScreen(
      {super.key,
      required this.title,
      required this.fileMenuItem,
      required this.darkModeEnabled});

  @override
  AboutFileScreenState createState() => AboutFileScreenState();
}

class AboutFileScreenState extends State<AboutFileScreen> {
  late WebViewController _webViewController;

  /// Padding
  final double horizontalPadding = 13.0;
  final double verticalPadding = 13.0;

  @override
  void initState() {
    super.initState();

    /// Initialize WebViewController
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent);

    /// Initialize WebView and load content
    _initializeWebView();
  }

  Future<void> _initializeWebView() async {
    String markdownContent = await _loadFileData();
    String htmlContent = markdownToHtml(markdownContent);

    /// Check if the widget is still mounted before using the context
    if (!mounted) return;

    /// Wrap the HTML content with necessary CSS
    String wrappedHtml = _wrapHtmlWithCss(
      htmlContent,
      widget.darkModeEnabled,
      Theme.of(context).colorScheme,
      horizontalPadding,
      verticalPadding,
    );

    /// Load HTML content into the WebViewController
    _webViewController.loadRequest(
      Uri.dataFromString(
        wrappedHtml,
        mimeType: 'text/html',
        encoding: Encoding.getByName('utf-8'),
      ),
    );
  }

  Future<String> _loadFileData() async {
    return await rootBundle.loadString(widget.fileMenuItem);
  }

  String markdownToHtml(String markdownContent) {
    List<String> lines = md.markdownToHtml(markdownContent).split('\n');
    return lines.join('');
  }

  String _wrapHtmlWithCss(
    String markdownContent,
    bool darkModeEnabled,
    ColorScheme colors,
    double horizontalPadding,
    double verticalPadding,
  ) {
    String fileContent = markdownToHtml(markdownContent);

    String darkStyle = '''
body {
    font-family: sans-serif;
    font-size: 14;
    background-color: #000000;
    color: #FFFFFF;
}

a:visited {
    color: #FFFFFF;
}

a:hover {
    color: #FFFFFF;
}

a:active, a:focus {
    color: #FFFFFF;
}

a:link {
    color: <<OdsTheme.colors.primary>>;
}
''';
    String lightStyle = '''
body {
    font-family: sans-serif;
    font-size: 14;
    background-color: #FFFFFF;
    color: #000000;
}

a:visited {
    color: #000000;
}

a:hover {
    color: #000000;
}

a:active, a:focus {
    color: #000000;
}

a:link {
    color: <<OdsTheme.colors.primary>>;
}
''';

    String themeStyle = darkModeEnabled ? lightStyle : darkStyle;

    String cssApple = '''<style ="text/css">
       html {
           font: -apple-system-body;
       }

      :root {
        color-scheme: ${darkModeEnabled ? 'light' : 'dark'};
        --title-color: ${colors.primary};
        --subhead-color: ${colors.secondary};
        --link-color: ${colors.primary};
        margin: ${verticalPadding}px ${horizontalPadding}px;
      }
      

      body {
        font-family: -apple-system, sans-serif;
      }

      h1 {
        font: -apple-system-short-headline;
        margin-top: 1em ;
        margin-bottom: 0.3em;
      }

      h2 {
        font: -apple-system-short-subheadline;
        margin-top: 1em;
        margin-bottom: 0.3em;
      }
      
      p {
        font: -apple-system-body;
      }

      footer {
        font-family: -apple-system-footnote;
      }

      a {
        color: var(--link-color);
        word-wrap: break-word;
      }

      a:link, a:visited {
        color: #FF7900;
        text-decoration: none;
      }

      a:hover, a:active, a:focus {
        color: #527EDB;
      }
        </style>''';
    String cssAndroid = '''<style ="text/css">
body {
    padding: 0;
    -webkit-text-size-adjust: none;
    margin: ${verticalPadding}px ${horizontalPadding}px;
}

h1 {
    font-size: 24;
    font-family: sans-serif;
    font-weight: bold;
    line-height: 100%;
    margin-top: 0.8em;
    margin-bottom: 0.5em ;
}

h2 {
    font-family: sans-serif;
    font-size: 20;
    line-height: 100%;
    letter-spacing: -0.3;
    font-weight: bold;
    margin-top: 1.5em ;
    margin-bottom: 0.3em ;
}

h3 {
    font-family: sans-serif;
    font-weight: bold;
    font-size: 16;
    margin-top: 1.2em ;
    margin-bottom: 0.8em ;
}

p, ul, li {
    font-weight: normal;
    font-size: 14;
    letter-spacing: 0.4;
    line-height: 1.6;
    font-family: sans-serif;
    margin-top: 0.3em ;
    margin-bottom: 0em ;
}

table {
  border-collapse: collapse;
  width: 98%;
}

th, td {
  padding: 0.2em;
}

a:link {
    font-weight: normal
    font-size: 15;
    text-decoration: underline;
}

      a:link, a:visited {
        color: #FF7900;
        text-decoration: none;
      }

      a:hover, a:active, a:focus {
        color: #527EDB;
      }
      
      a:visited {
    color: #FFFFFF;
}

a:hover {
    color: #FFFFFF;
}

a:active, a:focus {
    color: #FFFFFF;
}

a:link {
    color: <<OdsTheme.colors.primary>>;
}

        </style>''';

    String cssAndroidThemeStyle =
        cssAndroid.replaceFirst('</style>', '$themeStyle</style>');

    return convertToHtml(fileContent, cssApple, cssAndroidThemeStyle);
  }

  String convertToHtml(
      String partialHTMLText, String cssApple, String cssAndroid) {
    String head = """
    <!doctype html>
<meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'>
""";

    if (partialHTMLText.contains("<html")) {
      return partialHTMLText;
    }

    var result = "<html>";
    result += head;

    if (!kIsWeb) {
      if (Platform.isIOS) {
        result += cssApple;
      } else {
        if (Platform.isAndroid) {
          result += cssAndroid;
        }
      }
    }

    result += "</head>";

    if (partialHTMLText.contains("<body")) {
      result += partialHTMLText;
    } else {
      result += "<body><p dir=\"auto\">$partialHTMLText</p></body>";
    }

    result += "</html>";
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: widget.title, showBackButton: true),
      body: SafeArea(
        child: WebViewWidget(
          controller: _webViewController,
        ),
      ),
    );
  }
}
