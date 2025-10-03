<%@ page import="com.codcoz.model.Empresa" %>
<%@ page import="com.codcoz.dao.EmpresaDAO" %>
<%@ page import="com.codcoz.dao.EnderecoDAO" %>
<%@ page import="com.codcoz.model.Endereco" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Integer id = Integer.parseInt(request.getParameter("id"));
    Empresa empresa = null;
    List<Endereco> enderecos = new EnderecoDAO().read();

    if (id != null) {
        EmpresaDAO empresaDAO = new EmpresaDAO();
        empresa = empresaDAO.buscarPorId(id);
    }
%>

<html>
<head>
    <title>Atualizar Empresa</title>
</head>
<body>
<% if (empresa != null) { %>
<h2>Atualizar Empresa de ID <%= empresa.getId() %></h2>

<form action="<%=request.getContextPath()%>/ServletUpdateEmpresa" method="post">
    <input type="hidden" name="id" value="<%= empresa.getId() %>"/>

    <label for="nome">Nome:</label>
    <input type="text" id="nome" name="nome" value="<%= empresa.getNome() %>" required placeholder="Ex: Codcoz Ltda"><br><br>

    <label for="cnpj">CNPJ:</label>
    <input type="text" id="cnpj" name="cnpj" value="<%= empresa.getCnpj() %>" required placeholder="Ex: 12.345.678/0001-90"><br><br>

    <label for="idEndereco">Endereço:</label>
    <select id="idEndereco" name="idEndereco" required>
        <option value="">Selecione um endereço</option>
        <% for (Endereco e : enderecos) { %>
        <option value="<%= e.getId() %>" <%= e.getId() == empresa.getIdEndereco() ? "selected" : "" %>>
            (<%= e.getCep() %>) <%= e.getCidade() %>, rua <%= e.getRua() %>, <%= e.getNumero() %> - <%= e.getEstado() %>
        </option>
        <% } %>
    </select><br><br>

    <label for="email">Email:</label>
    <input type="email" id="email" name="email" value="<%= empresa.getEmail() %>" required placeholder="Ex: contato@empresa.com.br"><br><br>

    <button type="submit">Update</button>
</form>
<% } else { %>
<p>Empresa não encontrada.</p>
<% } %>

<br><br>
<a href="<%=request.getContextPath()%>/ServletReadEmpresa">Voltar à lista</a> <br><br>
<a href="<%=request.getContextPath()%>/index.html">Voltar ao início</a>
</body>
</html>