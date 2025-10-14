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
    <style>
        .tabela-container {
            flex: 1;
            overflow-y: auto;
            max-height: 60vh;
            margin-top: 20px;
            border: 1px solid #ccc;
            border-radius: 8px;
            background-color: white;
        }
    </style>
</head>
<body>
<div class="container">

    <jsp:include page="./../barraLateral.jsp" />

    <main class="content">
        <header class="topo">
            <h2>Lista de Empresas</h2>
            <img src="<%= request.getContextPath() %>/assets/codcoz_icon.png" alt="Logo" class="logo">
        </header>

        <div class="sub-header">
            <span class="hover-link ativo">Empresas</span>
        </div>

        <div class="actions">
            <form action="<%= request.getContextPath() %>/empresaJSP/createEmpresa.jsp" method="get">
                <button type="submit" class="novo">+</button>
            </form>
        </div>

        <% String mensagem = (String) request.getAttribute("mensagem");
            if (mensagem != null) {
                String cor = mensagem.contains("sucesso") ? "green" : "red"; %>
        <p style="color: <%= cor %>"><%= mensagem %></p>
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
                    <td><%= empresa.getId() %></td>
                    <td><%= empresa.getNome() %></td>
                    <td><%= empresa.getCnpj() %></td>
                    <td>
                        (<%= endereco.getCep() %>) <%= endereco.getCidade() %>,
                        rua <%= endereco.getRua() %>, nº <%= endereco.getNumero() %> —
                        <%= endereco.getEstado() %>
                    </td>
                    <td><%= empresa.getEmail() %></td>
                    <td class="acoes">
                        <a href="<%= request.getContextPath() %>/empresaJSP/updateEmpresa.jsp?id=<%= empresa.getId() %>">
                            <img src="<%=request.getContextPath()%>/assets/edit_icon.png" alt="Editar">
                        </a>
                    </td>
                    <td class="acoes">
                        <a href="<%= request.getContextPath() %>/ServletDeleteEmpresa?id=<%= empresa.getId() %>"
                           onclick="return confirm('Tem certeza que deseja excluir <%=empresa.getNome()%>?');">
                            <img src="<%=request.getContextPath()%>/assets/delete_icon.png" alt="Excluir">
                        </a>
                    </td>
                </tr>
                <%     }
                } else { %>
                <tr>
                    <td colspan="7">Nenhuma empresa encontrada.</td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>

        <br>
        <a href="<%= request.getContextPath() %>/index.html" class="hover-link">Voltar ao início</a>
    </main>
</div>
</body>
</html>
