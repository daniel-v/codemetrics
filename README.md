# Codemetrics

Codemetrics for [Dart](https://www.dartlang.org/) is a simple command line utility that provides some
insight into the "quality" of code.

It uses static analysis of the code to determine:
 * [cyclomatic complexity](https://en.wikipedia.org/wiki/Cyclomatic_complexity)

and provides different reporting serialization formats:
 * json
 * html

**WARNING:** This is a pre-alpha development preview of what is to become a
more feature-complete code-analysis toolset.

## How to use

For now, there is no pub package for this project, so you have to clone it
```
git clone https://github.com/daniel-v/codemetrics.git
cd codemetrics
pub get
cd bin; dart codemetrics.dart --analysis-root=/path/to/your/package
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

Executable name is `dart-codemetrics`

### Reporting options

For *html* output use the *--report-format=html* and for JSON use *--report-format=json*.
A full command could look like this:

`dart bin/codemetrics.dart --analysis-root=/path/to/your/package --report-format=html > /tmp/test.html`

## Looking for contributors

There are number of areas you can contribute to this project:
 * code reviews: I always welcome criticism to my code, esp. when it comes to the analysis package
 * documentation: the code is mostly undocumented
 * tests: there are little if any tests written for this package
 * funtionality: if you feel contributing with some functionality, let me know!



