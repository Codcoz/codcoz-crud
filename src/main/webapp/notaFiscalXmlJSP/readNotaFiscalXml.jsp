<<<<<<< HEAD
<%@ page import="com.codcoz.model.NotaFiscalXml" %>
<%@ page import="com.codcoz.dao.NotaFiscalXmlDAO" %>
<%@ page import="com.codcoz.model.Empresa" %>
<%@ page import="com.codcoz.dao.EmpresaDAO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<aside>
    aside para por todos os botoes das outras tabelas
</aside>

<form action="notaFiscalXmlJSP/createNotaFiscalXml.jsp" method="post">
    <button type="submit">Create</button>
</form>

<table border="1">
=======
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
>>>>>>> b0f8cb5cc2905eeb18a7e0ceb7a15fb342d0a0af
    <tr>
        <th>ID</th>
        <th>Empresa</th>
        <th>Data de Emissão</th>
        <th>Número da Nota</th>
<<<<<<< HEAD
        <th>Update</th>
        <th>Delete</th>
    </tr>

    <%
        NotaFiscalXmlDAO dao = new NotaFiscalXmlDAO();
        List<NotaFiscalXml> notas = dao.read();
        EmpresaDAO empresaDAO = new EmpresaDAO();

        if (notas != null && !notas.isEmpty()) {
            for (NotaFiscalXml nota : notas) {
                Empresa empresa = empresaDAO.buscarPorId(nota.getIdEmpresa());
=======
        <th>Ações</th>
    </tr>
    <% for (NotaFiscalXml nota : notas) {
        Empresa empresa = empresaDAO.buscarPorId(nota.getIdEmpresa());
>>>>>>> b0f8cb5cc2905eeb18a7e0ceb7a15fb342d0a0af
    %>
    <tr>
        <td><%= nota.getId() %></td>
        <td><%= empresa != null ? empresa.getNome() : "Empresa não encontrada" %></td>
        <td><%= nota.getDataEmissao() %></td>
        <td><%= nota.getNumeroNota() %></td>
        <td>
<<<<<<< HEAD
            <form action="notaFiscalXmlJSP/updateNotaFiscalXml.jsp" method="get">
                <input type="hidden" name="id" value="<%= nota.getId() %>"/>
                <button type="submit">Update</button>
            </form>
        </td>
        <td>
            <form action="ServletDeleteNotaFiscalXml" method="post" onsubmit="return confirm('Tem certeza que deseja excluir esta nota?');">
                <input type="hidden" name="id" value="<%= nota.getId() %>"/>
                <input type="submit" value="Delete" />
            </form>
        </td>
    </tr>
    <%
        }
    } else {
    %>
    <tr><td colspan="6">Nenhuma nota fiscal encontrada.</td></tr>
    <%
        }
    %>
</table>

<br>
<a href="<%=request.getContextPath()%>/index.html">Voltar ao início</a>
=======
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

>>>>>>> b0f8cb5cc2905eeb18a7e0ceb7a15fb342d0a0af
