# Data Template for Digital Editions, with Continuous Quality Control

- Continuous quality control (CQC): [Overview of formal
  issues](https://scdh.github.io/edition-data-template-cx/)

- [Technical documentation (german)](resources/README.md)


This repository is a template for collections of TEI documents like
the
[tei-publisher-data-template](https://github.com/eeditiones/tei-publisher-data-template)
which it is based on, but it comes with automation of common processes
on top.

- validation of TEI documents against schema files (Relax NG and
  Schematron)

- human-readable reports of the Relax NG and the schematron validation
  generated continuously and published on gitlab/github pages on each
  push to the repository (i.e. continuous integration for TEI
  documents)

- automatic generation of an Expath-Package (XAR) on each push, if and
  only if the validation has been successful. The TEI documents can be
  transformed via XSLT before being assembled into the package.

- automatic deployment of the XAR package to a running eXist-db
  instance on each push, if and only if the validation has been
  successful. (WIP)
  
The automation is driven with Maven in order to make it platform
independent and to encapsulate jar management.

It runs in the CI/CD pipelines of gitlab runner, see
[.gitlab-ci.yml](.gitlab-ci.yml), and github actions, see
[workflows](.github/workflows/gh-pages.yml).


# License

Written in 2021, 2022 by Christian Lück

To the extent possible under law, the author(s) have dedicated all
copyright and related and neighboring rights to this software to the
public domain worldwide. This software is distributed without any
warranty.

You should have received a copy of the CC0 Public Domain Dedication
along with this software. If not, see
[http://creativecommons.org/publicdomain/zero/1.0/](http://creativecommons.org/publicdomain/zero/1.0/).
