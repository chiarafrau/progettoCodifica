<?xml version="1.0" encoding="UTF-8" ?> 
    <xsl:stylesheet version="1.0"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:tei="http://www.tei-c.org/ns/1.0"
        xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <title>
                    <xsl:value-of select="//tei:title"/>
                </title>

                <link rel="stylesheet" type="text/css" href="style.css" />
                <script src="script.js"></script>
            </head>

            <body>

                <xsl:element name="div">
                    <xsl:attribute name="id">header</xsl:attribute>
                    <xsl:element name="h1">
                        <xsl:value-of select="//tei:title"/>
                    </xsl:element>
                    <xsl:element name="ul">
                        <xsl:attribute name="id">menu</xsl:attribute>
                        <xsl:element name="li">
                            <xsl:attribute name="id">m</xsl:attribute>
                            <xsl:element name="a">
                                <xsl:attribute name="href">output1.html</xsl:attribute>
                                Home
                            </xsl:element>
                        </xsl:element>
                        <xsl:element name="li">
                            <xsl:attribute name="id">mm</xsl:attribute>
                            <xsl:element name="a">
                                <xsl:attribute name="href">#cartolina_45</xsl:attribute>
                                Cartolina 45
                            </xsl:element>
                        </xsl:element>
                        <xsl:element name="li">
                            <xsl:attribute name="id">mmm</xsl:attribute>
                            <xsl:element name="a">
                                <xsl:attribute name="href">#cartolina_128</xsl:attribute>
                                Cartolina 128
                            </xsl:element>
                        </xsl:element>
                        <xsl:element name="li">
                            <xsl:attribute name="id">mmmm</xsl:attribute>
                            <xsl:element name="a">
                                <xsl:attribute name="href">#cartolina_144</xsl:attribute>
                                Cartolina 144
                            </xsl:element>
                        </xsl:element>
                        
                    </xsl:element>
                </xsl:element>

                <xsl:for-each select="tei:teiCorpus">
                    <xsl:variable name="car" select="@xml:id"/>
                    <xsl:element name="div">
                        <xsl:attribute name="id">info</xsl:attribute>
                        <h3>INFORMAZIONI GENERALI</h3>
                                <xsl:apply-templates select="tei:teiHeader//tei:fileDesc//tei:editionStmt"/> <!--edizione-->
                                <xsl:apply-templates select="tei:teiHeader//tei:fileDesc//tei:titleStmt"/> <!--ente-->
                                <xsl:apply-templates select="tei:teiHeader//tei:fileDesc//tei:editionStmt/tei:respStmt[1]"/> <!--compilatore-->
                                <xsl:apply-templates select="tei:teiHeader//tei:fileDesc//tei:editionStmt/tei:respStmt[2]"/> <!--resp sc-->
                                <xsl:apply-templates select="tei:teiHeader//tei:fileDesc//tei:editionStmt/tei:respStmt[3]"/> <!--funzionario-->
                                <xsl:apply-templates select="tei:teiHeader//tei:fileDesc//tei:sourceDesc"/> <!--luogo conservazione-->
                                <xsl:apply-templates select="tei:teiHeader//tei:fileDesc//tei:sourceDesc//tei:msDesc//tei:physDesc"/> <!--stato conservazione-->
                                <xsl:apply-templates select="tei:teiHeader//tei:fileDesc//tei:sourceDesc//tei:msDesc//tei:physDesc//tei:objectDesc//tei:supportDesc//tei:support"/><!--materiale e dimensione-->
                    </xsl:element>
                </xsl:for-each>

                <xsl:for-each select="//tei:TEI">
                    <xsl:variable name="var" select="@xml:id"/>
                    
                    <xsl:element name="div">
                        <xsl:attribute name="id">cartolina_<xsl:value-of select="$var"/></xsl:attribute>
                        <h3>Passa il mouse sul retro della cartolina per visualizzare il contenuto!</h3>
                        <h2>Cartolina n.<xsl:value-of select="tei:text//tei:div[@type='details']//tei:idno"/></h2>
                         
                        <xsl:element name="div">
                            <xsl:attribute name="id">FOTO<xsl:value-of select="$var"/></xsl:attribute>
                            <xsl:element name="div">
                                <xsl:attribute name="class">fronte</xsl:attribute>
                                <xsl:apply-templates select="tei:text//tei:div[@type='fronte']//tei:graphic"/>
                                <xsl:apply-templates select="tei:text//tei:div[@type='fronte']//tei:figure"/>
                                <xsl:apply-templates select="tei:teiHeader//tei:fileDesc//tei:notesStmt"/>
                            </xsl:element>
                                    
                            <xsl:element name="div">
                                <xsl:attribute name="class">retro</xsl:attribute>
                                <xsl:variable name="retro" select="tei:facsimile//tei:graphic/@url"/>

                                <xsl:variable name="num" select="tei:facsimile/tei:surface/@n"/>

                                <xsl:element name="img">
                                    <xsl:attribute name="src"><xsl:value-of select="$retro"/></xsl:attribute>
                                    <xsl:attribute name="id">mappa<xsl:value-of select="$num"/></xsl:attribute>
                                    <xsl:attribute name="usemap">#map<xsl:value-of select="$num"/></xsl:attribute>
                                </xsl:element>

                                <xsl:element name="map">
                                    <xsl:attribute name="name">map<xsl:value-of select="$num"/></xsl:attribute>
                                    <xsl:apply-templates select="tei:facsimile//tei:zone"/>
                                </xsl:element>

                                <xsl:element name="div">
                                    <xsl:attribute name="class">r</xsl:attribute>
                                    <xsl:apply-templates select="tei:text//tei:div[@type='retro']"/>
                                </xsl:element>
                                
                            </xsl:element>
                        </xsl:element>
                    </xsl:element>
                </xsl:for-each>

                <footer>
                    <div id="footer">
                        <p>
                            <xsl:value-of select="tei:teiCorpus/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:respStmt[1]/tei:resp"/> : <xsl:value-of select="tei:teiCorpus/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:respStmt[1]/tei:persName"/>
                            <br/><br/><xsl:value-of select="tei:teiCorpus/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:respStmt[2]/tei:resp"/> : <xsl:value-of select="tei:teiCorpus/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:respStmt[2]/tei:name[1]"/> , <xsl:value-of select="tei:teiCorpus/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:respStmt[2]/tei:name[2]"/>
                            <br/><br/>Pubblicate da : <xsl:value-of select="tei:teiCorpus/tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:publisher"/>
                        </p>
                    </div>
                </footer>
            </body>
        </html>
    </xsl:template>

   

    <xsl:template match="tei:choice">
            <xsl:element name="span">    
                <xsl:value-of select="tei:abbr"/>(<xsl:value-of select="tei:expan"/>)
            </xsl:element>
    </xsl:template>

    <xsl:template match="tei:editionStmt">
        <xsl:element name="p">
        <b>Edizione : </b>
            <xsl:value-of select="tei:edition"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="tei:titleStmt">
        <xsl:element name="p">
            <b><xsl:value-of select="tei:respStmt[3]/tei:resp"/></b>
            <xsl:value-of select="tei:respStmt[3]/tei:name"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="tei:respStmt[1]">
        <xsl:element name="p">
            <b><xsl:value-of select ="tei:resp"/> </b>
            <xsl:value-of select="tei:name"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="tei:respStmt[2]">
        <xsl:element name="p">    
            <b><xsl:value-of select="tei:resp"/></b>
           <xsl:value-of select="tei:name[1]"/> - <xsl:value-of select="tei:name[2]"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="tei:respStmt[3]">
        <xsl:element name="p">    
           <b><xsl:value-of select="tei:resp"/></b>
           <xsl:value-of select="tei:name"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="tei:sourceDesc">
        <xsl:element name="p">
            <b>Fonte della risorsa : </b>
            <xsl:value-of select="tei:msDesc/tei:msIdentifier/tei:settlement"/> - <xsl:value-of select="tei:msDesc/tei:msIdentifier/tei:repository"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="tei:physDesc">
        <xsl:element name="p">
            <b>Stato di conservazione : </b>
            <xsl:value-of select="tei:objectDesc/tei:supportDesc/tei:condition"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="tei:support">
        <xsl:element name="p">
            <b>Materiale e dimensione : </b>
            <xsl:value-of select="tei:material"/> - <xsl:value-of select="tei:dimensions/tei:height"/> x <xsl:value-of select="tei:dimensions/tei:width"/> cm
        </xsl:element>
    </xsl:template>

    <xsl:template match="tei:notesStmt">
        <xsl:element name="p">    
           <b>Nota sul fronte della cartolina : </b>
           <xsl:value-of select="tei:note"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="tei:graphic">
        <xsl:variable name="a" select="@url"/>
        <xsl:element name="img">
            <xsl:attribute name="id">f</xsl:attribute>
            <xsl:attribute name="src"><xsl:value-of select="$a"/></xsl:attribute>
        </xsl:element>
    </xsl:template>

    <xsl:template match="tei:figure">
        <xsl:element name="p">
            <b>Descrizione immagine : </b>
            <xsl:value-of select="tei:figDesc"/>  
        </xsl:element>
    </xsl:template>

    <xsl:template match="tei:zone">
        <xsl:element name="area">       
            <xsl:attribute name="shape">rect</xsl:attribute>
            <xsl:attribute name="coords">
                <xsl:value-of select="@ulx"/>,<xsl:value-of select="@uly"/>,<xsl:value-of select="@lrx"/>,<xsl:value-of select="@lry"/>
            </xsl:attribute>
            <xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
        </xsl:element>
    </xsl:template>

    <xsl:template match="tei:text//tei:div[@type='retro']">
        <xsl:variable name="var" select="@n"/>

        <xsl:element name="p">
            <xsl:attribute name="id">cod<xsl:value-of select="$var"/></xsl:attribute>
            Codice identificativo: <xsl:value-of select="tei:div[@type='details']//tei:idno"/>
        </xsl:element>
            
        <xsl:element name="p">
            <xsl:attribute name="id">l<xsl:value-of select="$var"/></xsl:attribute>
            Luogo: <xsl:value-of select="tei:div[@type='message']/tei:dateline[1]"/>
            <xsl:if test="$var ='3'">
                <xsl:value-of select="tei:div[@type='message']/tei:p/tei:placeName"/>
            </xsl:if>
            <xsl:if test="$var='1'">
                <xsl:for-each select="//tei:text[@xml:id='prima']//tei:body//tei:div[@type='retro']//tei:div[@type='message']//tei:dateline[1]//tei:gap">
                    <xsl:element name="span">
                        <xsl:attribute name="id">ill1</xsl:attribute>(illegibile)
                    </xsl:element>
                </xsl:for-each>
            </xsl:if> 
            
                
        </xsl:element>

        <xsl:element name="p">
            <xsl:attribute name="id">d<xsl:value-of select="$var"/></xsl:attribute>
            Data:<xsl:value-of select="tei:div[@type='message']/tei:dateline[2]"/>
            <xsl:if test="$var='3'">
                <xsl:value-of select="tei:div[@type='message']/tei:p/tei:date"/>
            </xsl:if>
        </xsl:element>

        <xsl:element name="p">
            <xsl:attribute name="id">mess<xsl:value-of select="$var"/></xsl:attribute>
            <xsl:value-of select="tei:div[@type='message']/tei:p"/>
            <xsl:if test="$var='1'">
                <xsl:for-each select="//tei:text[@xml:id='prima']//tei:body//tei:div[@type='retro']//tei:div[@type='message']//tei:p//tei:gap">
                    <xsl:element name="p">
                        <xsl:attribute name="class">ill_mess1</xsl:attribute>(illegibile)
                    </xsl:element>
                </xsl:for-each>
            </xsl:if> 
        </xsl:element>
            
        <xsl:element name="p">
            <xsl:attribute name="id">firm<xsl:value-of select="$var"/></xsl:attribute>
            Firma: <xsl:value-of select="tei:div[@type='message']/tei:signed"/>
            <xsl:if test="$var='1'">
                <xsl:for-each select="//tei:text[@xml:id='prima']//tei:body//tei:div[@type='retro']//tei:div[@type='message']//tei:signed//tei:gap">
                    <xsl:element name="span">
                        <xsl:attribute name="id">ill_firm1</xsl:attribute>(illegibile)
                    </xsl:element>
                </xsl:for-each>
            </xsl:if> 
        </xsl:element>

        <xsl:if test="$var='1'">
            <xsl:element name="p">
                <xsl:attribute name="id">edit<xsl:value-of select="$var"/></xsl:attribute>
                Editore: <xsl:value-of select="tei:div[@type='destination']//tei:stamp[@type='tipografia1']//tei:mentioned"/>
            </xsl:element>
        </xsl:if>
            
        <xsl:if test="$var='2'">
            <xsl:element name="p">
                <xsl:attribute name="id">p_edit<xsl:value-of select="$var"/></xsl:attribute>
                Editore: <xsl:value-of select="tei:div[@type='destination']//tei:stamp[@type='a']"/>
            </xsl:element>
        </xsl:if>

        <xsl:if test="$var='2'">
            <xsl:element name="p">
                <xsl:attribute name="id">s_edit<xsl:value-of select="$var"/></xsl:attribute>
                    Editore: <xsl:value-of select="tei:div[@type='destination']//tei:stamp[@type='b']"/>
                </xsl:element>
        </xsl:if>
                
        <xsl:element name="p">
            <xsl:attribute name="id">n_serie<xsl:value-of select="$var"/></xsl:attribute>
            <xsl:value-of select="tei:div[@type='destination']//tei:stamp[@type='tipografia2']//tei:mentioned"/>
        </xsl:element>

        <xsl:if test="$var='2'">
            <xsl:element name="p">
                <xsl:attribute name="id">tim<xsl:value-of select="$var"/></xsl:attribute>
                Timbro: <xsl:value-of select="tei:div[@type='destination']//tei:stamp[@type='postmark']//tei:mentioned"/>
            </xsl:element>
        </xsl:if>

        <xsl:if test="$var='3'">
            <xsl:element name="p">
                <xsl:attribute name="id">tim<xsl:value-of select="$var"/></xsl:attribute>
                Timbro: <xsl:value-of select="tei:div[@type='destination']//tei:stamp[@type='postmark']//tei:mentioned"/>
            </xsl:element>
        </xsl:if>
        
        <xsl:element name="p">
            <xsl:attribute name="id">francob<xsl:value-of select="$var"/></xsl:attribute>
            <xsl:value-of select="tei:div[@type='destination']//tei:stamp[@type='postage']"/>
        </xsl:element>
        
        <xsl:element name="p">
            <xsl:attribute name="id">intest<xsl:value-of select="$var"/></xsl:attribute>
            <xsl:apply-templates select="tei:div[@type='destination']//tei:address"/>
        </xsl:element>

        <xsl:if test="$var='3'">
            <xsl:element name="p">
                <xsl:attribute name="id">p_r<xsl:value-of select="$var"/></xsl:attribute>
                <xsl:value-of select="tei:div[@type='message']//tei:stamp"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>