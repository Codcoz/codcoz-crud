<%@ page import="com.codcoz.model.Empresa" %>
<%@ page import="com.codcoz.dao.EmpresaDAO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Criar Funcionário</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
</head>
<body>
<h2>Criar Funcionário</h2>

<form action="<%= request.getContextPath() %>/ServletCreateFuncionario" method="post">
    <label for="nome">Nome:</label>
    <input type="text" id="nome" name="nome" placeholder="Nome" maxlength="50" required>
    <br><br>
    <label for="sobrenome">Sobrenome:</label>
    <input type="text" id="sobrenome" name="sobrenome" placeholder="Sobrenome" maxlength="50" required>
    <br><br>

    <label for="cpf">CPF:</label>
    <input type="text" id="cpf" name="cpf" placeholder="CPF" maxlength="11"
           pattern="^\d{3}\.\d{3}\.\d{3}-\d{2}$|^\d{11}$" required>
    <br><br>
    <label for="funcao">Função:</label>
    <select id="funcao" name="funcao" required>
        <option value="" disabled selected>Selecione a função</option>
        <option value="Estoquista">Estoquista</option>
        <option value="Gestor">Gestor</option>
    </select>
    <br><br>
    <label for="idEmpresa">Empresa:</label>
    <%
        List<Empresa> empresas = new EmpresaDAO().read();
    %>
    <select id="idEmpresa" name="idEmpresa" required>
        <option value="">Selecione uma empresa</option>
        <% for (Empresa emp : empresas) { %>
        <option value="<%= emp.getId() %>">
            <%= emp.getNome() %> (CNPJ: <%= emp.getCnpj() %>)
        </option>
        <% } %>
    </select>
    <a href="../empresaJSP/createEmpresa.jsp">Criar Empresa</a>
    <br><br>
    <button type="submit">Criar</button>
</form>

<br><br>
<a href="<%= request.getContextPath() %>/ServletReadFuncionario">Voltar à lista</a>
<br><br>
<a href="<%= request.getContextPath() %>/index.jsp">Voltar ao início</a>
</body>
</html>
