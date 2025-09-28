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
    <tr>
        <th>ID</th>
        <th>Empresa</th>
        <th>Data de Emissão</th>
        <th>Número da Nota</th>
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
    %>
    <tr>
        <td><%= nota.getId() %></td>
        <td><%= empresa != null ? empresa.getNome() : "Empresa não encontrada" %></td>
        <td><%= nota.getDataEmissao() %></td>
        <td><%= nota.getNumeroNota() %></td>
        <td>
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