<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:fo="http://www.w3.org/1999/XSL/Format" 
  xmlns:bk="http://www.bkaiser.com/2017/ns/seeclub" version="1.0">
  
  <xsl:import href="letter-base-seeclub.xsl"/>

  <xsl:template match="bk:address">
    <fo:block font-size="8pt" margin-bottom="1em">Seeclub Stäfa, 8712 Stäfa</fo:block>
    <fo:block>
      <xsl:value-of select="bk:greeting"/>
    </fo:block>
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
    <fo:block space-before="2cm" margin-bottom="1em"> 
      <xsl:value-of select="../bk:date"/>
    </fo:block>
    <fo:block font-size="larger" font-weight="bold" space-after="2em">
      <xsl:value-of select="../bk:title"/>
    </fo:block>
    <fo:block margin-bottom="1em">
      <xsl:value-of select="bk:salutation"/>
    </fo:block>
    <fo:block margin-bottom="1em">Dein diesjähriger Mitgliederbeitrag setzt sich wie folgt zusammen:</fo:block>
    <xsl:apply-templates select="bk:categoryList" />
    <fo:block margin-top="1em" margin-bottom="1em">Vielen Dank für die Begleichung der Rechnung 
      <fo:inline font-weight="bold">innert 30 Tagen</fo:inline> auf unser Konto bei der Zürcher Kantonalbank IBAN CH67 0070 0110 4044 7417 6. Bitte zwecks erleichterter Zuordnung den Mitgliedernamen angeben, falls der Name des Kontoinhabers nicht mit dem Mitgliedernamen überein stimmt.
    </fo:block>
    <fo:block margin-bottom="1em">
      <fo:inline font-weight="bold">Bitte keine Bareinzahlung am Postschalter,</fo:inline>
      das erspart dem Club einiges an Spesen.
    </fo:block>
    <fo:block margin-bottom="1em">Mit rudersportlichen Grüssen</fo:block>
    <fo:block>Seeclub Stäfa, Finanzen</fo:block>
    <fo:block margin-bottom="2em">Anne Weyden</fo:block>
    <fo:block>Adressmutationen (auch elektronische) bitte laufend mitteilen an           
      <fo:inline>
        <fo:basic-link>
          <xsl:attribute name="external-destination">mailto:barbara@bkaiser.ch</xsl:attribute>barbara@bkaiser.ch            
        </fo:basic-link>
      </fo:inline>        
    </fo:block>

  </xsl:template>

  <xsl:template match="bk:categoryList">
    <fo:table table-layout="fixed" inline-progression-dimension="100%">
      <fo:table-column column-width="proportional-column-width(1)"/>
      <fo:table-column column-width="4cm"/>
 <!--      <fo:table-header>
        <fo:table-row>
          <fo:table-cell xsl:use-attribute-sets="cell">
            <fo:block>Kategorie</fo:block>
          </fo:table-cell>
          <fo:table-cell xsl:use-attribute-sets="cell right">
            <fo:block>Betrag</fo:block>
          </fo:table-cell>
        </fo:table-row>
      </fo:table-header> -->
      <fo:table-body>
        <xsl:apply-templates/>
<!--       enable the following for Rudernde with more than 1 category, 
           disable it for Passive with ohnly one category.  
        <fo:table-row font-weight="bold">
          <fo:table-cell xsl:use-attribute-sets="cell">
            <fo:block>Total</fo:block>
          </fo:table-cell>
          <fo:table-cell xsl:use-attribute-sets="cell right">
            <fo:block>
              <xsl:value-of select="format-number(sum(bk:category/@amount), 'CHF ###.00')"/>
            </fo:block>
          </fo:table-cell>
        </fo:table-row> 
-->
      </fo:table-body>
    </fo:table>
  </xsl:template>
  <xsl:template match="bk:category">
    <!-- 
    use for several categories:
    <fo:table-row>
    use for single category (Passive)
    <fo:table-row font-weight="bold">
    -->
    <fo:table-row font-weight="bold">
      <fo:table-cell xsl:use-attribute-sets="cell">
        <fo:block>
          <xsl:value-of select="@name"/>
        </fo:block>
      </fo:table-cell>
      <fo:table-cell xsl:use-attribute-sets="cell right">
        <fo:block>
          <xsl:value-of select="format-number(@amount, 'CHF ###.00')" />
        </fo:block>
      </fo:table-cell>
    </fo:table-row>
  </xsl:template>

</xsl:stylesheet>