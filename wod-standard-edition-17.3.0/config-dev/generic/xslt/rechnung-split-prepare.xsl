<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:split="http://www.jeremias-maerki.ch/ns/wod/xml/split">

  <xsl:template match="invoices">
    <split:split>
      <split:group>
        <invoices>
          <xsl:apply-templates select="invoiceDate|paymentDate|title"/>
          <split:insert-point/>
        </invoices>
      </split:group>
      <xsl:apply-templates select="invoice"/>
    </split:split> 
  </xsl:template>
  
  <xsl:template match="invoice">
    <split:document>
      <xsl:copy>
        <xsl:apply-templates select="@*|node()"/>
      </xsl:copy>
    </split:document>
  </xsl:template>

  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>
  
</xsl:stylesheet>
