<?xml version="1.0" encoding="UTF-8"?>
<!-- Adjust values in expath-pkg.xml via XSLT -->
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:mvn="http://maven.apache.org/POM/4.0.0"
    exclude-result-prefixes="xs" xpath-default-namespace="http://expath.org/ns/pkg" version="3.0">

    <xsl:mode on-no-match="shallow-copy"/>

    <xsl:output method="xml" indent="yes"/>

    <xsl:param name="pom-file" as="xs:string" required="yes"/>

    <!-- Adjust version. -->
    <xsl:template match="package/@version">
        <xsl:attribute name="version" select="doc($pom-file)/mvn:project/mvn:version"/>
    </xsl:template>

</xsl:stylesheet>
