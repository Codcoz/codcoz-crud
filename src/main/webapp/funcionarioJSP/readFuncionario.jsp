<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="
    com.codcoz.model.Funcionario,
    com.codcoz.model.Empresa,
    com.codcoz.dao.EmpresaDAO,
    java.util.List
" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Lista de Funcionários</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
</head>
<body>

<h2>Lista de Funcionários</h2>

<form action="<%= request.getContextPath() %>/funcionarioJSP/createFuncionario.jsp" method="get">
    <button type="submit">Create</button>
</form>
<br>

<%
    String mensagem = (String) request.getAttribute("mensagem");
    if (mensagem != null) {
        String cor = mensagem.toLowerCase().contains("sucesso") ? "green" : "red";
%>
<p style="color: <%= cor %>"><%= mensagem %></p>
<%
    }
%>

<table border="1" cellpadding="8" cellspacing="0">
    <tr>
        <th>ID</th>
        <th>Nome</th>
        <th>Sobrenome</th>
        <th>CPF</th>
        <th>Empresa</th>
        <th>Função</th>
        <th>Update</th>
        <th>Delete</th>
    </tr>
    <%
        List<Funcionario> lista = (List<Funcionario>) request.getAttribute("listaFuncionarios");
        EmpresaDAO empresaDAO = new EmpresaDAO();

        if (lista != null && !lista.isEmpty()) {
            for (Funcionario funcionario : lista) {
                Empresa empresa = null;
                try {
                    empresa = empresaDAO.buscarPorId(funcionario.getIdEmpresa());
                } catch (Exception ignore) { }
                String nomeEmpresa = (empresa != null && empresa.getNome() != null) ? empresa.getNome() : "—";
    %>
    <tr>
        <td><%= funcionario.getId() %></td>
        <td><%= funcionario.getNome() %></td>
        <td><%= funcionario.getSobrenome() %></td>
        <td><%= funcionario.getCpf() %></td>
        <td><%= nomeEmpresa %></td>
        <td><%= funcionario.getFuncao() %></td>
        <td>
            <form action="<%= request.getContextPath() %>/funcionarioJSP/updateFuncionario.jsp" method="get">
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
    <tr>
        <td colspan="8">Nenhum funcionário encontrado.</td>
    </tr>
    <%
        }
    %>
</table>

<br>
<a href="<%= request.getContextPath() %>/index.html">Voltar ao início</a>
</body>
</html>
