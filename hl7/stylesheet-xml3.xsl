<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xf="org.iguzhou.examples.xslt.ExtensionFunctions" exclude-result-prefixes="xf">

<xsl:template match="section">
 <section name="{xf:name(.)}">
  <xsl:apply-templates select="value"/>
  <xsl:apply-templates select="section"/>
 </section>
</xsl:template>

<xsl:template match="value">
 <value name="{xf:name(.)}" format="{xf:format(.)}">
  <xsl:choose>
   <xsl:when test="@unit">
    <xsl:attribute name="unit">
     <xsl:value-of select="xf:unit(.)"/>
    </xsl:attribute>
   </xsl:when>
  </xsl:choose>
  <xsl:value-of select="xf:value(.)"/>
 </value>
</xsl:template>

</xsl:stylesheet>