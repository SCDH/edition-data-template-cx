# Data Template for Digital Editions, with Continuous Quality Control

- Continuous quality control (CQC): [Overview of formal
  issues](https://scdh.github.io/edition-data-template-cx/)


This repository is a template for collections of TEI documents like
the
[tei-publisher-data-template](https://github.com/eeditiones/tei-publisher-data-template)
which it is based on, but it comes with automation of common processes
on top.

- validation of TEI documents against schema files (Relax NG and
  Schematron). A patched version of the Xerces XML parser is used for
  validation, so that XIncludes with XPointers with bare names (IDs)
  are correctly expanded.

- [human-readable
  reports](https://scdh.github.io/edition-data-template-cx/) of the
  Relax NG and the schematron validation generated continuously and
  published on gitlab/github pages on each push to the repository
  (i.e. continuous integration for TEI documents)

- automatic generation of an Expath-Package (XAR) on each push, if and
  only if the validation has been successful. The TEI documents can be
  transformed via XSLT before being assembled into the package. The
  default transformation is simply the identity transformation.

- automatic deployment of the XAR package to a running eXist-db
  instance on each push, if and only if the validation has been
  successful. (WIP)
  
The automation is driven with Maven in order to make it platform
independent and to encapsulate jar management.

It runs in the CI/CD pipelines of gitlab runner, see
[.gitlab-ci.yml](.gitlab-ci.yml), and github actions, see
[workflows](.github/workflows/gh-pages.yml).


# Usage

To use this template, I suggest to download one of the zip files in the
current
[release](https://github.com/SCDH/edition-data-template-cx/releases)
and unzip it to your edition's root folder.

[Maven](https://maven.apache.org/) is required. Maven will install all
other required software (Saxon, etc.) on the first run.

Make the package:

```shell
mvn package
```

Generate the human-readable reports:

```shell
mvn test -l target/mvn.log || mvn compile
```

The package and the report will be in the `target` folder.

For running in CI/CD pipelines have a look at `.gitlab-ci.yml`
(gitlab) and `.github/workflows` (github). The presence of these files
will trigger pipelines on each push to the `main` branch.


All configuration can be done in the maven build file `pom.xml`. See
the comments in there and have a look at [technical documentation
(german)](resources/README.md) for details of adaption.

The file `resources/assembly.xml` determines which files go into the
xar package. You can set inclusion and exclusion patterns for TEI
documents there.


# Roadmap

- Automatic deployment on running eXist-db instance

- Replace Maven with Gradle, because Gradle is an incremental build
  system and DAG processor and speeds things up.

- Parse TEI documents for `model` PIs and use these for validation,
  use default schema if no PI present.

# License

Written in 2021, 2022 by Christian Lück

To the extent possible under law, the author(s) have dedicated all
copyright and related and neighboring rights to this software to the
public domain worldwide. This software is distributed without any
warranty.

You should have received a copy of the CC0 Public Domain Dedication
along with this software. If not, see
[http://creativecommons.org/publicdomain/zero/1.0/](http://creativecommons.org/publicdomain/zero/1.0/).
