<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="
    com.codcoz.dao.NotaFiscalXmlDAO,
    com.codcoz.dao.EmpresaDAO,
    com.codcoz.model.NotaFiscalXml,
    com.codcoz.model.Empresa,
    java.util.List
" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lista de Notas Fiscais XML</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
</head>
<body>
<aside>
    <!-- Aside para botões de navegação entre tabelas -->
    Navegar para outras tabelas
</aside>

<h2>Lista de Notas Fiscais XML</h2>

<form action="<%= request.getContextPath() %>/notaFiscalXmlJSP/createNotaFiscalXml.jsp" method="post">
    <button type="submit">Criar Nota Fiscal XML</button>
</form>
<br>

<%
    NotaFiscalXmlDAO notaDao = new NotaFiscalXmlDAO();
    List<NotaFiscalXml> notas = notaDao.read();
    EmpresaDAO empresaDAO = new EmpresaDAO();
%>

<table border="1" cellpadding="8" cellspacing="0">
    <tr>
        <th>ID</th>
        <th>Empresa</th>
        <th>Data de Emissão</th>
        <th>Número da Nota</th>
        <th>Update</th>
        <th>Delete</th>
    </tr>
    <%
        if (notas != null && !notas.isEmpty()) {
            for (NotaFiscalXml nota : notas) {
                Empresa empresa = empresaDAO.buscarPorId(nota.getIdEmpresa());
    %>
    <tr>
        <td><%= nota.getId() %></td>
        <td><%=empresa.getNome()%></td>
        <td><%= nota.getDataEmissao() %></td>
        <td><%= nota.getNumeroNota() %></td>
        <td>
            <form action="<%= request.getContextPath() %>/notaFiscalXmlJSP/updateNotaFiscalXml.jsp" method="post">
                <input type="hidden" name="id" value="<%= nota.getId() %>"/>
                <button type="submit">Update</button>
            </form>
        </td>
        <td>
            <form action="<%= request.getContextPath() %>/ServletDeleteNotaFiscalXml" method="get">
                <input type="hidden" name="id" value="<%= nota.getId() %>"/>
                <button type="submit">Delete</button>
            </form>
        </td>
    </tr>
    <%
        }
    } else {
    %>
    <tr>
        <td colspan="6">Nenhuma nota fiscal encontrada.</td>
    </tr>
    <%
        }
    %>
</table>

<br>
<a href="<%= request.getContextPath() %>/index.jsp">Voltar ao início</a>
</body>
</html>