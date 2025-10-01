
<%@ page import="com.codcoz.model.Alerta" %>
<%@ page import="com.codcoz.dao.AlertaDAO" %>
<%@ page import="com.codcoz.dao.EmpresaDAO" %>
<%@ page import="com.codcoz.dao.ProdutoDAO" %>
<%@ page import="com.codcoz.model.Empresa" %>
<%@ page import="com.codcoz.model.Produto" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Integer id = Integer.parseInt(request.getParameter("id"));
    Alerta alerta = null;
    List<Empresa> empresas = new EmpresaDAO().read();
    List<Produto> produtos = new ProdutoDAO().read();

    if (id != null) {
        AlertaDAO alertaDAO = new AlertaDAO();
        alerta = alertaDAO.buscarPorId(id);
    }
%>

<html>
<head>
    <title>Atualizar Alerta</title>
</head>
<body>
<% if (alerta != null) { %>
<h2>Atualizar Alerta de ID <%= alerta.getId() %></h2>

<form action="<%=request.getContextPath()%>/ServletUpdateAlerta" method="post">
    <input type="hidden" name="id" value="<%= alerta.getId() %>"/>

    <label for="idEmpresa">Empresa:</label>
    <select id="idEmpresa" name="idEmpresa" required>
        <option value="">Selecione uma empresa</option>
        <% for (Empresa emp : empresas) { %>
        <option value="<%= emp.getId() %>" <%= emp.getId() == alerta.getIdEmpresa() ? "selected" : "" %>>
            <%= emp.getNome() %> (CNPJ: <%= emp.getCnpj() %>)
        </option>
        <% } %>
    </select><br><br>

    <label for="idProduto">Produto:</label>
    <select id="idProduto" name="idProduto" required>
        <option value="">Selecione um produto</option>
        <% for (Produto prod : produtos) { %>
        <option value="<%= prod.getId() %>" <%= prod.getId() == alerta.getIdProduto() ? "selected" : "" %>>
            <%= prod.getNome() %> - <%= prod.getCategoria() %>
        </option>
        <% } %>
    </select><br><br>

    <label for="dataCriacao">Data de Criação:</label>
    <input type="date" id="dataCriacao" name="dataCriacao"
           value="<%= alerta.getDataCriacao().toString() %>" required><br><br>

    <label for="status">Status:</label>
    <select id="status" name="status" required>
        <option value="">Selecione o status</option>
        <option value="pendente">Pendente</option>
        <option value="resolvido">Resolvido</option>

    </select><br><br>

    <label for="tipoAlerta">Tipo de Alerta:</label>
    <input type="text" id="tipoAlerta" name="tipoAlerta"
           value="<%= alerta.getTipoAlerta() %>" required placeholder="Ex: Estoque baixo"><br><br>

    <button type="submit">Update</button>
</form>
<% } else { %>
<p>Alerta não encontrado.</p>
<% } %>

<br><br>
<a href="<%=request.getContextPath()%>/ServletReadAlerta">Voltar à lista</a> <br><br>
<a href="<%=request.getContextPath()%>/index.html">Voltar ao início</a>
</body>
</html>
