<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Criar Funcionário</title>
</head>
<body>
<h2>Criar Funcionário</h2>

<form action="<%= request.getContextPath() %>/ServletCreateFuncionario" method="post">
    <label for="nome">Nome:</label>
    <br><br>
    <input type="text" id="nome" name="nome" placeholder="Nome" required>

    <label for="sobrenome">Sobrenome:</label>
    <input type="text" id="sobrenome" name="sobrenome" placeholder="Sobrenome" required>
    <br><br>

    <label for="cpf">CPF:</label>
    <input type="text" id="cpf" name="cpf" placeholder="CPF" pattern="^\d{11}" required>
    <br><br>

    <label for="funcao">Função:</label>
    <input type="text" id="funcao" name="funcao" placeholder="Função" required>
    <br><br>

    <button type="submit">Criar</button>
</form>

<br><br>
<a href="<%= request.getContextPath() %>/ServletReadFuncionario">Voltar à lista</a>
<br><br>
<a href="<%= request.getContextPath() %>/index.html">Voltar ao início</a>
</body>
</html>
