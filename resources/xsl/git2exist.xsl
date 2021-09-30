<?xml version="1.0" encoding="UTF-8"?>
<!-- Transformation to be run on TEI sources before packaging them for on exist-db/TEI-publisher.

    This transformation

    - replaces XInclude with the referenced target.

-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xi="http://www.w3.org/2001/XInclude"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" version="3.0" exclude-result-prefixes="xi">

    <xsl:mode on-no-match="shallow-copy"/>

    <!-- FIXME: the oasis catalog file is not used for transformations by xml-maven-plugin. So we hard-wire the uris here. -->
    <xsl:param name="vocabulary-uri-re" required="false" select="'[Vv]o[ck]abulary?.xml'"/>

    <xsl:param name="vocabulary-file" required="false" select="'../../Vokabular.xml'"/>

    <!-- replace XInclude with referenced target -->

    <xsl:template match="xi:include[@xpointer][matches(@href, $vocabulary-uri-re)]">
        <xsl:message>Replaces XInclude: <xsl:value-of select="@xpointer"/></xsl:message>
        <xsl:variable name="bare-name" select="@xpointer"/>
        <xsl:apply-templates select="doc($vocabulary-file)//*[@xml:id eq $bare-name]"/>
    </xsl:template>

    <xsl:template match="xi:include[@xpointer][10]">
        <xsl:variable name="bare-name" select="@xpointer"/>
        <xsl:apply-templates select="doc(@href)/descendant::*[@xml:id eq $bare-name]"/>
    </xsl:template>


</xsl:stylesheet>
