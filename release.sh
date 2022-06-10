#!/bin/sh

# this makes a zip package of everything that belongs to the template

zip -r tei-data-template-cx-gitlab.zip .gitlab-ci.yml pom.xml resources/*

zip -r tei-data-template-cx-github.zip .github/* pom.xml resources/*
