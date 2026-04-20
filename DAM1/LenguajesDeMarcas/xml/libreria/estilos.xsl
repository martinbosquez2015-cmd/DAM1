<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">

<html>
<head>
    <title>Librería de Anime</title>
    <style>
        body { font-family: Arial; background: #111; color: white; }
        h1 { text-align: center; }
        table { width: 90%; margin: auto; border-collapse: collapse; }
        th, td { border: 1px solid #555; padding: 10px; text-align: center; }
        th { background-color: #333; }
        .alta { color: lightgreen; font-weight: bold; }
        .media { color: orange; }
        .baja { color: red; }
    </style>
</head>

<body>

<h1>📺 Librería de Anime</h1>

<table>
<tr>
    <th>Título</th>
    <th>Año</th>
    <th>Episodios</th>
    <th>Estado</th>
    <th>Valoración</th>
</tr>

<xsl:for-each select="libreria/anime">
    
    <!-- ORDENACIÓN por título -->
    <xsl:sort select="titulo" order="ascending"/>

    <tr>
        <td><xsl:value-of select="titulo"/></td>
        <td><xsl:value-of select="anio"/></td>
        <td><xsl:value-of select="episodios"/></td>
        <td><xsl:value-of select="estado"/></td>

        <td>
            <!-- CONDICIONAL -->
            <xsl:choose>
                <xsl:when test="valoracion &gt;= 9">
                    <span class="alta">
                        <xsl:value-of select="valoracion"/>
                    </span>
                </xsl:when>

                <xsl:when test="valoracion &gt;= 8">
                    <span class="media">
                        <xsl:value-of select="valoracion"/>
                    </span>
                </xsl:when>

                <xsl:otherwise>
                    <span class="baja">
                        <xsl:value-of select="valoracion"/>
                    </span>
                </xsl:otherwise>
            </xsl:choose>
        </td>
    </tr>

</xsl:for-each>

</table>

</body>
</html>

</xsl:template>
</xsl:stylesheet>