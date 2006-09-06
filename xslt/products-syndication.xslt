<xsl:stylesheet version = '1.0'
     xmlns:xsl='http://www.w3.org/1999/XSL/Transform'>

<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"
 doctype-public="-//W3C//DTD XHTML 1.1//EN"
 doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"
 />

<xsl:template match="/">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-US">
<head>
<title>Create a Great Personal Home Site</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body>
    <h2>
        <xsl:attribute name="id">
            <xsl:value-of select="//product-syndication/data/cat/@id" />
        </xsl:attribute>
        <xsl:value-of select="//product-syndication/data/cat/title" />
    </h2>
    <xsl:apply-templates mode="copy-no-ns" 
        select="//product-syndication/data/cat/desc/*" />
</body>
</html>
</xsl:template>

<xsl:template mode="copy-no-ns" match="*">
    <xsl:element name="{local-name()}">
        <xsl:copy-of select="@*"/>
        <xsl:apply-templates mode="copy-no-ns"/>
    </xsl:element>
</xsl:template>

</xsl:stylesheet>
