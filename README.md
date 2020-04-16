# Codemetrics

Codemetrics for [Dart](https://www.dartlang.org/) is a simple command line utility providing some
insight into the "quality" of code by using static analysis of the code to calculate [cyclomatic complexity](https://en.wikipedia.org/wiki/Cyclomatic_complexity) value

## How to use

For now, there is no pub package for this project, so you have to clone it
```
git clone https://github.com/alexZaicev/codemetrics.git
cd codemetrics
pub get

dart bin/codemetrics.dart --root=[YOUR PACKAGE ROOT] 
```
Internally, [Codemetrics for Dart](https://github.com/daniel-v/codemetrics) uses [glob](https://pub.dartlang.org/packages/glob) package to find dart files within the *--analysis-root*
folder with the `**.dart` glob. It will exclude all dart files in:
 * packages
 * .pub

directories.

You can also install it as a global package:

```
pub global activate --source git https://github.com/daniel-v/codemetrics.git
```

Executable name is `codemetrics`

## Options

Codemetrics has several options that can be used:
 * --root - package root containing modules with dart files to analyse
 * --output - report output directory location
 * --format - report format ['HTML', 'JSON'] (default is HTML)


