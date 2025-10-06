<%@ page import="com.codcoz.model.Produto" %>
<%@ page import="com.codcoz.dao.ProdutoDAO" %>
<%@ page import="com.codcoz.dao.EstoqueDAO" %>
<%@ page import="com.codcoz.dao.NotaFiscalXmlDAO" %>
<%@ page import="com.codcoz.dao.EmpresaDAO" %>
<%@ page import="com.codcoz.model.Estoque" %>
<%@ page import="com.codcoz.model.NotaFiscalXml" %>
<%@ page import="com.codcoz.model.Empresa" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Integer id = Integer.parseInt(request.getParameter("id"));
    Produto produto = null;
    List<Estoque> estoques = new EstoqueDAO().read();
    List<NotaFiscalXml> notas = new NotaFiscalXmlDAO().read();
    EmpresaDAO empresaDAO = new EmpresaDAO();

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
<h2>Atualizar Produto de Nome <%= produto.getNome() %></h2>

<form action="<%=request.getContextPath()%>/ServletUpdateProduto" method="post">
    <input type="hidden" name="id" value="<%= produto.getId() %>"/>

    <label for="nome">Nome:</label>
    <input type="text" id="nome" name="nome" value="<%= produto.getNome() %>" required placeholder="Ex: Arroz Integral"><br><br>

    <label for="categoria">Categoria:</label>
    <input type="text" id="categoria" name="categoria" value="<%= produto.getCategoria() %>" required placeholder="Ex: Alimentos"><br><br>

    <label for="unidadeMedida">Unidade de Medida:</label>
    <select id="unidadeMedida" name="unidadeMedida" required>
        <option value="">Selecione</option>
        <option value="g" <%= "g".equals(produto.getUnidadeMedida()) ? "selected" : "" %>>g</option>
        <option value="kg" <%= "kg".equals(produto.getUnidadeMedida()) ? "selected" : "" %>>kg</option>
        <option value="ml" <%= "ml".equals(produto.getUnidadeMedida()) ? "selected" : "" %>>ml</option>
        <option value="L" <%= "L".equals(produto.getUnidadeMedida()) ? "selected" : "" %>>L</option>
        <option value="caixa" <%= "caixa".equals(produto.getUnidadeMedida()) ? "selected" : "" %>>caixa</option>
        <option value="unidade" <%= "unidade".equals(produto.getUnidadeMedida()) ? "selected" : "" %>>unidade</option>
    </select><br><br>

    <label for="estoqueMinimo">Estoque Mínimo:</label>
    <input type="number" step="0.01" id="estoqueMinimo" name="estoqueMinimo" value="<%= produto.getEstoqueMinimo() %>" required><br><br>

    <label for="quantidade">Quantidade:</label>
    <input type="number" id="quantidade" name="quantidade" value="<%= produto.getQuantidade() %>" required><br><br>

    <label for="idEstoque">Estoque:</label>
    <select id="idEstoque" name="idEstoque" required>
        <option value="">Selecione um estoque</option>
        <% for (Estoque est : estoques) {
            Empresa empresa = empresaDAO.buscarPorId(est.getIdEmpresa());
        %>
        <option value="<%= est.getId() %>" <%= est.getId().equals(produto.getIdEstoque()) ? "selected" : "" %>>
            <%= est.getTipoEstoque() %> (Empresa: <%= empresa != null ? empresa.getNome() : "Desconhecida" %>)
        </option>
        <% } %>
    </select><br><br>

    <label for="idNotaFiscal">Nota Fiscal:</label>
    <select id="idNotaFiscal" name="idNotaFiscal" required>
        <option value="">Selecione uma nota fiscal</option>
        <% for (NotaFiscalXml nota : notas) {
            Empresa empresa = empresaDAO.buscarPorId(nota.getIdEmpresa());
        %>
        <option value="<%= nota.getId() %>" <%= nota.getId().equals(produto.getIdNotaFiscal()) ? "selected" : "" %>>
            Nº <%= nota.getNumeroNota() %> - Empresa: <%= empresa != null ? empresa.getNome() : "Desconhecida" %>
        </option>
        <% } %>
    </select><br><br>

    <input type="hidden" name="idEmpresa" value="<%= produto.getIdEmpresa() %>"/>

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