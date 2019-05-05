<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns="http://www.jeremias-maerki.ch/ns/peax/metadata"
  xmlns:meta="http://www.jeremias-maerki.ch/ns/peax/metadata"
  xmlns:inv="http://www.jeremias-maerki.ch/ns/wod/generic-invoice/v1"
  xmlns:doc="http://www.jeremias-maerki.ch/ns/wod/document/v1"
  xmlns:func="http://exslt.org/functions"
  xmlns:exslt="http://exslt.org/common"
  xmlns:f="http://local-functions"
  exclude-result-prefixes="inv doc xlink f meta"
  extension-element-prefixes="func exslt">

  <xsl:output indent="yes"/>

  <xsl:param name="debug" select="0"/>
  <xsl:param name="receiverInvitationId"/>

  <xsl:template match="invoices">
    <xsl:apply-templates select="invoice[1]"/>
  </xsl:template>
  
  <xsl:template match="invoice">
    <invoice>
      <source>DIRECT</source>
      <title>
        <!--
          <xsl:text>[From WOD]&#x20;</xsl:text>
        -->
        <xsl:value-of select="esr/biller/name"/>
        <xsl:text>:&#x20;</xsl:text>
        <xsl:value-of select="../title"/>
      </title>
      <!--receivedAt><xsl:value-of select="inv:header/inv:document/inv:issue-date"/></receivedAt-->
      <language>de</language>
      
      <customerNumber><xsl:value-of select="member-number"/></customerNumber>
      <xsl:apply-templates select="esr/biller" mode="sender"/>
      <xsl:apply-templates select="esr/recipient" mode="receiver"/>
      <!-- base document done. -->
      
      <!-- invoice part -->
      <!--
      <invoiceDate><xsl:value-of select="inv:header/inv:document/inv:issue-date"/></invoiceDate>
      -->
      <invoiceNumber><xsl:value-of select="esr/custom-data"/></invoiceNumber>
      <totalAmount>
        <xsl:value-of select="esr/@amount"/>
      </totalAmount>
      <currency><xsl:value-of select="esr/@currency"/></currency>
      
      <xsl:apply-templates select="esr"/>
    </invoice>
  </xsl:template>

  <xsl:template match="biller" mode="sender">
    <!--
    <senderUid><xsl:value-of select="f:formatUID(inv:foreign-id)"/></senderUid>
    -->
    <senderName><xsl:value-of select="name"/></senderName>
    <senderZip><xsl:value-of select="zip"/></senderZip>
    <senderCity><xsl:value-of select="city"/></senderCity>
  </xsl:template>
  
  <xsl:template match="recipient" mode="receiver">
    <receiverPeaxId>
      <xsl:value-of select="ancestor::invoice/peax-id"/>
    </receiverPeaxId>
  </xsl:template>

<!--  
  <xsl:template match="esr" mode="paymentReceiver">
    <paymentReceiver>
      <xsl:value-of select="inv:name"/>
      <xsl:if test="inv:postal-address/inv:address-line[1]">
        <xsl:text>^</xsl:text>
        <xsl:value-of select="inv:postal-address/inv:address-line[1]"/>
      </xsl:if>
      <xsl:if test="inv:postal-address/inv:address-line[2]">
        <xsl:text>^</xsl:text>
        <xsl:value-of select="inv:postal-address/inv:address-line[2]"/>
      </xsl:if>
      <xsl:text>^</xsl:text>
      <xsl:value-of select="inv:postal-address/inv:zip"/>
      <xsl:text>&#x20;</xsl:text>
      <xsl:value-of select="inv:postal-address/inv:city"/>
      <xsl:if test="inv:postal-address/inv:country and not(inv:postal-address/inv:country = 'CH') and not(inv:postal-address/inv:country = 'Schweiz')">
        <xsl:text>^</xsl:text>
        <xsl:value-of select="inv:postal-address/inv:country"/>
      </xsl:if>      
    </paymentReceiver>
  </xsl:template>
  -->

  <xsl:template match="esr">
    <paymentDate><xsl:value-of select="execution-date"/></paymentDate>
    <xsl:choose>
      <xsl:when test="@ref">
        <paymentType>ESR</paymentType>
        <paymentAccountNumber><xsl:value-of select="@account"/></paymentAccountNumber>
        <paymentEsrReference><xsl:value-of select="@ref"/></paymentEsrReference>
      </xsl:when>
      <xsl:when test="inv:bank-account">
        <paymentType>EZ</paymentType>
        <paymentBankName><xsl:value-of select="bank/name"/></paymentBankName>
        <paymentIbanNumber><xsl:value-of select="biller/iban"/></paymentIbanNumber>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  
  <func:function name="f:formatUID">
    <xsl:param name="uid"/>
    <!-- See: http://www.bfs.admin.ch/bfs/portal/de/index/themen/00/05/blank/03/02.html -->
    <xsl:choose>
      <xsl:when test="starts-with($uid, 'CHE-')">
        <func:result select="$uid"/>
      </xsl:when>
      <xsl:otherwise>
        <func:result select="concat(substring($uid, 1, 3), '-', substring($uid, 4, 3), '.', substring($uid, 7, 3), '.', substring($uid, 10, 3))"/>
      </xsl:otherwise>
    </xsl:choose>
  </func:function>
  
  
</xsl:stylesheet>
