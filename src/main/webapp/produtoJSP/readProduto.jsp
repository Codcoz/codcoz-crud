<%@ page import="com.codcoz.model.Produto" %>
<%@ page import="java.util.List" %>
<form action="produtoJSP/createProduto.jsp" method="post">
    <button type="submit">Create</button>
</form>
<table border="1">

    <tr>
        <th>ID</th>
        <th>id empresa</th>
        <th>id nota fiscal</th>
        <th>id Unidade Medida</th>
        <th>nome</th>
        <th>estoque Minimo</th>
        <th>categoria</th>
        <th>status</th>
        <th>Update</th>
        <th>Delete</th>
    </tr>

    <%
        List<Produto> lista = (List<Produto>) request.getAttribute("listaProdutos");
        if (lista != null && lista.size()>0) {
            for (Produto produto : lista) {
    %>

    <tr>
        <td><%= produto.getId() %></td>
        <td><%= produto.getIdEmpresa() %></td>
        <td><%= produto.getIdItemNotaFiscal() %></td>
        <td><%= produto.getIdUnidadeMedida() %></td>
        <td><%= produto.getNome() %></td>
        <td><%= produto.getEstoqueMinimo() %></td>
        <td><%= produto.getCategoria() %></td>
        <td><%= produto.getStatus() %></td>


        <!-- Botão de Update -->
        <td>
            <form action="updateProduto.jsp" method="get">
                <input type="hidden" name="id" value="<%= produto.getId() %>"/>
                <button type="submit">Update</button>
            </form>
        </td>

        <!-- Botão de Delete -->
        <td>
            <form action="ServletDeleteProduto" method="post">
                <input type="hidden" name="id" value="<%= produto.getId() %>"/>
                <input type="submit" value="Delete" />
            </form>
        </td>
    </tr>
    <%
        }
    } else {
    %>
    <tr><td colspan="10">Nenhum produto encontrado.</td></tr>
    <%
        }
    %>
</table>
