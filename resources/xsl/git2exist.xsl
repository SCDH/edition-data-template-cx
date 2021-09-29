<?xml version="1.0" encoding="UTF-8"?>
<!-- Transformation to be run on TEI sources before putting them on exist-db/TEI-publisher.
    
    This transformation
    
    - replaces XInclude with the referenced target.
    
    - adds basic metadata from the documents content
    
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:xi="http://www.w3.org/2001/XInclude" xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    version="3.0" exclude-result-prefixes="xi">

    <xsl:mode on-no-match="shallow-copy"/>

    <!-- replace XInclude with referenced target -->

    <xsl:template match="xi:include[@xpointer]">
        <xsl:variable name="bare-name" select="@xpointer"/>
        <xsl:apply-templates select="doc(@href)/descendant::*[@xml:id eq $bare-name]"/>
    </xsl:template>


    <!-- FIXME: the oasis catalog file is not used by xml-maven-plugin. So we hard-wire the uris here. -->
    <xsl:param name="vocabulary-uri-re" required="false"
        select="'https://zivgitlab.uni-muenster.de/ALEA/Vo[ck]abulary?.xml'"/>

    <xsl:param name="vocabulary-file" required="false" select="'../../Vokabular.xml'"/>

    <xsl:template match="xi:include[matches(@href, $vocabulary-uri-re)]">
        <xsl:variable name="bare-name" select="@xpointer"/>
        <xsl:apply-templates select="doc($vocabulary-file)/descendant::*[@xml:id eq $bare-name]"/>
    </xsl:template>

    <!-- add metadata -->

    <!-- title and author -->

    <xsl:template match="titleStmt">
        <titleStmt>
            <xsl:choose>
                <xsl:when test="not(child::title) or child::title eq ''">
                    <title>
                        <xsl:value-of select="normalize-space(/TEI/text//head[1])"/>
                    </title>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:copy-of select="title"/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:if test="not(child::author) or child::author eq ''">
                <author>ابن نباتة</author>
            </xsl:if>
            <xsl:apply-templates select="node() except title"/>
        </titleStmt>
    </xsl:template>

</xsl:stylesheet>
