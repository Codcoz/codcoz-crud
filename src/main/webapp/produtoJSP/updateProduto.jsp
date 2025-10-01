<%@ page import="com.codcoz.model.Produto" %>
<%@ page import="com.codcoz.dao.ProdutoDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Integer id = Integer.parseInt(request.getParameter("id"));
    Produto produto = null;

    if (id != null) {
        ProdutoDAO produtoDAO = new ProdutoDAO();
        produto = produtoDAO.buscarPorId(id);
    }
%>

<html>
<head>
    <title>Atualizar Endereço</title>
</head>
<body>
<h2>Atualizar Produto de ID <%= produto.getId() %></h2>
<% if (produto != null) { %>
<form action="/ServletUpdateProduto" method="post">
    <input type="hidden" name="id" value="<%= produto.getId() %>"/>

    <label for="id_empresa">Id Empresa:</label>
    <input type="number" id="id_empresa" name="id_empresa" value="<%= produto.getIdEmpresa() %>" required placeholder="Ex:1,2,3"><br><br>

    <label for="id_ItemNotaFiscal">Id item nota fiscal:</label>
    <input type="number" id="id_ItemNotaFiscal" name="id_ItemNotaFiscal" value="<%= produto.getIdItemNotaFiscal() %>" placeholder="Ex:1,2,3"><br><br>

    <label for="unidade_de_medida">unidade de medida:</label>
    <input type="text" id="unidade_de_medida" name="unidade_de_medida" value="<%= produto.getUnidadeMedida() %>" placeholder="Ex:Kg,L,caixa"><br><br>

    <label for="nome">nome:</label>
    <input type="text" id="nome" name="nome" value="<%= produto.getNome() %>" required placeholder="Ex:Arroz"><br><br>

    <label for="estoque_Minimo">estoque_Minimo:</label>
    <input type="number" id="estoque_Minimo" name="estoque_Minimo" value="<%= produto.getEstoqueMinimo() %>" required placeholder="Ex:1,2,3"><br><br>

    <label for="categoria">categoria:</label>
    <input type="text" id="categoria" name="categoria" value="<%= produto.getCategoria() %>" required placeholder="Ex:Frios"><br><br>

    <label for="status">status:</label>
    <input type="text" id="status" name="status" value="<%= produto.getStatus() %>" required placeholder="Ex:Ativo"><br><br>

    <button type="submit">Update</button>

</form>
<% } else { %>
<p>Produto não encontrado.</p>
<% } %>

<a href="/ServletReadProduto">Voltar à lista</a>
</body>
</html>