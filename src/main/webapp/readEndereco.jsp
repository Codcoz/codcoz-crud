<%--
  Created by IntelliJ IDEA.
  User: felipeboregio-ieg
  Date: 16/09/2025
  Time: 07:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.codcoz.model.Endereco" %>
<%@ page import="java.util.List" %>

<html>
<head>
    <title>Lista de Endereços</title>
</head>
<body>
<h2>Endereços cadastrados</h2>

<table border="1">
    <tr>
        <th>ID</th>
        <th>Rua</th>
        <th>Complemento</th>
        <th>Cidade</th>
        <th>Estado</th>
        <th>CEP</th>
        <th>Número</th>
    </tr>

    <%
        List<Endereco> lista = (List<Endereco>) request.getAttribute("listaEnderecos");
        if (lista != null) {
            for (Endereco e : lista) {
    %>
    <tr>
        <td><%= e.getId() %></td>
        <td><%= e.getRua() %></td>
        <td><%= e.getComplemento() %></td>
        <td><%= e.getCidade() %></td>
        <td><%= e.getEstado() %></td>
        <td><%= e.getCep() %></td>
        <td><%= e.getNumero() %></td>
    </tr>
    <%
        }
    } else {
    %>
    <tr><td colspan="7">Nenhum endereço encontrado.</td></tr>
    <%
        }
    %>
</table>
<a href="index.jsp">retornar para home</a>
</body>
</html>
