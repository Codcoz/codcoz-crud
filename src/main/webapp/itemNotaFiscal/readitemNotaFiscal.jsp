<%--
  Created by IntelliJ IDEA.
  User: guilhermebrandao-ieg
  Date: 26/09/2025
  Time: 13:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.codcoz.model.ItemNotaFiscal" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Lista de Itens Nota Fiscal</title>
</head>
<body>
<h2>Lista de Itens Nota Fiscal</h2>

<form action="createItemNotaFiscal.jsp" method="post">
    <button type="submit">Create</button>
</form>

<table border="1">
    <tr>
        <th>ID</th>
        <th>ID Nota Fiscal XML</th>
        <th>ID Empresa</th>
        <th>Quantidade</th>
        <th>Preço</th>
        <th>Update</th>
        <th>Delete</th>
    </tr>

    <%
        List<ItemNotaFiscal> lista = (List<ItemNotaFiscal>) request.getAttribute("listaItens");
        if (lista != null && lista.size() > 0) {
            for (ItemNotaFiscal item : lista) {
    %>
    <tr>
        <td><%= item.getId() %></td>
        <td><%= item.getIdNotaFiscalXml() %></td>
        <td><%= item.getIdEmpresa() %></td>
        <td><%= item.getQuantidade() %></td>
        <td><%= item.getPreco() %></td>

        <!-- Botão de Update -->
        <td>
            <form action="updateItemNotaFiscal.jsp" method="get">
                <input type="hidden" name="id" value="<%= item.getId() %>"/>
                <button type="submit">Update</button>
            </form>
        </td>

        <!-- Botão de Delete -->
        <td>
            <form action="ServletDeleteItemNotaFiscal" method="post">
                <input type="hidden" name="id" value="<%= item.getId() %>"/>
                <input type="submit" value="Delete" />
            </form>
        </td>
    </tr>
    <%
        }
    } else {
    %>
    <tr><td colspan="7">Nenhum item encontrado.</td></tr>
    <%
        }
    %>
</table>

</body>
</html>
