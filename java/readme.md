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
http://cern-mig.github.com/project-name/.

Build a snapshot
================

Sonatype Nexus is used for the package release, if you want to build
a snapshot first have a read at their guide:
[Sonatype OSS Maven Repository Usage Guide](http://docs.sonatype.org/display/Repository/Sonatype+OSS+Maven+Repository+Usage+Guide).

Building a snapshot is as easy as running a single command when you have
proper configuration.

```bash
mvn clean deploy
```

Perform a release
=================

In order to release the package and get it synchronized with
central Maven repo follow the Sonatype guide:
[Sonatype OSSRH Guide](http://central.sonatype.org/pages/ossrh-guide.html).

If you have the proper configuration for Sonatype and it is not your first
release then the release process can be summarized with the following steps:

```bash
# make sure to clear any pending commit/push
# eventually you want to build a snapshot and test it
mvn clean deploy
# then proceed with the release steps
mvn release:clean
mvn release:prepare
mvn release:perform
```

At this point follow point 8 of the Sonatype guide in order to confirm
the release and get it synchronized with central Maven repository.
