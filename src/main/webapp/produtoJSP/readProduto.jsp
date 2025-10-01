<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="
    com.codcoz.model.Produto,
    com.codcoz.dao.EmpresaDAO,
    com.codcoz.model.Empresa,
    java.util.List
" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Lista de Produtos</title>
</head>
<body>
<aside>
    <!-- Aside para botões de navegação entre tabelas -->
</aside>

<h2>Lista de Produtos</h2>

<form action="<%= request.getContextPath() %>/produtoJSP/createProduto.jsp" method="get">
    <button type="submit">Create</button>
</form>
<br>

<table border="1" cellpadding="8" cellspacing="0">
    <tr>
        <th>ID</th>
        <th>Nome</th>
        <th>Categoria</th>
        <th>Unidade</th>
        <th>Estoque Mínimo</th>
        <th>Quantidade</th>
        <th>Empresa</th>
        <th>Update</th>
        <th>Delete</th>
    </tr>
    <%
        List<Produto> lista = (List<Produto>) request.getAttribute("listaProdutos");
        EmpresaDAO empresaDAO = new EmpresaDAO();

        if (lista != null && !lista.isEmpty()) {
            for (Produto produto : lista) {
                Empresa empresa = empresaDAO.buscarPorId(produto.getIdEmpresa());
    %>
    <tr>
        <td><%= produto.getId() %></td>
        <td><%= produto.getNome() %></td>
        <td><%= produto.getCategoria() %></td>
        <td><%= produto.getUnidadeMedida() %></td>
        <td><%= produto.getEstoqueMinimo() %></td>
        <td><%= produto.getQuantidade() %></td>
        <td><%= empresa != null ? empresa.getNome() : "Empresa não encontrada" %></td>
        <td>
            <form action="<%= request.getContextPath() %>/produtoJSP/updateProduto.jsp" method="get">
                <input type="hidden" name="id" value="<%= produto.getId() %>"/>
                <button type="submit">Update</button>
            </form>
        </td>
        <td>
            <form action="<%= request.getContextPath() %>/ServletDeleteProduto" method="post">
                <input type="hidden" name="id" value="<%= produto.getId() %>"/>
                <button type="submit">Delete</button>
            </form>
        </td>
    </tr>
    <%
        }
    } else {
    %>
    <tr>
        <td colspan="9">Nenhum produto encontrado.</td>
    </tr>
    <%
        }
    %>
</table>

<br>
<a href="<%= request.getContextPath() %>/index.html">Voltar ao início</a>
</body>
</html>