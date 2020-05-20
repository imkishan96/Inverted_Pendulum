<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<html>
			<head>
			 </head>
			<body>
				<!-- MAIN-Table with one column -->
				<table>
					<!-- iterate through the SourceConnectors -->
					<xsl:for-each select="CFC-XREF/SourceConnector">
						<!-- headline-row -->
						<tr>
							<td>
								<table cellspacing="0" cellpadding="0">
									<tr>
										<th bgcolor="red" width="400">
											<b>Source</b>
										</th>
										<th bgcolor="green" width="400">
											<b>Target(s)</b>
										</th>
									</tr>
								</table>													
							</td>
						</tr>
						<!-- source-connector-row -->
						<tr>
							<td>
								<table border="1" width="800" bgcolor="#FFDDDD" cellspacing="0" cellpadding="0">
									<tr>
										<th>Source</th>
										<th>Name</th>
										<th>Connector</th>
										<th>Layer</th>
										<th>PrintOn</th>
									</tr>
										<td align="center" nowrap="1"><xsl:apply-templates select="SourceData/ConnectorName"/></td>
										<td align="center" nowrap="1"><xsl:apply-templates select="SourceData/FunctionBlockName"/></td>
										<td align="center" nowrap="1"><xsl:apply-templates select="SourceData/FunctionBlockConnector"/></td>
										<td align="center" nowrap="1"><xsl:apply-templates select="SourceData/FunctionBlockLayer"/></td>
										<td>
											<table align="center">
												<tr>
													<td align="center" nowrap="1">Page: <xsl:apply-templates select="SourceData/PrintLocalisation/Page"/></td>
												</tr>
												<tr>
													<td align="center" nowrap="1">Row: <xsl:apply-templates select="SourceData/PrintLocalisation/Row"/></td>	
												</tr>	
											</table>
										</td>																				
								</table>						
							</td>					
						</tr>
						<!-- target-connectors-row -->
						<tr>
							<td>
								<table width="800" cellspacing="0" cellpadding="0">
									<tr>
										<td width="50">
									
										</td>
										<td width="750">
											<table border="1" width="750" bgcolor="#D7FFD7" cellspacing="0" cellpadding="0">
												<tr>
													<th>Target</th>
													<th>Name</th>
													<th>Connector</th>
													<th>Layer</th>
													<th>PrintOn</th>										
												</tr>
												<xsl:for-each select="TargetConnectors/TargetData">
												<tr align="justify">
													<td align="center" nowrap="1"><xsl:apply-templates select="ConnectorName"/></td>
													<td align="center" nowrap="1"><xsl:apply-templates select="FunctionBlockName"/></td>
													<td align="center" nowrap="1"><xsl:apply-templates select="FunctionBlockConnector"/></td>
													<td align="center" nowrap="1"><xsl:apply-templates select="FunctionBlockLayer"/></td>
													<td>
														<table align="center">
															<tr>
																<td align="center" nowrap="1">Page: <xsl:apply-templates select="PrintLocalisation/Page"/></td>
															</tr>
															<tr>
																<td align="center" nowrap="1">Row: <xsl:apply-templates select="PrintLocalisation/Row"/></td>	
															</tr>	
														</table>
													</td>
												</tr>
												</xsl:for-each>
											</table>
										</td>								
									</tr>
								</table>
							</td>
						</tr>
					</xsl:for-each>
				</table>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>