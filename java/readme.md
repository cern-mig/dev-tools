Code Style
==========

The chosen code style is to use 4 spaces for indentation and no tabs at all.

The main source code must comply to our
[Checkstyle](http://checkstyle.sourceforge.net/)
configuration (see `checkstyle.xml`).

In addition, the test source code should also comply to it.

Generate Ant files from Maven
=============================

If the project contains Ant files such as `maven-build.xml` and `maven-build.properties`,
they can be updated by running:

```bash
mvn ant:ant
```

Generate documentation and upload it to GitHub Pages
====================================================

First you have to generate the package documentation:
```bash
# generate apidocs in target/site/apidocs/
mvn javadoc:javadoc
```

The documentation for this package is served by GitHub Pages.

The GitHub Maven plugin is used in order to automate the process of uploading
the documentation to the `gh-pages` branch of the repository.

For this reason, in order to proceed with the upload of the documentation
you should make sure that you have the proper configuration for the
GitHub Maven plugin (in your `~/.m2/settings.xml`).

You find the recipe in the plugin page:
https://github.com/github/maven-plugins

```bash
# upload it to gh-pages branch in github
mvn site
```

If the command executes successfully the updated documentation will
appear at this address, with a delay of 5-15 minutes:
http://cern-mig.github.io/project-name/.

Build a snapshot
================

Building a snapshot is as easy as running a single command when you have
proper configuration.

```bash
mvn clean package
```

Note: Sonatype does not support deploying snapshots anymore, see
[FAQ: Does the Portal support SNAPSHOT releases?](https://central.sonatype.org/faq/snapshot-releases/#does-the-portal-support-snapshot-releases).

Perform a release
=================

In order to release the package and get it synchronized with
the Central Maven repository follow the Sonatype guide:
[The Central Repository Documentation](https://central.sonatype.org/register/central-portal/).

If you have the proper configuration for Sonatype in your `~/.m2/settings.xml`
and it is not your first release then the release process can be summarized
with the following steps:

```bash
# make sure to clear any pending commit/push
# eventually you want to build a snapshot and test it
mvn clean deploy
# then proceed with the release steps
mvn release:clean
mvn release:prepare
mvn release:perform
```
