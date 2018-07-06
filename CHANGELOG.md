# Changelog for CodeMetrics dart package

For a high level overview of what CodeMetrics is, please read [README.md](README.md)

## v1.0.0-alpha+1

* Fixed a typo in the name of executable. It spells `codemetrics` now. Command line usage: `pub global run codemetrics`
or `dart-codemetrics` if Pub's bin folder is added to PATH
* Update dependencies to be compatible with 2.0.0-dev.67.0

## v1.0.0-alpha - Prepping for pub release

## v0.0.2 - Dart 2 updates

## v0.0.1 - Initial release

**Please keep in mind, this is the first preview release of the software, things might break or might not function as intended**

 * support for calculating cyclomatic complexity of individual files or entire packages
 * support for configuration options for what is included in the complexity calculations
   * predefined configurations with similar settings to already known tools such as CodePro
 * export detailed and aggregated statistics to JSON
   * provides per-method/per-function detailed analysis
   * provides an aggregated statistics for all the methods/functions