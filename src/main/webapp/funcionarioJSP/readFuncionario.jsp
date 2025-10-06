<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="
    com.codcoz.model.Funcionario,
    java.util.List
" %>
<%@ page import="com.codcoz.dao.EmpresaDAO" %>
<%@ page import="com.codcoz.model.Empresa" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Lista de Funcionários</title>
</head>
<body>
<aside>
    <!-- Aside para botões de navegação entre tabelas -->
</aside>

<h2>Lista de Funcionários</h2>

<form action="<%= request.getContextPath() %>/funcionarioJSP/createFuncionario.jsp" method="get">
    <button type="submit">Create</button>
</form>
<br>

<table border="1" cellpadding="8" cellspacing="0">
    <tr>
        <th>ID</th>
        <th>Nome</th>
        <th>Sobrenome</th>
        <th>CPF</th>
        <th>ID Empresa</th>
        <th>Função</th>
        <br>
        <th>Update</th>
        <th>Delete</th>
    </tr>
    <%
    List<Funcionario> lista = (List<Funcionario>) request.getAttribute("listaFuncionarios");
    EmpresaDAO empresaDAO = new EmpresaDAO();

    if (lista != null && !lista.isEmpty()) {
        for (Funcionario funcionario : lista) {
            Empresa empresa = empresaDAO.buscarPorId(funcionario.getIdEmpresa());
%>
    <tr>
        <td><%= funcionario.getId() %></td>
        <td><%= funcionario.getNome() %></td>
        <td><%= funcionario.getSobrenome() %></td>
        <td><%= funcionario.getCpf() %></td>
        <td><%= empresa.getNome() %></td>
        <td><%= funcionario.getFuncao() %></td>
        <td>
            <form action="<%= request.getContextPath() %>/funcionarioJSP/updateFuncionario.jsp" method="post">
                <input type="hidden" name="id" value="<%= funcionario.getId() %>"/>
                <button type="submit">Update</button>
            </form>
        </td>
        <td>
            <form action="<%= request.getContextPath() %>/ServletDeleteFuncionario" method="post">
                <input type="hidden" name="id" value="<%= funcionario.getId() %>"/>
                <button type="submit">Delete</button>
            </form>
        </td>
    </tr>
    <%
        }
    } else {
    %>
    <tr><td colspan="8">Nenhum funcionário encontrado.</td></tr>
    <%
        }
    %>
</table>
<br>
<a href="<%= request.getContextPath() %>/index.html">Voltar ao início</a>
</body>
</html>
