# Developer Guide

- [Technical Preconditions](#technical-preconditions)
  * [Dependency Management](#dependency-management)
  * [Generation of Localization Files in the app and ouds_core Folders](#generation-of-localization-files-in-the-app-and-ouds_core-folders)
- [Commits, Changelog, Release Notes, Versioning](#commits-changelog-release-notes-versioning)
  * [Commit Guidelines](#commit-guidelines)
  * [Release Notes and Changelog](#release-notes-and-changelog)
- [Documentation](#documentation)
- [Installation](#installation)
  * [Generating Docs](#generating-docs)

## Technical Preconditions

You can refer to the **THIRD_PARTY.md** file, which lists the dependencies and tools we use at different levels (SDK, design system toolbox app, and projects).
Check the lock files (*pubspec* and *pubspec.lock*) to see which versions are being used.

### Dependency Management

The project uses **Pub Workspace** via [Pub Workspaces](https://dart.dev/tools/pub/workspaces).

The `pubspec.yaml` file at the root of the project manages all dependencies, so please use the following commands at the root to clean up the dependencies:

```bash
flutter clean
flutter pub get
```

### Generation of Localization Files in the `app` and `ouds_core` Folders
To generate the localization files for the project, use the `flutter gen-l10n` command for each folder (`app` and `ouds_core`).

You need to run this command because it generates the necessary localization files for your project, which helps Flutter manage translations for multiple languages. These files are crucial for the app to properly support localization and internationalization.

```bash
flutter gen-l10n
```

## Commits, Changelog, Release Notes, Versioning

### Commit Guidelines

#### Conventional Commit Rules

Please make every effort to follow [conventional commit rules](https://www.conventionalcommits.org/en/v1.0.0/). 
Ensure that your commits are properly prefixed and include the issue number in parentheses at the end. If applicable, also include the pull request issue number.
If your commit includes contributions from others, don't forget to [add them as co-authors](https://docs.github.com/en/pull-requests/committing-changes-to-your-project/creating-and-editing-commits/creating-a-commit-with-multiple-authors).
All contributors should also comply with the DCO.

Your commit messages should be prefixed with the following keywords (as specified in the [commit specification](https://www.conventionalcommits.org/en/v1.0.0/#specification)):
- `fix:`
- `feat:`
- `build:`
- `chore:`
- `ci:`
- `docs:`
- `style:`
- `refactor:`
- `perf:`
- `test:`

You can also add `!` after the keyword to indicate a breaking change, and include a scope in parentheses like:
- `feat!:` breaking change because...
- `feat(API)!:` breaking change in the API because...
- `feat:` adding a new feature to the API...

#### Chain of Responsibility

We can include metadata from [this guideline](https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst#n525) in the commit messages.
This is not mandatory (yet), but it's a good practice to indicate who reviewed and validated each commit.
You must mention *co-authors* (using `Co-authored-by`), and you should include who are the code reviewers (`Reviewed-by`), testers (`Tested-by`), and if needed, ackers (`Acked-by`).

### Release Notes and Changelog

We also aim to [keep a changelog](https://keepachangelog.com/en/1.0.0/) and apply [semantic versioning](https://semver.org/spec/v2.0.0.html) along with [conventional commits](https://www.conventionalcommits.org/en/v1.0.0/).

## Documentation

OUDS Flutter documentation is generated using the [Dart documentation generator](https://pub.dev/packages/dartdoc).
Open the `ouds-flutter/library/doc/api` directory.

More technical information about Dart documentation generation is available [here](https://pub.dev/packages/dartdoc).

## Installation

The `dart` tool, with the `dart doc` command, is part of the Dart SDK.

### Generating Docs

Run `dart doc .` from the `library/doc/api` directory of the package. You must first run `dart pub get` or `flutter pub get`, and your package must analyze without errors using `dart analyze` or `flutter analyze` as appropriate. Here's an example of `dartdoc` documenting itself:

```bash
$ dart doc .
