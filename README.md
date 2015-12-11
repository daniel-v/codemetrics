# Codemetrics

Codemetrics for Dart is a simple command line utility that provides some
insight into the "quality" of code.

It uses static analysis of the code to determine:
 * cyclomatic complexity

and provides different reporting serialization formats:
 * json
 * html

**WARNING:** This is a pre-alpha development preview of what is to become a
more feature-complete code-analysis toolset.

## How to use

For now, there is no pub package for this project, so you have to clone the project
```
git clone THISPROJECTURL
dart bin/main.dart --analysis-root=/path/to/your/package
```
Internally, the package uses *glob* package to find dart files withing the *--analysis-root*
folder with the `**.dart` glob. It will exclude all dart files in:
 * packages
 * .pub

directories.

### Reporting options

For *html* output use the *--report-format=html* and for JSON use *--report-format=json*.
A full command could look like this:
`dart bin/main.dart --analysis-root=/path/to/your/package --report-format=html > /tmp/test.html`

## Looking for contributors

There are number of areas you can contribute to this project:
 * code reviews: I always welcome criticism to my code, esp. when it comes to the analysis package
 * documentation: the code is mostly undocumented
 * tests: there are little if any tests written for this package
 * funtionality: if you feel contributing with some functionality, let me know!



