<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="html" encoding="UTF-8" indent="yes" />

    <xsl:template match="/">
        <html>
            <head>
                <title>
                    <xsl:value-of select="/biblioteca/nombrebiblioteca/nombre" />
                </title>
                <link rel="stylesheet" type="text/css" href="css/style.css" />
            </head>
            <body>

                <h1>
                    <xsl:value-of select="/biblioteca/nombrebiblioteca/nombre" />
                </h1>

                <p>
                    <strong>Total de libros registrados: </strong>
                    <xsl:value-of select="count(//libro)" />
                </p>

                <div class="resumen">
                    <h2>Resumen por Género:</h2>
                    <xsl:for-each select="biblioteca/libro">
                        <xsl:sort select="@categoria" order="ascending" />
                        <xsl:if
                            test="position() = 1 or @categoria != preceding-sibling::libro/@categoria">
                            <p><strong><xsl:value-of select="@categoria" />: </strong>
                            <xsl:value-of
                                    select="count(//libro[@categoria = current()/@categoria])" />
                                libros</p>
                        </xsl:if>
                    </xsl:for-each>
                </div>

                <div class="tarjetascontent">
                    <h2>Libros Destacados:</h2>
                    <div class="tarjetas">
                        <xsl:for-each select="biblioteca/libro[paginas > 500]">
                            <div class="tarjeta">
                                <h3>
                                    <xsl:value-of select="titulo" />
                                </h3>
                                <p>
                                    <strong>Autor:</strong>
                                    <xsl:value-of select="autor" />
                                </p>
                                <p>
                                    <strong>Género:</strong>
                                    <xsl:value-of select="@categoria" />
                                </p>
                                <p>
                                    <strong>Páginas:</strong>
                                    <xsl:value-of select="paginas" />
                                </p>
                                <div class="reseñas">
                                    <h4>Reseñas:</h4>
                                    <xsl:for-each select="reseñas/reseña">
                                        <p>
                                            <strong><xsl:value-of select="@usuario" />: </strong>
                                            <xsl:value-of select="." />
                                        </p>
                                    </xsl:for-each>
                                </div>
                            </div>
                        </xsl:for-each>
                    </div>
                </div>

                <table>
                    <tr>
                        <th>Título</th>
                        <th>Autor (País)</th>
                        <th>Género</th>
                        <th>Precio</th>
                        <th>Estado</th>
                        <th>Número de reseñas</th>
                    </tr>

                    <xsl:for-each select="biblioteca/libro">
                        <xsl:sort select="titulo" order="ascending" />

                        <tr>
                            <td>
                                <xsl:value-of select="titulo" />
                                <xsl:if test="paginas > 600">
                                    <span style="color:red; font-size:12px;"> (Libro extenso)</span>
                                </xsl:if>
                            </td>
                            <td>
                                <xsl:value-of select="autor" /> (<xsl:value-of select="autor/@pais" />
                                )</td>
                            <td>
                                <xsl:value-of select="@categoria" />
                            </td>
                            <td>
                                <xsl:value-of select="precio" />
                                <xsl:value-of select="precio/@moneda" />
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
                            <td>
                                <xsl:value-of select="count(reseñas/reseña)" />
                            </td>
                        </tr>
                    </xsl:for-each>
                </table>
                <br />
                <xsl:apply-templates select="." mode="pie-contacto" />
            </body>
        </html>
    </xsl:template>

    <xsl:template match="/" mode="pie-contacto">
        <div class="footer">
            <h3>Contacto de la Biblioteca:</h3>
            <p>
                <strong>Nombre: </strong>
                <xsl:value-of select="/biblioteca/nombrebiblioteca/nombre" />
            </p>
            <p>
                <strong>Dirección: </strong>
                <xsl:value-of select="/biblioteca/nombrebiblioteca/direccion" />
            </p>
            <p>
                <strong>Teléfono: </strong>
                <xsl:value-of select="/biblioteca/nombrebiblioteca/telefono" />
            </p>
            <p>
                <strong>Horario: </strong>
                <xsl:value-of select="/biblioteca/nombrebiblioteca/horario" />
            </p>
            <p>
                <strong>Web: </strong>
                <xsl:value-of select="/biblioteca/nombrebiblioteca/web" />
            </p>
            <p>
                <strong>Encargado: </strong>
                <xsl:value-of select="/biblioteca/nombrebiblioteca/encargado" />
            </p>

            <br />

            <xsl:element name="a">
                <xsl:attribute name="href">mailto:<xsl:value-of select="biblioteca/@email" /></xsl:attribute>
                Contactar con administración </xsl:element>
        </div>
    </xsl:template>

</xsl:stylesheet>