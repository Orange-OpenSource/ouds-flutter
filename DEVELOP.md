# Developer guide

## Documentation

OUDS Flutter documentation is generated using [Dart documentation generator](https://pub.dev/packages/dartdoc).
Open the `ouds-flutter/library/doc/api` directory.

More technical information about Dart documentation generator is available [here](https://pub.dev/packages/dartdoc)

## Installation

The `dart` tool, with the `dart doc` command, is part of the Dart SDK.

### Generating Docs

Run `dart doc .` from the `library/doc/api` directory of the package. You must first run `dart pub get` or `flutter pub get`, and your package must analyze without errors with `dart analyze` or `flutter analyze` as appropriate. Here's an example of `dartdoc` documenting itself:

```bash
$ dart doc .
```

By default, the documentation is generated to the doc/api directory as static HTML files.

To view the generated documentation, you must load them with an HTTP server. To learn more, follow the Viewing docs guide.

Run dart help doc to see the available command-line options.

### Viewing docs
To enable navigation and search, the generated docs must be served with an HTTP server.

An easy way to run an HTTP server locally is to use package:dhttpd. For example:

```bash
$ dart pub global activate dhttpd
$ dart pub global run dhttpd --path doc/api
```

To then read the generated docs in your browser, open the link that dhttpd outputs, usually http://localhost:8080.

