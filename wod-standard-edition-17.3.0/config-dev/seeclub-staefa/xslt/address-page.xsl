<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:fo="http://www.w3.org/1999/XSL/Format" 
  xmlns:bk="http://www.bkaiser.com/2017/ns/seeclub" version="1.0">
  
  <xsl:output method="xml" encoding="UTF-8"/>
  
  <xsl:variable name="debug" select="0"/>
  
  <xsl:attribute-set name="spm-letter">
    <xsl:attribute name="page-height">29.7cm</xsl:attribute>
    <xsl:attribute name="page-width">21cm</xsl:attribute>
    <xsl:attribute name="margin-left">25mm</xsl:attribute>
    <xsl:attribute name="margin-right">25mm</xsl:attribute>
    <xsl:attribute name="margin-top">25mm</xsl:attribute>
    <xsl:attribute name="margin-bottom">20mm</xsl:attribute>
  </xsl:attribute-set>


  <!-- Gesamtoutput -->
  <xsl:template match="bk:memberList">
    <fo:root>
      <fo:layout-master-set>
        <fo:simple-page-master master-name="A4" xsl:use-attribute-sets="spm-letter">
          <fo:region-body margin-bottom="16mm" margin-top="2.2cm" background-color="transparent"/>
          <fo:region-before region-name="header" extent="2cm"/>
          <fo:region-after region-name="footer" extent="14mm" display-align="after" background-color="transparent"/>
        </fo:simple-page-master>
      </fo:layout-master-set>
      <xsl:apply-templates select="bk:member"/>
    </fo:root>
  </xsl:template>


  <xsl:template name="generic-letter-helpers">
    <xsl:param name="address" select="false()"/>
    <fo:block/>
    <xsl:if test="$debug &gt; 0">
      <fo:block-container absolute-position="fixed" left="0mm" top="0mm" width="21cm" height="29.7cm">
        <fo:block font-size="0">
          <fo:instream-foreign-object>
            <svg 
              xmlns="http://www.w3.org/2000/svg" width="21cm" height="29.7cm" viewBox="0 0 210 297">
              <g style="stroke: black; stroke-width: 0.05; stroke-dasharray: 1,1;">
                <path d="M 0 25 L 210 25"/>
                <path d="M 0 277 L 210 277"/>
                <xsl:if test="$address">
                  <!-- Couvertfenster -->
                  <path d="M 0 55.5 L 210 55.5"/>
                  <path d="M 0 84 L 210 84"/>
                  <path d="M 118 0 L 118 297"/>
                </xsl:if>
                <path d="M 25 0 L 25 297"/>
                <path d="M 185 0 L 185 297"/>
              </g>
            </svg>
          </fo:instream-foreign-object>
        </fo:block>
      </fo:block-container>
      <xsl:if test="$address">
        <xsl:call-template name="address-window">
          <!--xsl:with-param name="left" select="'110mm'"/-->
        </xsl:call-template>
      </xsl:if>
    </xsl:if>
  </xsl:template>
  <xsl:attribute-set name="reserved-area-svg">
    <xsl:attribute name="style">fill:#ffcccc; fill-rule: evenodd;</xsl:attribute>
  </xsl:attribute-set>

  <xsl:variable name="address-window-height">45mm</xsl:variable>
  <xsl:variable name="address-window-usable-height">28.5mm</xsl:variable>
  <xsl:variable name="address-window-usable-width">64mm</xsl:variable>
  <xsl:template name="address-window">
    <xsl:param name="left" select="'12mm'"/>
    <xsl:param name="top" select="'44mm'"/>
    <fo:block-container absolute-position="fixed" width="100mm" height="{$address-window-height}" top="{$top}" left="{$left}">
      <fo:block font-size="0">
        <fo:instream-foreign-object content-width="100mm" content-height="{$address-window-height}">
          <svg 
            xmlns="http://www.w3.org/2000/svg" width="100mm" height="{$address-window-height}" viewBox="0 0 100 45">
            <g xsl:use-attribute-sets="reserved-area-svg">
              <path d="M 0 0 L 100 0 L 100 45 L 0 45 z M 8 11.5 L 8 40 L 72 40 L 72 11.5 z"/>
            </g>
          </svg>
        </fo:instream-foreign-object>
      </fo:block>
    </fo:block-container>
  </xsl:template>


  <!-- Rechnung -->
  <xsl:template match="bk:member">
    <fo:page-sequence master-reference="A4">

      <!-- Header -->
      <fo:static-content flow-name="header">
        <xsl:call-template name="generic-letter-helpers">
          <xsl:with-param name="address" select="true()"/>
        </xsl:call-template>
       <fo:block text-align="right" margin-bottom="1cm">
          <fo:external-graphic content-width="2.2in" scaling="uniform" src="url(../images/logo.svg)"/>
        </fo:block>

      </fo:static-content>

      <fo:flow flow-name="xsl-region-body">
		<fo:block-container absolute-position="absolute" top="11mm" width="100%">
		  <xsl:apply-templates select="bk:address"/>
		</fo:block-container>
		<fo:block space-before="4.4cm">
          <xsl:call-template name="letter-body"/>
		</fo:block>
      </fo:flow>
    </fo:page-sequence>
  </xsl:template>


  <xsl:attribute-set name="cell">
    <xsl:attribute name="padding">1mm</xsl:attribute>
<!--     <xsl:attribute name="border">solid 1pt</xsl:attribute>
 -->  </xsl:attribute-set>
  <xsl:attribute-set name="right">
    <xsl:attribute name="text-align">end</xsl:attribute>
  </xsl:attribute-set>

  <xsl:template match="bk:address">
    <fo:block font-size="8pt" margin-bottom="1em">Seeclub Stäfa, 8712 Stäfa</fo:block>
    <fo:block>
      <xsl:value-of select="bk:name"/>
    </fo:block>
        <fo:block>
      <xsl:value-of select="bk:name2"/>
    </fo:block>
    <fo:block>
      <xsl:value-of select="bk:street"/>
    </fo:block>
    <fo:block>
      <xsl:value-of select="bk:city"/>
    </fo:block>
  </xsl:template>  

    <xsl:template name="letter-body">
  </xsl:template>

</xsl:stylesheet>