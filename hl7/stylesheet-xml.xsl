<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xf="org.iguzhou.examples.xslt.ExtensionFunctions" exclude-result-prefixes="xf">

<xsl:template match="dataset">
 <xsl:apply-templates select="section[@name='A']">
  <xsl:with-param name="flag" select="true()"/>
 </xsl:apply-templates>
 <xsl:apply-templates select="section[@name='Z']">
  <xsl:with-param name="flag" select="false()"/>
 </xsl:apply-templates>
</xsl:template>

<xsl:template match="section">
 <xsl:param name="flag"/>
 
 <xsl:choose>
  <xsl:when test="$flag">
   <section name="{xf:name(.)}">
    <xsl:apply-templates>
     <xsl:with-param name="flag" select="$flag"/>
    </xsl:apply-templates>
   </section>
  </xsl:when>
  <xsl:otherwise>
   <xsl:apply-templates>
    <xsl:with-param name="flag" select="$flag"/>
   </xsl:apply-templates>
  </xsl:otherwise>
 </xsl:choose>
</xsl:template>

<xsl:template match="value">
 <xsl:param name="flag"/>
 
 <xsl:variable name="name" select="xf:name(.)"/>
 <xsl:variable name="spec" select="xf:spec($name)"/>
 <xsl:variable name="value" select="xf:value(text(), $spec)"/>
 
 <xsl:value-of select="xf:dump($name, $value, $flag)"/>
 
 <xsl:if test="$name and $value">
  <xsl:variable name="format" select="xf:format($spec)"/>
  <xsl:variable name="unit" select="xf:unit($spec)"/>
  
  <xsl:choose>
   <xsl:when test="$flag">
    <value name="{$name}" format="{$format}">
     <xsl:if test="$unit">
      <xsl:attribute name="unit">
       <xsl:value-of select="$unit"/>
      </xsl:attribute>
     </xsl:if>
     <xsl:value-of select="$value"/>
    </value>
   </xsl:when>
   <xsl:otherwise>
    <xsl:value-of select="xf:extract(.)"/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:if>
</xsl:template>
 
</xsl:stylesheet>