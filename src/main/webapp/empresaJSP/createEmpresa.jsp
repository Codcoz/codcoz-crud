<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="
    java.util.List,
    com.codcoz.dao.EnderecoDAO,
    com.codcoz.model.Endereco
" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Criar Empresa</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
</head>
<body>
<div class="container">

    <jsp:include page="./../barraLateral.jsp" />

    <main class="content">
        <header class="topo">
            <h2>Criar Empresa</h2>
            <img src="<%= request.getContextPath() %>/assets/codcoz_icon.png" alt="Logo" class="logo">
        </header>

        <div class="sub-header">
            <span class="hover-link ativo">Nova Empresa</span>
        </div>

        <% String mensagem = (String) request.getAttribute("mensagem"); %>
        <% if (mensagem != null) { %>
        <div class="mensagem-aviso"><%= mensagem %></div>
        <% } %>

        <div class="actions">
            <form action="<%= request.getContextPath() %>/ServletCreateEmpresa" method="post" style="max-width: 500px;">
                <label for="nome">Nome:</label><br>
                <input type="text" id="nome" name="nome" class="input-redondo" placeholder="Nome da empresa" maxlength="150" required><br><br>

                <label for="cnpj">CNPJ:</label><br>
                <input type="text" id="cnpj" name="cnpj" class="input-redondo" placeholder="CNPJ" maxlength="14" required>

                <label for="idEndereco">Endereço:</label><br>
                <%
                    List<Endereco> enderecos = new EnderecoDAO().read();
                %>
                <select id="idEndereco" name="idEndereco" class="select-redondo" required>
                    <option value="">Selecione um endereço</option>
                    <% for (Endereco e : enderecos) { %>
                    <option value="<%= e.getId() %>">
                        (<%= e.getCep() %>) <%= e.getCidade() %>, rua <%= e.getRua() %>, <%= e.getNumero() %> - <%= e.getEstado() %>
                    </option>
                    <% } %>
                </select>
                <br>
                <a href="../enderecoJSP/createEndereco.jsp" class="hover-link">Criar Endereço</a>
                <br><br>

                <label for="email">Email:</label><br>
                <input type="email" id="email" name="email" class="input-redondo"
                       pattern="^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.((com|net|org|gov|edu|info|biz|co)(\\.br)?|br)$"
                       placeholder="Email da empresa" required><br>

                <button type="submit" class="novo">+</button>
            </form>
        </div>

        <br>
        <a href="<%= request.getContextPath() %>/ServletReadEmpresa" class="hover-link">Voltar à lista</a><br>
        <a href="<%= request.getContextPath() %>/index.html" class="hover-link">Voltar ao início</a>
    </main>
</div>

<script>

</script>
</body>
</html>
