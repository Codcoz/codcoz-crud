<%@ page import="com.codcoz.dao.EmpresaDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="com.codcoz.model.Empresa" %>
<%@ page import="com.codcoz.dao.EnderecoDAO" %>
<%@ page import="com.codcoz.model.Endereco" %><%--
  Created by IntelliJ IDEA.
  User: felipeboregio-ieg
  Date: 25/09/2025
  Time: 22:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Criar Empresa</title>
</head>
<body>
<form action="<%=request.getContextPath()%>/ServletCreateEmpresa" method="post">
    <input type="text" name="nome" placeholder="Nome da empresa" required>
    <input type="text" name="cnpj" placeholder="CNPJ" pattern="^\d{14}" required>
    <label for="idEndereco">Endereço:</label>
    <% List<Endereco> enderecos = new EnderecoDAO().read(); %>
            <select name="idEndereco" required>
        <option value="">Selecione um endereço</option>
        <% for (Endereco e : enderecos) { %>
        <option value="<%=e.getId()%>">(<%=e.getCep()%>) <%=e.getCidade()%>, rua <%= e.getRua()%>, <%=e.getNumero()%> - <%=e.getEstado()%></option>
        <% } %>
    </select>

    <button type="submit">CRIAR</button>
    <br><br>
    <a href="<%=request.getContextPath()%>/ServletReadEmpresa">Voltar à lista</a> <br><br>
    <a href="<%=request.getContextPath()%>/index.html">Voltar ao início</a>
</form>
</body>
</html>