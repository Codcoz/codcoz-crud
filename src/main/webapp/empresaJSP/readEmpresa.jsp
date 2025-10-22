<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="
    com.codcoz.model.Empresa,
    com.codcoz.dao.EnderecoDAO,
    com.codcoz.model.Endereco,
    java.util.List
" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Lista de Empresas</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
</head>
<body>
<div class="container">

    <jsp:include page="./../barraLateral.jsp" />

    <main class="content">
        <header class="topo">
            <h2>Lista de Empresas</h2>
            <img src="<%= request.getContextPath() %>/assets/codcoz_icon.png" alt="Logo" class="logo" title="Logo Codcoz">
        </header>

        <div class="sub-header">
            <span class="hover-link ativo" title="Visualizando todas as empresas cadastradas">Empresas</span>
        </div>

        <div class="actions">
            <form action="<%= request.getContextPath() %>/empresaJSP/createEmpresa.jsp" method="get">
                <button type="submit" class="novo" title="Cadastrar nova empresa">+</button>
            </form>
        </div>

        <% String mensagem = (String) request.getAttribute("mensagem");
            if (mensagem != null) {
                String cor = mensagem.contains("sucesso") ? "green" : "red"; %>
        <p style="color: <%= cor %>" title="Mensagem do sistema"><%= mensagem %></p>
        <% } %>

        <div class="tabela-container">
            <table>
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Nome</th>
                    <th>CNPJ</th>
                    <th>Endereço</th>
                    <th>Email</th>
                    <th>Update</th>
                    <th>Delete</th>
                </tr>
                </thead>
                <tbody>
                <%
                    List<Empresa> lista = (List<Empresa>) request.getAttribute("listaEmpresas");
                    EnderecoDAO enderecoDAO = new EnderecoDAO();

                    if (lista != null && !lista.isEmpty()) {
                        for (Empresa empresa : lista) {
                            Endereco endereco = enderecoDAO.buscarPorId(empresa.getIdEndereco());
                %>
                <tr>
                    <td title="ID da empresa"><%= empresa.getId() %></td>
                    <td title="Nome da empresa"><%= empresa.getNome() %></td>
                    <td title="CNPJ da empresa"><%= empresa.getCnpj() %></td>
                    <td title="Endereço completo da empresa">
                        (<%= endereco.getCep() %>) <%= endereco.getCidade() %>,
                        rua <%= endereco.getRua() %>, nº <%= endereco.getNumero() %> —
                        <%= endereco.getEstado() %>
                    </td>
                    <td title="E-mail da empresa"><%= empresa.getEmail() %></td>
                    <td class="acoes">
                        <a href="<%= request.getContextPath() %>/empresaJSP/updateEmpresa.jsp?id=<%= empresa.getId() %>" title="Editar empresa">
                            <img src="<%= request.getContextPath() %>/assets/edit_icon.png" alt="Editar" title="Editar empresa">
                        </a>
                    </td>
                    <td class="acoes">
                        <a href="<%= request.getContextPath() %>/ServletDeleteEmpresa?id=<%= empresa.getId() %>"
                           onclick="return confirm('Tem certeza que deseja excluir <%= empresa.getNome() %>?');"
                           title="Excluir empresa">
                            <img src="<%= request.getContextPath() %>/assets/delete_icon.png" alt="Excluir" title="Excluir empresa">
                        </a>
                    </td>
                </tr>
                <%     }
                } else { %>
                <tr>
                    <td colspan="7" title="Nenhuma empresa foi encontrada">Nenhuma empresa encontrada.</td>
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
