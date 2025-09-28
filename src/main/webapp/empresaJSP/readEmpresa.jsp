<%@ page import="com.codcoz.model.Empresa" %>
<%@ page import="com.codcoz.dao.EnderecoDAO" %>
<%@ page import="com.codcoz.model.Endereco" %>
<%@ page import="java.util.List" %>
<<<<<<< HEAD
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
=======
>>>>>>> b0f8cb5cc2905eeb18a7e0ceb7a15fb342d0a0af

<aside>
    aside para por todos os botoes das outras tabelas
</aside>

<form action="empresaJSP/createEmpresa.jsp" method="post">
    <button type="submit">Create</button>
</form>

<table border="1">
    <tr>
        <th>ID</th>
        <th>Nome</th>
        <th>CNPJ</th>
        <th>Endereco</th>
        <th>Update</th>
        <th>Delete</th>
    </tr>

    <%
        List<Empresa> lista = (List<Empresa>) request.getAttribute("listaEmpresas");
        EnderecoDAO enderecoDAO = new EnderecoDAO();

        if (lista != null && !lista.isEmpty()) {
            for (Empresa empresa : lista) {
                Endereco endereco = enderecoDAO.buscarPorId(empresa.getIdEndereco());
    %>
    <tr>
        <td><%= empresa.getId() %></td>
        <td><%= empresa.getNome() %></td>
        <td><%= empresa.getCnpj() %></td>
        <td>
            (<%= endereco.getCep() %>) <%= endereco.getCidade() %>, rua
            <%= endereco.getRua() %>, <%= endereco.getNumero() %> -
            <%= endereco.getEstado() %>
        </td>

        <!-- Botão de Update -->
        <td>
            <form action="empresaJSP/updateEmpresa.jsp" method="get">
                <input type="hidden" name="id" value="<%= empresa.getId() %>"/>
                <button type="submit">Update</button>
            </form>
        </td>

        <!-- Botão de Delete -->
        <td>
            <form action="ServletDeleteEmpresa" method="post">
                <input type="hidden" name="id" value="<%= empresa.getId() %>"/>
                <input type="submit" value="Delete" />
            </form>
        </td>
    </tr>
    <%
        }
    } else {
    %>
    <tr><td colspan="6">Nenhuma empresa encontrada.</td></tr>
    <%
        }
    %>
</table>

<br>
<a href="<%=request.getContextPath()%>/index.html">Voltar ao inicio</a>