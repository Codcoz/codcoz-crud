<%--
  Created by IntelliJ IDEA.
  User: guilhermebrandao-ieg
  Date: 26/09/2025
  Time: 13:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Criar Nota Fiscal XML</title>
</head>
<body>
<form action="ServletCreateNotaFiscalXml" method="post">
    <input type="number" name="idEmpresa" placeholder="id_empresa">
    <input type="text" name="dataEmissao" placeholder="data_emissao (YYYY-MM-DD)">
    <input type="text" name="xmlString" placeholder="xml_string">
    <input type="text" name="numeroNota" placeholder="numero_nota">
    <br><br>
    <button type="submit">CRIAR</button>
</form>
</body>
</html>
