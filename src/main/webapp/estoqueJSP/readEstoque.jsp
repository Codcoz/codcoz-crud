<%@ page import="com.codcoz.model.Estoque, com.codcoz.dao.EmpresaDAO, com.codcoz.model.Empresa, java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<Estoque> lista = (List<Estoque>) request.getAttribute("listaEstoques");
    EmpresaDAO empresaDAO = new EmpresaDAO();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Lista de Estoques</title>
</head>
<body>
<h2>Lista de Estoques</h2>

<form action="<%= request.getContextPath() %>/estoqueJSP/createEstoque.jsp" method="get">
    <button type="submit">Create</button>
</form>
<br>

<table border="1" cellpadding="8" cellspacing="0">
    <tr>
        <th>ID</th>
        <th>Tipo</th>
        <th>Capacidade</th>
        <th>Empresa</th>
        <th>Update</th>
        <th>Delete</th>
    </tr>
    <% if (lista != null && !lista.isEmpty()) {
        for (Estoque est : lista) {
            Empresa emp = empresaDAO.buscarPorId(est.getIdEmpresa());
    %>
    <tr>
        <td><%= est.getId() %></td>
        <td><%= est.getTipoEstoque() %></td>
        <td><%= est.getCapacidade() %></td>
        <td><%= emp != null ? emp.getNome() : "N/A" %></td>
        <td>
            <form action="<%= request.getContextPath() %>/estoqueJSP/updateEstoque.jsp" method="get">
                <input type="hidden" name="id" value="<%= est.getId() %>"/>
                <button type="submit">Update</button>
            </form>
        </td>
        <td>
            <form action="<%= request.getContextPath() %>/ServletDeleteEstoque" method="post">
                <input type="hidden" name="id" value="<%= est.getId() %>"/>
                <button type="submit">Delete</button>
            </form>
        </td>
    </tr>
    <% } } else { %>
    <tr><td colspan="6">Nenhum estoque encontrado.</td></tr>
    <% } %>
</table>

<br><br>
<a href="<%= request.getContextPath() %>/index.html">Voltar ao início</a>
</body>
</html>