<%--
  Created by IntelliJ IDEA.
  User: felipeboregio-ieg
  Date: 15/09/2025
  Time: 18:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form action="ServletCreateEndereco" method="post" style="display: flex">
    <label for="rua">Rua:</label>
    <input type="text" name="rua" id="rua" required placeholder="Ex: Av. Paulista"><br>

    <label for="complemento">Complemento:</label>
    <input type="text" name="complemento" id="complemento" placeholder="Ex: Apto 12, Fundos"><br>

    <label for="cidade">Cidade:</label>
    <input type="text" name="cidade" id="cidade" required placeholder="Ex: São Paulo"><br>

    <label for="estado">Estado:</label>
    <input type="text" name="estado" id="estado" required placeholder="Ex: SP"><br>

    <label for="cep">CEP:</label>
    <input type="text" name="cep" id="cep" required pattern="\d{8}" title="Digite 8 números" placeholder="Ex: 01001000"><br>

    <label for="numero">Número:</label>
    <input type="text" name="numero" id="numero" required placeholder="Ex: 123"><br>

    <button type="submit">Salvar Endereço</button>
</form>
</body>
</html>
