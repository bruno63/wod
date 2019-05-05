<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:fo="http://www.w3.org/1999/XSL/Format" 
  xmlns:bk="http://www.bkaiser.com/2018/ns/bkaiser" version="1.0">
  
  <xsl:import href="letter-base.xsl"/>

  <xsl:template match="bk:address">
    <fo:block>
      <xsl:value-of select="bk:name"/>
    </fo:block>
    <fo:block>
      <xsl:value-of select="bk:street"/>
    </fo:block>
    <fo:block>
      <xsl:value-of select="bk:city"/>
    </fo:block>
  </xsl:template>  
 
  <xsl:template name="letter-body">
    <fo:block space-before="2cm" margin-bottom="1em">          Stäfa, 
      <xsl:value-of select="../bk:date"/>
    </fo:block>
    <fo:block font-size="larger" font-weight="bold" space-after="2em">
      <xsl:value-of select="../bk:title"/>
    </fo:block>
    <fo:block margin-bottom="1em">
      <xsl:value-of select="bk:salutation"/>
    </fo:block>
    <fo:block margin-bottom="1em">
      <xsl:value-of select="bk:content"/>
    </fo:block>
    <fo:block margin-bottom="1em">
      <xsl:value-of select="../bk:greetings"/>
    </fo:block>
    <fo:block>
      <xsl:value-of select="../bk:senderOrg"/>
    </fo:block>
    <fo:block>
      <xsl:value-of select="../bk:senderPerson"/>
      <xsl:value-of select="../bk:senderFunction"/>
    </fo:block>
  </xsl:template>
</xsl:stylesheet>