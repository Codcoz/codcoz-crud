<%@ page import="com.codcoz.model.Funcionario" %>
<%@ page import="com.codcoz.dao.FuncionarioDAO" %>
<%@ page import="com.codcoz.model.Empresa" %>
<%@ page import="com.codcoz.dao.EmpresaDAO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Integer id = null;
    try {
        id = Integer.parseInt(request.getParameter("id"));
    } catch (Exception e) {
        // parâmetro inválido
    }

    Funcionario funcionario = null;
    List<Empresa> empresas = new EmpresaDAO().read();

    if (id != null) {
        FuncionarioDAO funcionarioDAO = new FuncionarioDAO();
        funcionario = funcionarioDAO.buscarPorId(id);
    }
%>

<html>
<head>
    <title>Atualizar Funcionário</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
</head>
<body>
<% if (funcionario != null) { %>
<h2>Atualizar Funcionário de ID <%= funcionario.getId() %></h2>

<form action="<%=request.getContextPath()%>/ServletUpdateFuncionario" method="post">
    <input type="hidden" name="id" value="<%= funcionario.getId() %>"/>

    <label for="nome">Nome:</label>
    <input type="text" id="nome" name="nome"
           value="<%= funcionario.getNome() %>"
           maxlength="50" placeholder="Ex: Ana">
    <br><br>

    <label for="sobrenome">Sobrenome:</label>
    <input type="text" id="sobrenome" name="sobrenome"
           value="<%= funcionario.getSobrenome() %>"
            maxlength="50" placeholder="Ex: Silva">
    <br><br>

    <label for="cpf">CPF:</label>
    <input type="text" id="cpf" name="cpf"
           value="<%= funcionario.getCpf() %>" maxlength="11"
           pattern="^\d{3}\.\d{3}\.\d{3}-\d{2}$|^\d{11}$"
           required placeholder="Ex: 123.456.789-00">
    <br><br>

    <label for="idEmpresa">Empresa:</label>
    <select id="idEmpresa" name="idEmpresa" required>
        <option value="">Selecione uma empresa</option>
        <% for (Empresa e : empresas) { %>
        <option value="<%= e.getId() %>"
                <%= (e.getId() != null && e.getId().equals(funcionario.getIdEmpresa())) ? "selected" : "" %>>
            <%= e.getNome() %> (ID <%= e.getId() %>)
        </option>
        <% } %>
    </select>
    <a href="../empresaJSP/createEmpresa.jsp">Criar Empresa</a>
    <br><br>

    <label for="funcao">Função:</label>
    <input type="text" id="funcao" name="funcao"
           value="<%= funcionario.getFuncao() %>"
           required placeholder="Ex: Analista">
    <br><br>

    <button type="submit">Update</button>
</form>
<% } else { %>
<p>Funcionário não encontrado.</p>
<% } %>

<br><br>
<a href="<%=request.getContextPath()%>/ServletReadFuncionario">Voltar à lista</a> <br><br>
<a href="<%=request.getContextPath()%>/index.html">Voltar ao início</a>
</body>
</html>
