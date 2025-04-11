<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" indent="yes"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Ant Build Script - HTML View</title>
                <style>
                    body { font-family: Arial, sans-serif; margin: 20px; }
                    h1 { color: #2c3e50; border-bottom: 1px solid #ddd; }
                    h2 { color: #3498db; margin-top: 20px; }
                    .comment { color: #7f8c8d; font-style: italic; background-color: #f5f5f5; padding: 5px; }
                    .target { background-color: #f9f9f9; padding: 10px; border-left: 3px solid #3498db; margin: 10px 0; }
                    .target-name { font-weight: bold; color: #2980b9; }
                    .depends { color: #27ae60; font-size: 0.9em; }
                    .description { color: #e74c3c; }
                    .property { color: #9b59b6; }
                    .xml-tag { color: #2c3e50; font-weight: bold; }
                    .xml-attr { color: #d35400; }
                    .section { margin-bottom: 30px; }
                    table { border-collapse: collapse; width: 100%; margin: 10px 0; }
                    th { background-color: #3498db; color: white; text-align: left; padding: 8px; }
                    td { border: 1px solid #ddd; padding: 8px; }
                    tr:nth-child(even) { background-color: #f2f2f2; }
                </style>
            </head>
            <body>
                <h1>Build Script: <xsl:value-of select="project/@name"/></h1>
                
                <!-- Project header comment -->
                <xsl:apply-templates select="comment()"/>
                
                <!-- Main project info -->
                <div class="section">
                    <h2>Project Information</h2>
                    <table>
                        <tr>
                            <th>Attribute</th>
                            <th>Value</th>
                        </tr>
                        <tr>
                            <td>Name</td>
                            <td><xsl:value-of select="project/@name"/></td>
                        </tr>
                        <tr>
                            <td>Basedir</td>
                            <td><xsl:value-of select="project/@basedir"/></td>
                        </tr>
                        <tr>
                            <td>Default Target</td>
                            <td><xsl:value-of select="project/@default"/></td>
                        </tr>
                    </table>
                </div>
                
                <!-- Main targets -->
                <div class="section">
                    <h2>Main Targets</h2>
                    <xsl:apply-templates select="project/target[@name='default']"/>
                </div>
                
                <!-- All targets organized by sections -->
                <div class="section">
                    <h2>Detailed Targets</h2>
                    <xsl:apply-templates select="project/target[not(@name='default')]"/>
                </div>
                
                <!-- Properties -->
                <div class="section">
                    <h2>Properties</h2>
                    <table>
                        <tr>
                            <th>Name</th>
                            <th>Value</th>
                        </tr>
                        <xsl:for-each select="project/property">
                            <tr>
                                <td><xsl:value-of select="@name"/></td>
                                <td><xsl:value-of select="@value"/></td>
                            </tr>
                        </xsl:for-each>
                    </table>
                </div>
            </body>
        </html>
    </xsl:template>
    
    <!-- Template for comments -->
    <xsl:template match="comment()">
        <div class="comment">
            <xsl:value-of select="."/>
        </div>
    </xsl:template>
    
    <!-- Template for targets -->
    <xsl:template match="target">
        <div class="target">
            <span class="target-name">
                <xsl:value-of select="@name"/>
            </span>
            
            <xsl:if test="@depends">
                <div class="depends">
                    Depends on: <xsl:value-of select="@depends"/>
                </div>
            </xsl:if>
            
            <xsl:if test="@description">
                <div class="description">
                    Description: <xsl:value-of select="@description"/>
                </div>
            </xsl:if>
            
            <xsl:if test="*">
                <div style="margin-top: 5px;">
                    <strong>Contents:</strong>
                    <ul>
                        <xsl:for-each select="*">
                            <li>
                                <span class="xml-tag">
                                    <xsl:value-of select="name()"/>
                                </span>
                                <xsl:for-each select="@*">
                                    <xsl:text> </xsl:text>
                                    <span class="xml-attr">
                                        <xsl:value-of select="name()"/>
                                    </span>="<xsl:value-of select="."/>"
                                </xsl:for-each>
                            </li>
                        </xsl:for-each>
                    </ul>
                </div>
            </xsl:if>
        </div>
    </xsl:template>
    
    <!-- Template for properties -->
    <xsl:template match="property">
        <tr>
            <td><xsl:value-of select="@name"/></td>
            <td><xsl:value-of select="@value"/></td>
        </tr>
    </xsl:template>
</xsl:stylesheet>