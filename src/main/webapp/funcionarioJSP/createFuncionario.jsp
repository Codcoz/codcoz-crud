<%--
  Created by IntelliJ IDEA.
  User: felipeboregio-ieg
  Date: 18/09/2025
  Time: 14:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Criar Funcionário</title>
</head>
<body>
<form action="<%=request.getContextPath()%>/ServletCreateFuncionario" method="post">
    <input type="number" name="idEmpresa" placeholder="ID da Empresa" required>
    <input type="number" name="idFuncao" placeholder="ID da Função" required>
    <input type="text" name="nome" placeholder="Nome" required>
    <input type="text" name="sobrenome" placeholder="Sobrenome" required>
    <input type="text" name="cpf" placeholder="CPF" required>
    <br><br>

    <button type="submit">CRIAR</button>
    <br><br>

    <a href="<%=request.getContextPath()%>/ServletReadFuncionario">Voltar à lista</a> <br><br>
    <a href="<%=request.getContextPath()%>/index.html">Voltar ao início</a>
</form>
</body>
</html>
