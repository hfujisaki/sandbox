<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xf="org.iguzhou.examples.xslt.ExtensionFunctions" exclude-result-prefixes="xf">

<xsl:template match="/">
 <html>
  <head>
   <style>
	th, td { padding: 3px 6px; }
	.name { background: pink; color: firebrick; }
	.format { background: lightgreen; color: darkgreen; }
	.unit { background: skyblue; color: midnightblue; }
	.value { background: khaki; color: saddlebrown; }
   </style>
  </head>
  <body>
   <table border="1" cellspacing="0">
    <tr>
     <th class="name">@name</th>
     <th class="format">@format</th>
     <th class="unit">@unit</th>
     <th class="value">text()</th>
    </tr>
    <xsl:apply-templates select="section"/>
   </table>
  </body>
 </html>
</xsl:template>

<xsl:template match="section">
 <tr>
  <td colspan="4"><xsl:value-of select="xf:name(.)"/></td>
  <xsl:apply-templates select="value"/>
  <xsl:apply-templates select="section"/>
 </tr>
</xsl:template>

<xsl:template match="value">
 <xsl:variable name="name" select="xf:name(.)"/>
 <xsl:variable name="spec" select="xf:spec($name)"/>
 
 <tr>
  <td class="name"><xsl:value-of select="$name"/></td>
  <td class="format"><xsl:value-of select="xf:format($spec)"/></td>
  <td class="unit"><xsl:value-of select="xf:unit($spec)"/></td>
  <td class="value"><xsl:value-of select="xf:value(text(), $spec)"/></td>
 </tr>
</xsl:template>

</xsl:stylesheet>