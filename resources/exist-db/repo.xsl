<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://exist-db.org/xquery/repo"
    xpath-default-namespace="http://exist-db.org/xquery/repo" exclude-result-prefixes="xs"
    version="3.0">

    <xsl:mode on-no-match="shallow-copy"/>

    <xsl:output method="xml" indent="yes"/>

    <xsl:param name="permissions" as="xs:string" required="no" select="''"/>

    <xsl:param name="permission-sep" as="xs:string" required="no" select="'\|'"/>

    <xsl:param name="permission-attributes-sep" as="xs:string" required="no" select="','"/>

    <xsl:param name="remove-permissions" as="xs:boolean" required="no" select="true()"/>

    <xsl:template match="permissions[$remove-permissions]"/>

    <xsl:template match="meta">
        <meta>
            <xsl:apply-templates/>
            <xsl:for-each select="tokenize($permissions, $permission-sep)">
                <xsl:variable name="attributes" select="tokenize(., $permission-attributes-sep)"/>
                <xsl:choose>
                    <xsl:when test="count($attributes) eq 4">
                        <permissions
                            xmlns="http://exist-db.org/xquery/repo"
                            user="{$attributes[1]}"
                            group="{$attributes[2]}"
                            password="{$attributes[3]}"
                            mode="{$attributes[4]}"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:message terminate="yes">
                            <xsl:text>Not enough information provided for user permissions: "</xsl:text>
                            <xsl:value-of select="."/>
                            <xsl:text>". Need "user,group,password,mode"</xsl:text>
                        </xsl:message>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
        </meta>
    </xsl:template>

</xsl:stylesheet>
