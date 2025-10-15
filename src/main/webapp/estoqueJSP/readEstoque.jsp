<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="com.codcoz.model.Estoque, java.util.List" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Lista de Estoques</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
</head>
<body>
<div class="container">


<form action="<%= request.getContextPath() %>/estoqueJSP/createEstoque.jsp" method="get">
    <button type="submit">Create</button>
</form>
<br>
<%
    String mensagem = (String) request.getAttribute("mensagem");
    if (mensagem != null) {
        boolean sucesso = mensagem.toLowerCase().contains("sucesso");
%>
<div class="mensagem <%= sucesso ? "sucesso" : "erro" %>">
    <%= mensagem %>
</div>
<% } %>


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
            <form action="<%= request.getContextPath() %>/ServletDeleteEstoque" method="get">
                <input type="hidden" name="id" value="<%= est.getId() %>"/>
                <button type="submit">Delete</button>

    <jsp:include page="./../barraLateral.jsp" />
    <main class="content">
        <header class="topo">
            <h2>Lista de Estoques</h2>
            <img src="<%= request.getContextPath() %>/assets/codcoz_icon.png" alt="Logo" class="logo">
        </header>

        <div class="sub-header">
            <span class="hover-link ativo">Estoque</span>
        </div>

        <div class="actions">
            <form action="<%= request.getContextPath() %>/estoqueJSP/createEstoque.jsp" method="get">
                <button type="submit" class="novo">+</button>
            </form>
        </div>

        <% String mensagem = (String) request.getAttribute("mensagem");
            if (mensagem != null) {
                String cor = mensagem.toLowerCase().contains("sucesso") ? "green" : "red"; %>
        <p style="color: <%= cor %>"><%= mensagem %></p>
        <% } %>

        <div class="tabela-container">
            <table>
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Tipo de Estoque</th>
                    <th>Descrição</th>
                    <th>Update</th>
                    <th>Delete</th>
                </tr>
                </thead>
                <tbody>
                <%
                    List<Estoque> lista = (List<Estoque>) request.getAttribute("listaEstoques");
                    if (lista != null && !lista.isEmpty()) {
                        for (Estoque estoque : lista) {
                %>
                <tr>
                    <td class="acoes">
                        <a href="<%= request.getContextPath() %>/estoqueJSP/updateEstoque.jsp?id=<%= estoque.getId() %>">
                            <img src="<%= request.getContextPath() %>/assets/edit_icon.png" alt="Editar">
                        </a>
                    </td>
                    <td class="acoes">
                        <a href="<%= request.getContextPath() %>/ServletDeleteEstoque?id=<%= estoque.getId() %>"
                           onclick="return confirm('Tem certeza que deseja excluir este estoque?');">
                            <img src="<%= request.getContextPath() %>/assets/delete_icon.png" alt="Excluir">
                        </a>
                    </td>
                </tr>
                <%     }
                } else { %>
                <tr>
                    <td colspan="5">Nenhum estoque encontrado.</td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>

        <br>
        <a href="<%= request.getContextPath() %>/index.JSP" class="hover-link">Voltar ao início</a>
    </main>
</div>
</body>
</html>
