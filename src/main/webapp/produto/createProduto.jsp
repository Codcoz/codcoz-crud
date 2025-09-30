<%--
  Created by IntelliJ IDEA.
  User: lucascosta-ieg
  Date: 25/09/2025
  Time: 12:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form action="ServletCreateProduto" method="post">
    <input type="number" name="id_Empresa" placeholder="id_Empresa">
    <input type="number" name="id_ItemNotaFiscal" placeholder="id_ItemNotaFiscal">
    <input type="number" name="id_Unidade_Medida" placeholder="id_Unidade_Medida">
    <input type="text" name="nome" placeholder="nome">
    <input type="number" name="estoqueMinimo" placeholder="estoqueMinimo">
    <input type="text" name="categoria" placeholder="categoria">
    <input type="text" name="status" placeholder="status">
    <br><br>
    <button type="submit">CRIAR</button>
</form>
</body>
</html>
