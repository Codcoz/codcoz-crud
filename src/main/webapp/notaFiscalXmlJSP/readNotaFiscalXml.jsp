<%@ page import="com.codcoz.dao.NotaFiscalXmlDAO" %>
<%@ page import="com.codcoz.model.NotaFiscalXml" %>
<%@ page import="com.codcoz.dao.EmpresaDAO" %>
<%@ page import="com.codcoz.model.Empresa" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    NotaFiscalXmlDAO dao = new NotaFiscalXmlDAO();
    List<NotaFiscalXml> notas = dao.read();
    EmpresaDAO empresaDAO = new EmpresaDAO();
%>

<html>
<head>
    <title>Lista de Notas Fiscais XML</title>
</head>
<body>
<h2>Notas Fiscais XML</h2>

<table border="1" cellpadding="8" cellspacing="0">
    <tr>
        <th>ID</th>
        <th>Empresa</th>
        <th>Data de Emissão</th>
        <th>Número da Nota</th>
        <th>Ações</th>
    </tr>
    <% for (NotaFiscalXml nota : notas) {
        Empresa empresa = empresaDAO.buscarPorId(nota.getIdEmpresa());
    %>
    <tr>
        <td><%= nota.getId() %></td>
        <td><%= empresa != null ? empresa.getNome() : "Empresa não encontrada" %></td>
        <td><%= nota.getDataEmissao() %></td>
        <td><%= nota.getNumeroNota() %></td>
        <td>
            <a href="<%=request.getContextPath()%>/ServletUpdateNotaFiscalXml?id=<%= nota.getId() %>">Editar</a> |
            <a href="<%=request.getContextPath()%>/ServletDeleteNotaFiscalXml?id=<%= nota.getId() %>" onclick="return confirm('Tem certeza que deseja excluir esta nota?');">Excluir</a>
        </td>
    </tr>
    <% } %>
</table>

<br><br>
<a href="<%=request.getContextPath()%>/formCreateNotaFiscalXml.jsp">Criar nova nota fiscal</a> <br><br>
<a href="<%=request.getContextPath()%>/index.html">Voltar ao início</a>
</body>
</html>

