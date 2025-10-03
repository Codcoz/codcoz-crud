<%@ page import="com.codcoz.model.Produto" %>
<%@ page import="com.codcoz.dao.ProdutoDAO" %>
<%@ page import="com.codcoz.dao.EmpresaDAO" %>
<%@ page import="com.codcoz.model.Empresa" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Integer id = Integer.parseInt(request.getParameter("id"));
    Produto produto = null;
    List<Empresa> empresas = new EmpresaDAO().read();

    if (id != null) {
        ProdutoDAO produtoDAO = new ProdutoDAO();
        produto = produtoDAO.buscarPorId(id);
    }
%>

<html>
<head>
    <title>Atualizar Produto</title>
</head>
<body>
<% if (produto != null) { %>
<h2>Atualizar Produto de ID <%= produto.getNome() %></h2>

<form action="<%=request.getContextPath()%>/ServletUpdateProduto" method="post">
    <input type="hidden" name="id" value="<%= produto.getId() %>"/>

    <label for="nome">Nome:</label>
    <input type="text" id="nome" name="nome" value="<%= produto.getNome() %>" required placeholder="Ex: Arroz Integral"><br><br>

    <label for="categoria">Categoria:</label>
    <input type="text" id="categoria" name="categoria" value="<%= produto.getCategoria() %>" required placeholder="Ex: Alimentos"><br><br>

    <label for="unidadeMedida">Unidade de Medida:</label>
    <select id="unidadeMedida" name="unidadeMedida" required>
        <option value="">Selecione</option>
        <option value="kg" <%= "kg".equals(produto.getUnidadeMedida()) ? "selected" : "" %>>kg</option>
        <option value="L" <%= "L".equals(produto.getUnidadeMedida()) ? "selected" : "" %>>L</option>
        <option value="unid" <%= "unid".equals(produto.getUnidadeMedida()) ? "selected" : "" %>>unid</option>
    </select><br><br>

    <label for="estoqueMinimo">Estoque Mínimo:</label>
    <input type="number" step="0.01" id="estoqueMinimo" name="estoqueMinimo" value="<%= produto.getEstoqueMinimo() %>" required><br><br>

    <label for="quantidade">Quantidade:</label>
    <input type="number" id="quantidade" name="quantidade" value="<%= produto.getQuantidade() %>" required><br><br>

    <label for="idEmpresa">Empresa:</label>
    <select id="idEmpresa" name="idEmpresa" required>
        <option value="">Selecione uma empresa</option>
        <% for (Empresa emp : empresas) { %>
        <option value="<%= emp.getId() %>" <%= emp.getId().equals(produto.getIdEmpresa()) ? "selected" : "" %>>
            <%= emp.getNome() %> (CNPJ: <%= emp.getCnpj() %>)
        </option>
        <% } %>
    </select><br><br>

    <button type="submit">Update</button>
</form>
<% } else { %>
<p>Produto não encontrado.</p>
<% } %>

<br><br>
<a href="<%=request.getContextPath()%>/ServletReadProduto">Voltar à lista</a> <br><br>
<a href="<%=request.getContextPath()%>/index.html">Voltar ao início</a>
</body>
</html>