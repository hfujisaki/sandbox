<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xf="org.iguzhou.examples.xslt.ExtensionFunctions" exclude-result-prefixes="xf">

<xsl:template match="section">
 <section>
  <xsl:attribute name="name">
   <xsl:call-template name="concat-names">
    <xsl:with-param name="parent" select="parent::*"/>
    <xsl:with-param name="name" select="@name"/>
    <xsl:with-param name="separator" select="'_'"/>
   </xsl:call-template>
  </xsl:attribute>
  <xsl:apply-templates select="value"/>
  <xsl:apply-templates select="section"/>
 </section>
</xsl:template>

<xsl:template match="value">
 <value>
  <xsl:attribute name="name">
   <xsl:call-template name="concat-names">
    <xsl:with-param name="parent" select="parent::*"/>
    <xsl:with-param name="name" select="@name"/>
    <xsl:with-param name="separator" select="'_'"/>
   </xsl:call-template>
  </xsl:attribute>
  <xsl:attribute name="format">
   <xsl:value-of select="@format"/>
  </xsl:attribute>
  <xsl:choose>
   <xsl:when test="@unit">
    <xsl:attribute name="unit">
     <xsl:value-of select="@unit"/>
    </xsl:attribute>
   </xsl:when>
  </xsl:choose>
  <xsl:value-of select="xf:value(text(), @format)"/>
 </value>
</xsl:template>

<xsl:template name="concat-names">
 <xsl:param name="parent"/>
 <xsl:param name="name"/>
 <xsl:param name="separator"/>
 
 <xsl:choose>
  <xsl:when test="$parent">
   <xsl:call-template name="concat-names">
    <xsl:with-param name="parent" select="$parent/parent::*"/>
    <xsl:with-param name="name" select="concat($parent/@name, $separator, $name)"/>
    <xsl:with-param name="separator" select="$separator"/>
   </xsl:call-template>
  </xsl:when>
  <xsl:otherwise>
   <xsl:value-of select="$name"/>
  </xsl:otherwise>
 </xsl:choose>
</xsl:template>

</xsl:stylesheet>