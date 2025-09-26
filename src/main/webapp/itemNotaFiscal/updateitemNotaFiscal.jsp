<%--
  Created by IntelliJ IDEA.
  User: guilhermebrandao-ieg
  Date: 26/09/2025
  Time: 13:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.codcoz.model.ItemNotaFiscal" %>
<%@ page import="com.codcoz.dao.ItemNotaFiscalDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Integer id = Integer.parseInt(request.getParameter("id"));
    ItemNotaFiscal item = null;

    if (id != null) {
        ItemNotaFiscalDAO dao = new ItemNotaFiscalDAO();
        item = dao.buscarPorId(id);
    }
%>

<html>
<head>
    <title>Atualizar Item Nota Fiscal</title>
</head>
<body>
<h2>Atualizar Item Nota Fiscal de ID <%= item != null ? item.getId() : "" %></h2>

<% if (item != null) { %>
<form action="ServletUpdateItemNotaFiscal" method="post">
    <input type="hidden" name="id" value="<%= item.getId() %>"/>

    <label for="idNotaFiscalXml">ID Nota Fiscal XML:</label>
    <input type="number" id="idNotaFiscalXml" name="idNotaFiscalXml" value="<%= item.getIdNotaFiscalXml() %>" required><br><br>

    <label for="idEmpresa">ID Empresa:</label>
    <input type="number" id="idEmpresa" name="idEmpresa" value="<%= item.getIdEmpresa() %>" required><br><br>

    <label for="quantidade">Quantidade:</label>
    <input type="number" step="0.01" id="quantidade" name="quantidade" value="<%= item.getQuantidade() %>" required><br><br>

    <label for="preco">Preço:</label>
    <input type="number" step="0.01" id="preco" name="preco" value="<%= item.getPreco() %>" required><br><br>

    <button type="submit">Update</button>
</form>
<% } else { %>
<p>Item não encontrado.</p>
<% } %>

<a href="ServletReadItemNotaFiscal">Voltar à lista</a>
</body>
</html>
