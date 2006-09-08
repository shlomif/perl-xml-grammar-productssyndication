<xsl:stylesheet version = '1.0'
     xmlns:xsl='http://www.w3.org/1999/XSL/Transform'
     xmlns="http://www.w3.org/1999/xhtml">

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
    <xsl:apply-templates select="//product-syndication/data/cat" />
</body>
</html>
</xsl:template>

<xsl:template match="cat">
    <div class="prod_cat">
        <xsl:attribute name="id">
            <xsl:value-of select="@id" />
        </xsl:attribute>
    <xsl:element name="h{count(ancestor-or-self::cat)+1}">
        <xsl:value-of select="title" />
    </xsl:element>
    <xsl:apply-templates mode="copy-no-ns" 
        select="desc/*" />
    <xsl:apply-templates select="prod|cat" />
    </div>
</xsl:template>

<xsl:template match="prod">
    <div class="prod">
        <xsl:attribute name="id"><xsl:value-of select="@id" /></xsl:attribute>
        <div class="head">
            <p class="prod_img">
                <xsl:element name="a">
                    <xsl:attribute name="href">
                        <xsl:text>http://www.amazon.com/exec/obidos/ASIN/</xsl:text>
                        <xsl:value-of select="isbn" />
                        <xsl:text>/ref=nosim/shlomifishhom-20/</xsl:text>
                    </xsl:attribute>
                    <xsl:element name="img">
                        <xsl:attribute name="alt">
                            <xsl:text>Preview</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="src">
                            <xsl:text>images/</xsl:text>
                            <xsl:value-of select="@id" />
                            <xsl:text>.jpg</xsl:text>
                        </xsl:attribute>
                    </xsl:element>
                </xsl:element>
            </p>
            <p class="prod_title">
                <xsl:element name="a">
                    <xsl:attribute name="href">
                        <xsl:text>http://www.amazon.com/exec/obidos/ASIN/</xsl:text>
                        <xsl:value-of select="isbn" />
                        <xsl:text>/ref=nosim/shlomifishhom-20/</xsl:text>
                    </xsl:attribute>
                    <xsl:value-of select="title" />
                </xsl:element>                    
            </p>
        </div>
        <div class="desc">
            <xsl:apply-templates mode="copy-no-ns"
                select="desc/*" />
        </div>
    </div>
</xsl:template>
<xsl:template mode="copy-no-ns" match="*">
    <xsl:element name="{local-name()}">
        <xsl:copy-of select="@*"/>
        <xsl:apply-templates mode="copy-no-ns"/>
    </xsl:element>
</xsl:template>

</xsl:stylesheet>
