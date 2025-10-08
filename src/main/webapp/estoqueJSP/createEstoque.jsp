<%@ page import="com.codcoz.dao.EmpresaDAO, com.codcoz.model.Empresa, java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Criar Estoque</title>
</head>
<body>
<h2>Criar Estoque</h2>

<form action="<%= request.getContextPath() %>/ServletCreateEstoque" method="post">
    <label for="tipoEstoque">Tipo de Estoque:</label>
    <input type="text" id="tipoEstoque" name="tipoEstoque" required><br><br>

    <label for="capacidade">Capacidade:</label>
    <input type="number" id="capacidade" name="capacidade(Kg/L)" required><br><br>

    <label for="idEmpresa">Empresa:</label>
    <%
        List<Empresa> empresas = new EmpresaDAO().read();
    %>
    <select id="idEmpresa" name="idEmpresa" required>
        <option value="">Selecione uma empresa</option>
        <% for (Empresa emp : empresas) { %>
        <option value="<%= emp.getId() %>"><%= emp.getNome() %></option>
        <% } %>
    </select><br><br>

    <button type="submit">Criar</button>
</form>

<br><br>
<a href="<%= request.getContextPath() %>/ServletReadEstoque">Voltar à lista</a>
</body>
</html>