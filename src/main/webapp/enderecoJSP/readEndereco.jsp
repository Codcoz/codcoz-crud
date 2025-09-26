<%@ page import="com.codcoz.model.Endereco" %>
<%@ page import="java.util.List" %>
<aside>
    aside para por todos os botoes das outras tabelas
</aside>
<form action="enderecoJSP/createEndereco.jsp" method="post">
    <button type="submit">Create</button>
</form>
<table border="1">

    <tr>
        <th>ID</th>
        <th>Rua</th>
        <th>Complemento</th>
        <th>Cidade</th>
        <th>Estado</th>
        <th>CEP</th>
        <th>Numero</th>
        <th>Update</th>
        <th>Delete</th>
    </tr>

    <%
        List<Endereco> lista = (List<Endereco>) request.getAttribute("listaEnderecos");
        if (lista != null && lista.size()>0) {
            for (Endereco endereco : lista) {
    %>

    <tr>
        <td><%= endereco.getId() %></td>
        <td><%= endereco.getRua() %></td>
        <td><%= endereco.getComplemento() %></td>
        <td><%= endereco.getCidade() %></td>
        <td><%= endereco.getEstado() %></td>
        <td><%= endereco.getCep() %></td>
        <td><%= endereco.getNumero() %></td>

        <!-- Botão de Update -->
        <td>
            <form action="enderecoJSP/updateEndereco.jsp" method="get">
                <input type="hidden" name="id" value="<%= endereco.getId() %>"/>
                <button type="submit">Update</button>
            </form>
        </td>
        <!-- Botão de Delete -->
        <td>
            <form action="ServletDeleteEndereco" method="post">
                <input type="hidden" name="id" value="<%= endereco.getId() %>"/>
                <input type="submit" value="Delete" />
            </form>
        </td>
    </tr>
    <%
        }
    } else {
    %>
    <tr><td colspan="9">Nenhum endereco encontrado.</td></tr>
    <%
        }
    %>
</table>
<br>
<a href="<%=request.getContextPath()%>/index.html">Voltar ao inicio</a>