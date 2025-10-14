<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="
    com.codcoz.model.Produto,
    com.codcoz.dao.ProdutoDAO,
    com.codcoz.dao.EstoqueDAO,
    com.codcoz.dao.NotaFiscalXmlDAO,
    com.codcoz.dao.EmpresaDAO,
    com.codcoz.model.Estoque,
    com.codcoz.model.NotaFiscalXml,
    com.codcoz.model.Empresa,
    java.util.List
" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    Produto produto = new ProdutoDAO().buscarPorId(id);
    List<Estoque> estoques = new EstoqueDAO().buscarPorEmpresa(produto.getIdEmpresa());
    List<NotaFiscalXml> notas = new NotaFiscalXmlDAO().buscarPorEmpresa(produto.getIdEmpresa());
    Empresa empresa = new EmpresaDAO().buscarPorId(produto.getIdEmpresa());
%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Atualizar Produto</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
</head>
<body>

<% if (produto != null) { %>
<h2>Atualizar Produto ID <%= produto.getId() %></h2>

<form action="<%= request.getContextPath() %>/ServletUpdateProduto" method="post">
    <input type="hidden" name="id" value="<%= produto.getId() %>"/>
    <input type="hidden" name="idEmpresa" value="<%= produto.getIdEmpresa() %>"/>

    <p>Empresa: <%= empresa.getNome() %></p>

    <label for="idEstoque">Estoque:</label>
    <select id="idEstoque" name="idEstoque" required>
        <option value="">Selecione um estoque</option>
        <% for (Estoque e : estoques) { %>
        <option value="<%= e.getId() %>" <%= e.getId().equals(produto.getIdEstoque()) ? "selected" : "" %>>
            <%= e.getTipoEstoque() %>
        </option>
        <% } %>
    </select>
    <a href="../estoqueJSP/createEstoque.jsp">Criar Estoque</a>
    <br><br>

    <label for="idNotaFiscal">Nota Fiscal XML:</label>
    <select id="idNotaFiscal" name="idNotaFiscal" required>
        <option value="">Selecione uma nota fiscal</option>
        <% for (NotaFiscalXml n : notas) { %>
        <option value="<%= n.getId() %>" <%= n.getId().equals(produto.getIdNotaFiscal()) ? "selected" : "" %>>
            <%= n.getNumeroNota() %>
        </option>
        <% } %>
    </select>
    <a href="../notaFiscalXmlJSP/createNotaFiscalXml.jsp">Criar Nota Fiscal XML</a>
    <br><br>

    <label for="unidadeMedida">Unidade de medida:</label>
    <select id="unidadeMedida" name="unidadeMedida" required>
        <option value="">Selecione</option>
        <option value="kg" <%= "kg".equals(produto.getUnidadeMedida()) ? "selected" : "" %>>Kg</option>
        <option value="g" <%= "g".equals(produto.getUnidadeMedida()) ? "selected" : "" %>>g</option>
        <option value="L" <%= "L".equals(produto.getUnidadeMedida()) ? "selected" : "" %>>L</option>
        <option value="ml" <%= "ml".equals(produto.getUnidadeMedida()) ? "selected" : "" %>>ml</option>
        <option value="unidade" <%= "unidade".equals(produto.getUnidadeMedida()) ? "selected" : "" %>>Unidade</option>
        <option value="caixa" <%= "caixa".equals(produto.getUnidadeMedida()) ? "selected" : "" %>>Caixa</option>
    </select>
    <br><br>

    <label for="nome">Nome do Produto:</label>
    <input type="text" id="nome" name="nome" value="<%= produto.getNome() %>" required>
    <br><br>

    <label for="estoqueMinimo">Estoque Mínimo:</label>
    <input type="number" step="1" id="estoqueMinimo" name="estoqueMinimo" value="<%= produto.getEstoqueMinimo() %>" required>
    <br><br>

    <label for="categoria">Categoria:</label>
    <input type="text" id="categoria" name="categoria" value="<%= produto.getCategoria() %>" required>
    <br><br>

    <label for="quantidade">Quantidade:</label>
    <input type="number" step="1" id="quantidade" name="quantidade" value="<%= produto.getQuantidade() %>" required>
    <br><br>

    <button type="submit">Atualizar Produto</button>
</form>
<% } else { %>
<p>Produto não encontrado.</p>
<% } %>

<br><br>
<a href="<%= request.getContextPath() %>/ServletReadProduto">Voltar à lista de produtos</a><br><br>
<a href="<%= request.getContextPath() %>/index.html">Voltar ao início</a>
</body>
</html>