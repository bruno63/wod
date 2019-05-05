<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:fo="http://www.w3.org/1999/XSL/Format" 
  xmlns:bk="http://www.bkaiser.com/2018/ns/sise" version="1.0">
  <xsl:output method="xml" encoding="UTF-8"/>
  <!-- Gesamtoutput -->
  <xsl:template match="bk:memberList">
    <fo:root>
      <fo:layout-master-set>
        <fo:simple-page-master master-name="A4" page-height="29.7cm" page-width="21cm" margin="1.5cm">
          <fo:region-body region-name="body" margin-bottom="1cm" margin-top="5cm" />
          <fo:region-before region-name="header" extent="2cm" display-align="before" />
          <fo:region-after region-name="footer" extent="2cm" border-before-style="none" display-align="after" />
        </fo:simple-page-master>
      </fo:layout-master-set>
      <xsl:apply-templates select="bk:member"/>
    </fo:root>
  </xsl:template>
  <xsl:template match="bk:member">
    <fo:page-sequence master-reference="A4">
      <!-- Header with Logo -->
      <fo:static-content flow-name="header">
        <fo:block text-align="right" >
            <fo:external-graphic 
              height="1.5cm"
              content-width="scale-down-to-fit"
              src="url(sise:/images/logo.svg)" />
        </fo:block>
      </fo:static-content>
      <!-- Footer -->
      <fo:static-content flow-name="footer">
        <fo:table font-size="8pt" width="17cm" table-layout="fixed">
          <fo:table-column column-number="1" column-width="80mm"/>
          <fo:table-column column-number="2" column-width="80mm" />
          <fo:table-body>
            <fo:table-row>
              <fo:table-cell column-number="1" display-align="after">
                <fo:block>Schweizer Informatik Gesellschaft</fo:block>
                <fo:block>Fachgruppe Software Engineering</fo:block>
              </fo:table-cell>
              <fo:table-cell column-number="2" display-align="after" text-align="right">
              <fo:block>
                  <fo:inline text-decoration="underline">
                    <fo:basic-link>
                      <xsl:attribute name="external-destination">http://www.si-se.ch</xsl:attribute> www.si-se.ch                    
                    </fo:basic-link>
                  </fo:inline>
                </fo:block>
                <fo:block>
                  <fo:inline text-decoration="underline">
                    <fo:basic-link>
                      <xsl:attribute name="external-destination">mailto:registration@si-se.ch</xsl:attribute> registration@si-se.ch                    
                    </fo:basic-link>
                  </fo:inline>
                </fo:block>
              </fo:table-cell>
            </fo:table-row>
          </fo:table-body>
        </fo:table>
      </fo:static-content>
      <fo:flow flow-name="body">
        <!--fo:block text-align="right" margin-bottom="1cm">
          <fo:external-graphic content-width="1.7in" scaling="uniform" src="url(logo.svg)"/>
        </fo:block-->
        <fo:block space-after="1em">22. SI-SE Fachtagung</fo:block>
        <fo:block font-size="2em" font-weight="bold" space-after="2em">Anmeldebestätigung</fo:block>
        <fo:block font-weight="bold" space-after="1.5em">
          <xsl:value-of select="@name"/>
        </fo:block>
        <fo:block space-after="1em">hat sich zur folgenden Veranstaltung angemeldet:</fo:block>
        <fo:table table-layout="fixed" border-width="0.2mm" border-style="solid" width="100%">
          <fo:table-column column-number="1" column-width="5cm" xsl:use-attribute-sets="right"/>
          <fo:table-column column-number="2" column-width="10cm" />
          <fo:table-body>
            <fo:table-row >
              <fo:table-cell column-number="1" xsl:use-attribute-sets="cell">
                <fo:block>Veranstaltung</fo:block>
              </fo:table-cell>
              <fo:table-cell column-number="2" xsl:use-attribute-sets="cell">
                <fo:block>22. SI-SE Fachtagung</fo:block>
              </fo:table-cell>
            </fo:table-row>
            <fo:table-row>
              <fo:table-cell column-number="1" xsl:use-attribute-sets="cell">
                <fo:block>Veranstalter</fo:block>
              </fo:table-cell>
              <fo:table-cell column-number="2" xsl:use-attribute-sets="cell">
                <fo:block>Schweizer Informatik Gesellschaft SI</fo:block>
                <fo:block>Fachgruppe Software Engineering SI-SE</fo:block>
              </fo:table-cell>
            </fo:table-row>
            <fo:table-row>
              <fo:table-cell column-number="1" xsl:use-attribute-sets="cell">
                <fo:block>Module</fo:block>
              </fo:table-cell>
              <fo:table-cell column-number="2" xsl:use-attribute-sets="cell">
                <fo:block>
                <xsl:apply-templates/>
                </fo:block>
              </fo:table-cell>
            </fo:table-row>
            <fo:table-row>
              <fo:table-cell column-number="1" xsl:use-attribute-sets="cell">
                <fo:block>Teilnahmegebühr</fo:block>
              </fo:table-cell>
              <fo:table-cell column-number="2" xsl:use-attribute-sets="cell">
                <fo:block>
                  <xsl:value-of select="@amount"/> CHF
                </fo:block>
              </fo:table-cell>
            </fo:table-row>
            <fo:table-row>
              <fo:table-cell column-number="1" xsl:use-attribute-sets="cell">
                <fo:block>Thema</fo:block>
              </fo:table-cell>
              <fo:table-cell column-number="2" xsl:use-attribute-sets="cell">
                <fo:block>Artificial Intelligence meets Software Engineering</fo:block>
              </fo:table-cell>
            </fo:table-row>
            <fo:table-row>
              <fo:table-cell column-number="1" xsl:use-attribute-sets="cell">
                <fo:block>Ort</fo:block>
              </fo:table-cell>
              <fo:table-cell column-number="2" xsl:use-attribute-sets="cell">
                <fo:block>Universität Zürich</fo:block>
                <fo:block>Institut für Informatik</fo:block>
                <fo:block>Binzmühlestr. 14</fo:block>
                <fo:block>8050 Zürich</fo:block>
              </fo:table-cell>
            </fo:table-row>
          </fo:table-body>
        </fo:table>
        <fo:block space-before="2em">
          Es gelten die Teilnahmebedingungen auf der
          <fo:inline text-decoration="underline">
                    <fo:basic-link>
                      <xsl:attribute name="external-destination">https://ssl.hostpark.net/bkaiser.ch/si-se.ch/2017/registration.html</xsl:attribute> SI-SE Website                    
                    </fo:basic-link>
                  </fo:inline> 
        </fo:block>
        <fo:block>
          <xsl:if test="@paid">Zahlungseingang der Teilnahmegebühr am
            <xsl:value-of select="@date"/>.
          </xsl:if>
          <xsl:if test="@unpaid">Wir weisen Sie darauf hin, dass die Anmeldung erst nach eingegangener Zahlung der Teilnahmegebühr definitiv ist. Es ist nicht möglich, am Veranstaltungstag die Teilnahmegebühr zu zahlen.</xsl:if>
        </fo:block>
        <fo:block margin-bottom="3em" space-before="3em">Zürich, 
          <xsl:value-of select="../bk:date"/>
        </fo:block>
        <fo:block>Bruno Kaiser</fo:block>
        <fo:block>SI-SE, Präsident</fo:block>
      </fo:flow>
    </fo:page-sequence>
  </xsl:template>
  <xsl:template match="bk:category">
    <fo:block>
      <xsl:value-of select="@date" />, &#160;
      <xsl:value-of select="@name" />
    </fo:block>
  </xsl:template>
  <!--xsl:template match="bk:categoryList"><fo:table table-layout="fixed" inline-progression-dimension="100%"><fo:table-column column-width="proportional-column-width(1)"/><fo:table-column column-width="4cm"/><fo:table-header><fo:table-row><fo:table-cell xsl:use-attribute-sets="cell"><fo:block>Kategorie</fo:block></fo:table-cell><fo:table-cell xsl:use-attribute-sets="cell right"><fo:block>Betrag</fo:block></fo:table-cell></fo:table-row></fo:table-header><fo:table-body><xsl:apply-templates/><fo:table-row font-weight="bold"><fo:table-cell xsl:use-attribute-sets="cell"><fo:block>Total</fo:block></fo:table-cell><fo:table-cell xsl:use-attribute-sets="cell right"><fo:block><xsl:value-of select="format-number(sum(bk:category/@amount), 'CHF ###.00')"/></fo:block></fo:table-cell></fo:table-row></fo:table-body></fo:table></xsl:template-->
  <!--xsl:template match="bk:category"><fo:table-row><fo:table-cell xsl:use-attribute-sets="cell"><fo:block><xsl:value-of select="@name"/></fo:block></fo:table-cell><fo:table-cell xsl:use-attribute-sets="cell right"><fo:block><xsl:value-of select="format-number(@amount, 'CHF ###.00')" /></fo:block></fo:table-cell></fo:table-row></xsl:template-->
  <xsl:attribute-set name="cell">
    <xsl:attribute name="padding">1mm</xsl:attribute>
    <xsl:attribute name="border">solid 0.5pt</xsl:attribute>
    <!--xsl:attribute name="text-align">from-table-column('text-align')</xsl:attribute-->
  </xsl:attribute-set>
  <xsl:attribute-set name="right">
    <xsl:attribute name="text-align">end</xsl:attribute>
  </xsl:attribute-set>
</xsl:stylesheet>