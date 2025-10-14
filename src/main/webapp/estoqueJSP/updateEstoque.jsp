<%@ page import="com.codcoz.model.Estoque" %>
<%@ page import="com.codcoz.dao.EstoqueDAO" %>
<%@ page import="com.codcoz.dao.EmpresaDAO" %>
<%@ page import="com.codcoz.model.Empresa" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Integer id = Integer.parseInt(request.getParameter("id"));
    Estoque estoque = null;
    List<Empresa> empresas = new EmpresaDAO().read();

    if (id != null) {
        EstoqueDAO dao = new EstoqueDAO();
        estoque = dao.buscarPorId(id);
    }
%>

<html>
<head>
    <title>Atualizar Estoque</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
</head>
<body>
<% if (estoque != null) { %>
<h2>Atualizar Estoque</h2>

<form action="<%= request.getContextPath() %>/ServletUpdateEstoque" method="post">
    <input type="hidden" name="id" value="<%= estoque.getId() %>"/>

    <label for="tipoEstoque">Tipo de Estoque:</label>
    <input type="text" id="tipoEstoque" name="tipoEstoque" value="<%= estoque.getTipoEstoque() %>" maxlength="30" required><br><br>

    <label for="capacidade">Capacidade(Kg/L):</label>
    <input type="number" id="capacidade" name="capacidade" value="<%= estoque.getCapacidade() %>" required><br><br>

    <label for="idEmpresa">Empresa:</label>
    <select id="idEmpresa" name="idEmpresa" required>
        <option value="">Selecione uma empresa</option>
        <% for (Empresa emp : empresas) { %>
        <option value="<%= emp.getId() %>" <%= emp.getId().equals(estoque.getIdEmpresa()) ? "selected" : "" %>>
            <%= emp.getNome() %>
        </option>
        <% } %>
    </select><br>
    <a href="../empresaJSP/createEmpresa.jsp">Criar Empresa</a>
    <br><br>

    <button type="submit">Atualizar</button>
</form>
<% } else { %>
<p>Estoque não encontrado.</p>
<% } %>

<br><br>
<a href="<%= request.getContextPath() %>/ServletReadEstoque">Voltar à lista</a>
</body>
</html>