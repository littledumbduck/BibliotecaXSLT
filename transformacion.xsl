<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="html" encoding="UTF-8" indent="yes"/>

    <xsl:template match="/">
        <html>
            <head>
                <title>Gestión de Biblioteca</title>
                <link rel="stylesheet" type="text/css" href="css/style.css" />
            </head>
            <body>
                <h1>Catálogo de la Biblioteca</h1>
                
                <p><strong>Total de libros registrados: </strong> 
                <xsl:value-of select="count(//libro)"/></p>

                <table>
                    <tr>
                        <th>Título</th>
                        <th>Autor (País)</th>
                        <th>Género</th>
                        <th>Precio</th>
                        <th>Estado</th>
                    </tr>
                    
                    <xsl:for-each select="biblioteca/libro">
                        <xsl:sort select="titulo" order="ascending"/>
                        
                        <tr>
                            <td>
                                <xsl:value-of select="titulo"/>
                                <xsl:if test="paginas &gt; 600">
                                    <span style="color:red; font-size:12px;"> (Libro extenso)</span>
                                </xsl:if>
                            </td>
                            <td>
                                <xsl:value-of select="autor"/> 
                                (<xsl:value-of select="autor/@pais"/>)
                            </td>
                            <td>
                                <xsl:value-of select="@categoria"/>
                            </td>
                            <td>
                                <xsl:value-of select="precio"/>
                                <xsl:value-of select="precio/@moneda"/>
                            </td>
                            
                            <td>
                                <xsl:choose>
                                    <xsl:when test="@disponible = 'si'">
                                        <span class="disponible">En Estantería</span>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <span class="no-disponible">Prestado</span>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </td>
                        </tr>
                    </xsl:for-each>
                </table>
                <br/>
                <xsl:apply-templates select="." mode="pie-contacto"/>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="/" mode="pie-contacto">
        <div class="footer">
            <h3>Contacto de la Biblioteca:</h3>
            <xsl:element name="a">
                <xsl:attribute name="href">mailto:admin@biblioteca.com</xsl:attribute>
                Contactar con administración
            </xsl:element>
        </div>
    </xsl:template>

</xsl:stylesheet>
