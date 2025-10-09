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
</head>
<body>
<h2>Criar Empresa</h2>

<form action="<%= request.getContextPath() %>/ServletCreateEmpresa" method="post">
    <label for="nome">Nome:</label>
    <input type="text" id="nome" name="nome" placeholder="Nome da empresa" maxlength="150" required>
    <br><br>

    <label for="cnpj">CNPJ:</label>
    <input type="text" id="cnpj" name="cnpj" placeholder="CNPJ" maxlength="14" required>
    <c:if test="${not empty erroCnpj}">
        <p style="color:red">${erroCnpj}</p>
    </c:if>

    <br><br>

    <label for="idEndereco">Endereço:</label>
    <%
        List<Endereco> enderecos = new EnderecoDAO().read();
    %>
    <select id="idEndereco" name="idEndereco" required>
        <option value="">Selecione um endereço</option>
        <% for (Endereco e : enderecos) { %>
        <option value="<%= e.getId() %>">
            (<%= e.getCep() %>) <%= e.getCidade() %>, rua <%= e.getRua() %>, <%= e.getNumero() %> - <%= e.getEstado() %>
        </option>
        <% } %>
    </select>
    <a href="../enderecoJSP/createEndereco.jsp">Criar Endereco</a>
    <br><br>

    <label for="email">Email:</label>
    <input type="email" id="email" name="email" placeholder="Email da empresa" required>
    <br><br>

    <c:if test="${not empty erroCnpj}">
        <p style="color:red">${erroCnpj}</p>
    </c:if>

    <c:if test="${not empty erroEmail}">
        <p style="color:red">${erroEmail}</p>
    </c:if>


    <button type="submit">Criar</button>
</form>

<br><br>
<a href="<%= request.getContextPath() %>/ServletReadEmpresa">Voltar à lista</a>
<br><br>
<a href="<%= request.getContextPath() %>/index.html">Voltar ao início</a>
</body>
</html>