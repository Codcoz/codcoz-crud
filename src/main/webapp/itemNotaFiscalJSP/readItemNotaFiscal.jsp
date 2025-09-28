<<<<<<< HEAD
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.codcoz.model.ItemNotaFiscal" %>
<%@ page import="com.codcoz.model.NotaFiscalXml" %>
<%@ page import="com.codcoz.model.Empresa" %>
<%@ page import="com.codcoz.dao.NotaFiscalXmlDAO" %>
<%@ page import="com.codcoz.dao.EmpresaDAO" %>
<%@ page import="java.util.List" %>

<aside>
    aside para por todos os botões das outras tabelas
</aside>

<form action="itemNotaFiscalJSP/createItemNotaFiscal.jsp" method="post">
=======
<%--
  Created by IntelliJ IDEA.
  User: guilhermebrandao-ieg
  Date: 26/09/2025
  Time: 13:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.codcoz.model.ItemNotaFiscal" %>
<%@ page import="java.util.List" %>
<%@ page import="com.codcoz.model.Endereco" %>
<%@ page import="com.codcoz.model.NotaFiscalXml" %>
<%@ page import="com.codcoz.dao.NotaFiscalXmlDAO" %>
<%@ page import="com.codcoz.dao.EmpresaDAO" %>
<%@ page import="com.codcoz.model.Empresa" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Lista de Itens Nota Fiscal</title>
</head>
<body>
<h2>Lista de Itens Nota Fiscal</h2>

<form action="itemNotaFiscal/createItemNotaFiscal.jsp" method="post">
>>>>>>> b0f8cb5cc2905eeb18a7e0ceb7a15fb342d0a0af
    <button type="submit">Create</button>
</form>

<table border="1">
    <tr>
        <th>ID</th>
<<<<<<< HEAD
        <th>Número da Nota Fiscal</th>
=======
        <th>Numero da Nota Fiscal</th>
>>>>>>> b0f8cb5cc2905eeb18a7e0ceb7a15fb342d0a0af
        <th>Empresa</th>
        <th>Quantidade</th>
        <th>Preço</th>
        <th>Update</th>
        <th>Delete</th>
    </tr>

    <%
        List<ItemNotaFiscal> lista = (List<ItemNotaFiscal>) request.getAttribute("listaItensNotaFiscal");
<<<<<<< HEAD
        NotaFiscalXmlDAO notaDAO = new NotaFiscalXmlDAO();
        EmpresaDAO empresaDAO = new EmpresaDAO();

        if (lista != null && !lista.isEmpty()) {
            for (ItemNotaFiscal item : lista) {
                NotaFiscalXml notaFiscalXml = notaDAO.buscarPorId(item.getIdNotaFiscalXml());
                Empresa empresa = empresaDAO.buscarPorId(item.getIdEmpresa());
=======

        if (lista != null && lista.size() > 0) {
            for (ItemNotaFiscal item : lista) {
                NotaFiscalXml notaFiscalXml = new NotaFiscalXmlDAO().buscarPorId(item.getIdNotaFiscalXml());
                Empresa empresa = new EmpresaDAO().buscarPorId(item.getIdEmpresa());
>>>>>>> b0f8cb5cc2905eeb18a7e0ceb7a15fb342d0a0af
    %>
    <tr>
        <td><%= item.getId() %></td>
        <td><%= notaFiscalXml.getNumeroNota() %></td>
<<<<<<< HEAD
        <td><%= empresa.getNome() %></td>
        <td><%= item.getQuantidade() %></td>
        <td><%= item.getPreco() %></td>
        <td>
            <form action="itemNotaFiscalJSP/updateItemNotaFiscal.jsp" method="get">
=======
        <td><%= empresa.getNome()%></td>
        <td><%= item.getQuantidade() %></td>
        <td><%= item.getPreco() %></td>

        <!-- Botão de Update -->
        <td>
            <form action="updateItemNotaFiscal.jsp" method="get">
>>>>>>> b0f8cb5cc2905eeb18a7e0ceb7a15fb342d0a0af
                <input type="hidden" name="id" value="<%= item.getId() %>"/>
                <button type="submit">Update</button>
            </form>
        </td>
<<<<<<< HEAD
=======

        <!-- Botão de Delete -->
>>>>>>> b0f8cb5cc2905eeb18a7e0ceb7a15fb342d0a0af
        <td>
            <form action="ServletDeleteitemNotaFiscal" method="post">
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

<<<<<<< HEAD
<br>
<a href="<%=request.getContextPath()%>/index.html">Voltar ao início</a>
=======
</body>
</html>
>>>>>>> b0f8cb5cc2905eeb18a7e0ceb7a15fb342d0a0af
