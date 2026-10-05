<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="UTF-8" indent="yes"/>

  <xsl:param name="otsi-nimi" select="''"/>
  <xsl:param name="pikkus-piir" select="''"/>

  <xsl:template match="/">
    <html>
      <head>
        <title>Kuninganna Elizabeth II sugupuu</title>
        <style>
          body { font-family: Arial, sans-serif; margin: 20px; background-color: #fdfdfd; color: #333; }
          table { border-collapse: collapse; width: 100%; margin-top: 20px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
          th, td { border: 1px solid #ddd; padding: 10px; text-align: left; }
          th { background-color: #2c3e50; color: white; }
          tr:nth-child(even) { background-color: #f9f9f9; }
          .roheline { background-color: #d4edda !important; }
          .sektsioon { background: white; padding: 20px; margin-bottom: 25px; border-radius: 5px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); }
          form { background: #f1f2f6; padding: 15px; border-radius: 5px; margin-bottom: 15px; display: inline-block; margin-right: 15px; }
          input[type="text"] { padding: 6px; border: 1px solid #ccc; border-radius: 3px; }
          input[type="submit"] { background: #2c3e50; color: white; border: none; padding: 7px 15px; border-radius: 3px; cursor: pointer; }
          input[type="submit"]:hover { background: #34495e; }
        </style>
      </head>
      <body>
        <h1>Kuninganna Elizabeth II sugupuu</h1>

        <div class="sektsioon">
          <h2>Otsing ja filtreerimine</h2>
          <form method="get">
            <label><strong>Otsi nime järgi:</strong></label><br/><br/>
            <input type="text" name="otsi-nimi" value="{$otsi-nimi}"/>
            <input type="submit" value="Otsi"/>
          </form>

          <form method="get">
            <label><strong>Maksimaalne pikkus:</strong></label><br/><br/>
            <input type="text" name="pikkus-piir" value="{$pikkus-piir}"/>
            <input type="submit" value="Filtreeri"/>
          </form>
        </div>

        <div class="sektsioon">
          <h2>1. Kõikide inimeste sünniaastad</h2>
          <ul>
            <xsl:for-each select="//inimene">
              <li>
                <strong><xsl:value-of select="@nimi"/></strong> – <xsl:value-of select="@sünniaasta"/>
              </li>
            </xsl:for-each>
          </ul>
        </div>

        <div class="sektsioon">
          <h2>2. Inimesed, kellel on vähemalt kaks last</h2>
          <ul>
            <xsl:for-each select="//inimene[count(inimene) &gt;= 2]">
              <li>
                <strong><xsl:value-of select="@nimi"/></strong> (Laste arv: <xsl:value-of select="count(inimene)"/>)
              </li>
            </xsl:for-each>
          </ul>
        </div>

        <div class="sektsioon">
          <h2>3. Sugupuu koondtabel</h2>
          <table>
            <tr>
              <th>Nimi</th>
              <th>Sünniaasta</th>
              <th>Vanem</th>
              <th>Vanavanem</th>
              <th>Lapse vanus (kui pole järglasi)</th>
              <th>Mitmendal vanema sünniaastal sündis</th>
            </tr>
            <xsl:for-each select="//inimene">
              <xsl:if test="($otsi-nimi = '' or contains(@nimi, $otsi-nimi)) and ($pikkus-piir = '' or string-length(@nimi) &lt;= $pikkus-piir)">
                <tr>
                  <td>
                    <xsl:attribute name="class">
                      <xsl:if test="string-length(@nimi) &lt; 7">roheline</xsl:if>
                    </xsl:attribute>
                    <xsl:value-of select="@nimi"/>
                  </td>

                  <td><xsl:value-of select="@sünniaasta"/></td>

                  <td>
                    <xsl:choose>
                      <xsl:when test="parent::inimene">
                        <xsl:value-of select="parent::inimene/@nimi"/>
                      </xsl:when>
                      <xsl:otherwise>-</xsl:otherwise>
                    </xsl:choose>
                  </td>

                  <td>
                    <xsl:choose>
                      <xsl:when test="parent::inimene/parent::inimene">
                        <xsl:value-of select="parent::inimene/parent::inimene/@nimi"/>
                      </xsl:when>
                      <xsl:otherwise>-</xsl:otherwise>
                    </xsl:choose>
                  </td>

                  <td>
                    <xsl:choose>
                      <xsl:when test="not(inimene)">
                        <xsl:value-of select="2026 - @sünniaasta"/> aastat
                      </xsl:when>
                      <xsl:otherwise>-</xsl:otherwise>
                    </xsl:choose>
                  </td>

                  <td>
                    <xsl:choose>
                      <xsl:when test="parent::inimene">
                        <xsl:value-of select="@sünniaasta - parent::inimene/@sünniaasta"/>
                      </xsl:when>
                      <xsl:otherwise>-</xsl:otherwise>
                    </xsl:choose>
                  </td>
                </tr>
              </xsl:if>
            </xsl:for-each>
          </table>
        </div>

      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
//dsadwd