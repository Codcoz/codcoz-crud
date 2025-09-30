<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.codcoz.model.ItemNotaFiscal" %>
<%@ page import="com.codcoz.model.NotaFiscalXml" %>
<%@ page import="com.codcoz.model.Empresa" %>
<%@ page import="com.codcoz.dao.NotaFiscalXmlDAO" %>
<%@ page import="com.codcoz.dao.EmpresaDAO" %>
<%@ page import="java.util.List" %>

<html>
<head>
    <title>Lista de Itens Nota Fiscal</title>
</head>
<body>
<aside>
    <!-- Aside para botões de outras tabelas -->
    <p>Botões de navegação para outras tabelas aqui</p>
</aside>

<h2>Lista de Itens Nota Fiscal</h2>

<form action="itemNotaFiscalJSP/createItemNotaFiscal.jsp" method="post">
    <button type="submit">Create</button>
</form>

<table border="1">
    <tr>
        <th>ID</th>
        <th>Número da Nota Fiscal</th>
        <th>Empresa</th>
        <th>Quantidade</th>
        <th>Preço</th>
        <th>Update</th>
        <th>Delete</th>
    </tr>

    <%
        List<ItemNotaFiscal> lista = (List<ItemNotaFiscal>) request.getAttribute("listaItensNotaFiscal");
        NotaFiscalXmlDAO notaDAO = new NotaFiscalXmlDAO();
        EmpresaDAO empresaDAO = new EmpresaDAO();

        if (lista != null && !lista.isEmpty()) {
            for (ItemNotaFiscal item : lista) {
                NotaFiscalXml notaFiscalXml = notaDAO.buscarPorId(item.getIdNotaFiscalXml());
                Empresa empresa = empresaDAO.buscarPorId(item.getIdEmpresa());
    %>
    <tr>
        <td><%= item.getId() %></td>
        <td><%= notaFiscalXml.getNumeroNota() %></td>
        <td><%= empresa.getNome() %></td>
        <td><%= item.getQuantidade() %></td>
        <td><%= item.getPreco() %></td>
        <td>
            <form action="itemNotaFiscal/updateItemNotaFiscal.jsp" method="get">
                <input type="hidden" name="id" value="<%= item.getId() %>"/>
                <button type="submit">Update</button>
            </form>
        </td>
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

<br>
<a href="<%= request.getContextPath() %>/index.html">Voltar ao início</a>
</body>
</html>
