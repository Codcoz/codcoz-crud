<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="com.codcoz.model.Endereco, java.util.List" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Lista de Endereços</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
</head>
<body>
<div class="container">

    <jsp:include page="./../barraLateral.jsp" />

    <main class="content">
        <header class="topo">
            <h2>Lista de Endereços</h2>
            <img src="<%= request.getContextPath() %>/assets/codcoz_icon.png" alt="Logo" class="logo" title="Logo Codcoz">
        </header>

        <div class="sub-header">
            <span class="hover-link ativo" title="Visualizando todos os endereços cadastrados">Endereços</span>
        </div>

        <div class="actions">
            <form action="<%= request.getContextPath() %>/enderecoJSP/createEndereco.jsp" method="get">
                <button type="submit" class="novo" title="Cadastrar novo endereço">+</button>
            </form>
        </div>

        <% String mensagem = (String) request.getAttribute("mensagem");
            if (mensagem != null) {
                String cor = mensagem.toLowerCase().contains("sucesso") ? "green" : "red"; %>
        <p style="color: <%= cor %>" title="Mensagem do sistema"><%= mensagem %></p>
        <% } %>

        <div class="tabela-container">
            <table>
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Rua</th>
                    <th>Complemento</th>
                    <th>Cidade</th>
                    <th>Estado</th>
                    <th>CEP</th>
                    <th>Número</th>
                    <th>Update</th>
                    <th>Delete</th>
                </tr>
                </thead>
                <tbody>
                <%
                    List<Endereco> lista = (List<Endereco>) request.getAttribute("listaEnderecos");
                    if (lista != null && !lista.isEmpty()) {
                        for (Endereco endereco : lista) {
                %>
                <tr>
                    <td title="ID do endereço"><%= endereco.getId() %></td>
                    <td title="Nome da rua"><%= endereco.getRua() %></td>
                    <td title="Complemento do endereço"><%= endereco.getComplemento() %></td>
                    <td title="Cidade"><%= endereco.getCidade() %></td>
                    <td title="Estado"><%= endereco.getEstado() %></td>
                    <td title="CEP"><%= endereco.getCep() %></td>
                    <td title="Número da residência"><%= endereco.getNumero() %></td>
                    <td class="acoes">
                        <a href="<%= request.getContextPath() %>/enderecoJSP/updateEndereco.jsp?id=<%= endereco.getId() %>" title="Editar endereço">
                            <img src="<%= request.getContextPath() %>/assets/edit_icon.png" alt="Editar" title="Editar endereço">
                        </a>
                    </td>
                    <td class="acoes">
                        <a href="<%= request.getContextPath() %>/ServletDeleteEndereco?id=<%= endereco.getId() %>"
                           onclick="return confirm('Tem certeza que deseja excluir este endereço?');"
                           title="Excluir endereço">
                            <img src="<%= request.getContextPath() %>/assets/delete_icon.png" alt="Excluir" title="Excluir endereço">
                        </a>
                    </td>
                </tr>
                <%     }
                } else { %>
                <tr>
                    <td colspan="9" title="Nenhum endereço foi encontrado">Nenhum endereço encontrado.</td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>

        <br>
        <a href="<%= request.getContextPath() %>/index.jsp" class="hover-link" title="Voltar à página inicial">Voltar ao início</a>

    </main>
</div>
</body>
</html>
