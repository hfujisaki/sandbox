<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xf="org.iguzhou.examples.xslt.ExtensionFunctions" exclude-result-prefixes="xf">

<xsl:template match="dataset">
  <xsl:apply-templates select="section[@name='A']"/>
</xsl:template>

<xsl:template match="section">
 <section name="{xf:name(.)}">
  <xsl:apply-templates/>
 </section>
</xsl:template>

<xsl:template match="value">
 <xsl:variable name="name" select="xf:name(.)"/>
 <xsl:variable name="spec" select="xf:spec($name)"/>
 <xsl:variable name="value" select="xf:value(text(), $spec)"/>
 
 <xsl:choose>
  <xsl:when test="$name and $value">
   <xsl:variable name="format" select="xf:format($spec)"/>
   <xsl:variable name="unit" select="xf:unit($spec)"/>
   
   <value name="{$name}" format="{$format}">
     <xsl:if test="$unit">
     <xsl:attribute name="unit">
      <xsl:value-of select="$unit"/>
     </xsl:attribute>
    </xsl:if>
    <xsl:value-of select="$value"/>
   </value>
  </xsl:when>
 </xsl:choose>
</xsl:template>
 
</xsl:stylesheet>