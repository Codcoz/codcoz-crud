<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Criar Endereço</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
</head>
<body>
<h1>Criar Endereço</h1>
<form action="<%=request.getContextPath()%>/ServletCreateEndereco" method="post">
    <label for="rua">Rua:</label>
    <input type="text" id="rua" name="rua" placeholder="rua" max="100" required><br><br>

    <label for="complemento">Complemento:</label>
    <input type="text" id="complemento" name="complemento" placeholder="complemento" maxlength="50" required><br><br>

    <label for="cidade">Cidade:</label>
    <input type="text" id="cidade" name="cidade" placeholder="cidade" maxlength="80" required><br><br>

    <label for="estado">Estado:</label>
    <%
        String[] estados = {
                "AC", "AL", "AP", "AM", "BA", "CE", "DF", "ES", "GO", "MA", "MT", "MS",
                "MG", "PA", "PB", "PR", "PE", "PI", "RJ", "RN", "RS", "RO", "RR", "SC",
                "SP", "SE", "TO" };
    %>

    <select name="estado" id="estado" required>
        <option value="">Selecione...</option>
        <%
            for (int i = 0; i < estados.length; i++) {
        %>
        <option value="<%= estados[i] %>"><%= estados[i] %></option>
        <%
            }
        %>
    </select>
    <br><br>

    <label for="cep">CEP:</label>
    <input type="text" id="cep" name="cep" placeholder="cep" pattern="^\d{5}-?\d{3}$" maxlength="8" required><br><br>


    <label for="numero">Número:</label>
    <input type="text" id="numero" name="numero" placeholder="numero" maxlength="10"><br><br>

    <button type="submit">CRIAR</button><br><br>

    <a href="<%=request.getContextPath()%>/ServletReadEndereco">Voltar à lista</a><br><br>
    <a href="<%=request.getContextPath()%>/index.html">Voltar ao início</a>
</form>
</body>
</html>