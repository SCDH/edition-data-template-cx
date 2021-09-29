<?xml version="1.0" encoding="UTF-8"?>
<!-- Parse maven output line by line and put it into XML.

USAGE: java -jar saxon.jar -xsl:resources/xsl/mvn2xml.xsl -it:start
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">

    <xsl:param name="mvnlog" select="'../../target/mvn.log'"/>

    <xsl:output method="xml" indent="yes"/>

    <xsl:template name="start">
        <log>
            <xsl:variable name="content" select="unparsed-text($mvnlog)"/>
            <xsl:for-each select="tokenize($content, '\n')">
                <xsl:variable name="log-entry" select="."/>
                <xsl:variable name="entry" select="replace($log-entry, '^\[[A-Z]+\] ?', '')"/>
                <xsl:analyze-string select="." regex="^\[[A-Z]*\]">
                    <xsl:matching-substring>
                        <xsl:variable name="level" select="translate(., '[]', '')"/>
                        <!-- We need a regex for used file names here! This may need adaption. TODO -->
                        <xsl:analyze-string select="$entry" regex="While parsing [a-zA-Z0-9/_.:-]+">
                            <xsl:matching-substring>
                                <xsl:variable name="file" select="replace(., '^While parsing ', '')"/>
                                <entry level="{$level}" document="{$file}">
                                    <xsl:value-of select="$entry"/>
                                </entry>
                            </xsl:matching-substring>
                            <xsl:non-matching-substring>
                                <!-- FIXME: Why does this go into the output, when regex is not matched? -->
                                <entry level="{$level}">
                                    <xsl:value-of select="$entry"/>
                                </entry>
                            </xsl:non-matching-substring>
                        </xsl:analyze-string>
                    </xsl:matching-substring>
                    <xsl:non-matching-substring/>
                </xsl:analyze-string>
            </xsl:for-each>
        </log>
    </xsl:template>

</xsl:stylesheet>
