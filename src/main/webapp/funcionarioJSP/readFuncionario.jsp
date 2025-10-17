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
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
</head>
<body>
<div class="container">

    <jsp:include page="./../barraLateral.jsp" />

    <main class="content">
        <header class="topo">
            <h2>Lista de Funcionários</h2>
            <img src="<%= request.getContextPath() %>/assets/codcoz_icon.png" alt="Logo" class="logo">
        </header>

        <div class="sub-header">
            <span class="hover-link ativo">Funcionários</span>
        </div>

        <div class="actions">
            <form action="<%= request.getContextPath() %>/funcionarioJSP/createFuncionario.jsp" method="get">
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
                    <th>Nome</th>
                    <th>Sobrenome</th>
                    <th>CPF</th>
                    <th>E-mail</th>
                    <th>Empresa</th>
                    <th>Função</th>
                    <th>Status</th> <!-- ADICIONADO -->
                    <th>Update</th>
                    <th>Delete</th>
                </tr>
                </thead>
                <tbody>
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
                    <td><%= funcionario.getEmail() %></td>
                    <td><%= nomeEmpresa %></td>
                    <td><%= funcionario.getFuncao() %></td>
                    <td><%= funcionario.getStatus() %></td> <!-- ADICIONADO -->
                    <td class="acoes">
                        <a href="<%= request.getContextPath() %>/funcionarioJSP/updateFuncionario.jsp?id=<%= funcionario.getId() %>">
                            <img src="<%= request.getContextPath() %>/assets/edit_icon.png" alt="Editar">
                        </a>
                    </td>
                    <td class="acoes">
                        <a href="<%= request.getContextPath() %>/ServletDeleteFuncionario?id=<%= funcionario.getId() %>"
                           onclick="return confirm('Tem certeza que deseja excluir este funcionário?');">
                            <img src="<%= request.getContextPath() %>/assets/delete_icon.png" alt="Excluir">
                        </a>
                    </td>
                </tr>
                <%     }
                } else { %>
                <tr>
                    <td colspan="10">Nenhum funcionário encontrado.</td> <!-- ajustado de 9 para 10 -->
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>

        <br>
        <a href="<%= request.getContextPath() %>/index.jsp" class="hover-link">Voltar ao início</a>
    </main>
</div>
</body>
</html>
