<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Criar Endereço</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
</head>
<body>
<div class="container">
        <jsp:include page="./../barraLateral.jsp" />
    <main class="content">
        <header class="topo">
            <h2>Criar Endereço</h2>
            <img src="C:\Users\giovannasouto-ieg\Downloads\Design sem nome (12).png" alt="Logo" class="logo">
        </header>

        <div class="sub-header">
            <span class="hover-link ativo">Novo Endereço</span>
        </div>

        <div class="actions">
            <form action="<%=request.getContextPath()%>/ServletCreateEndereco" method="post" style="max-width: 500px;">
                <label for="rua">Rua:</label>
                <input type="text" id="rua" name="rua" class="input-redondo" placeholder="rua" max="100" required><br><br>

                <label for="complemento">Complemento:</label>
                <input type="text" id="complemento" name="complemento" class="input-redondo" placeholder="complemento" maxlength="50" required><br><br>

                <label for="cidade">Cidade:</label>
                <input type="text" id="cidade" name="cidade" class="input-redondo" placeholder="cidade" maxlength="80" required><br><br>

                <label for="estado">Estado:</label>
                <% String[] estados = { "AC", "AL", "AP", "AM", "BA", "CE", "DF", "ES", "GO", "MA", "MT", "MS", "MG", "PA", "PB", "PR", "PE", "PI", "RJ", "RN", "RS", "RO", "RR", "SC", "SP", "SE", "TO" }; %>
                <select name="estado" id="estado" class="select-redondo" required>
                    <option value="">Selecione...</option>
                    <% for (int i = 0; i < estados.length; i++) { %>
                    <option value="<%= estados[i] %>"><%= estados[i] %></option>
                    <% } %>
                </select><br><br>

                <label for="cep">CEP:</label>
                <input type="text" id="cep" name="cep" class="input-redondo" placeholder="cep" pattern="^\d{5}-?\d{3}$" maxlength="8" required><br><br>

                <label for="numero">Número:</label>
                <input type="text" id="numero" name="numero" class="input-redondo" placeholder="numero" maxlength="10"><br><br>

                <button type="submit" class="novo">+</button>
            </form>
        </div>

        <br>
        <a href="<%=request.getContextPath()%>/ServletReadEndereco" class="hover-link">Voltar à lista</a><br>
        <a href="<%=request.getContextPath()%>/index.jsp" class="hover-link">Voltar ao início</a>
    </main>
</div>
</body>
</html>
