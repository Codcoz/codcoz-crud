<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="
    com.codcoz.model.Empresa,
    com.codcoz.dao.EnderecoDAO,
    com.codcoz.model.Endereco,
    java.util.List
" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Lista de Empresas</title>
</head>
<body>
<aside>
    <!-- Aside para botões de navegação entre tabelas -->
</aside>

<h2>Lista de Empresas</h2>

<form action="<%= request.getContextPath() %>/empresaJSP/createEmpresa.jsp" method="get">
    <button type="submit">Create</button>
</form>
<br>

<table border="1" cellpadding="8" cellspacing="0">
    <tr>
        <th>ID</th>
        <th>Nome</th>
        <th>CNPJ</th>
        <th>Endereço</th>
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
            (<%= endereco.getCep() %>) <%= endereco.getCidade() %>,
            rua <%= endereco.getRua() %>, nº <%= endereco.getNumero() %> —
            <%= endereco.getEstado() %>
        </td>
        <td>
            <form action="<%= request.getContextPath() %>/empresaJSP/updateEmpresa.jsp" method="get">
                <input type="hidden" name="id" value="<%= empresa.getId() %>"/>
                <button type="submit">Update</button>
            </form>
        </td>
        <td>
            <form action="<%= request.getContextPath() %>/ServletDeleteEmpresa" method="post">
                <input type="hidden" name="id" value="<%= empresa.getId() %>"/>
                <button type="submit">Delete</button>
            </form>
        </td>
    </tr>
    <%
        }
    } else {
    %>
    <tr>
        <td colspan="6">Nenhuma empresa encontrada.</td>
    </tr>
    <%
        }
    %>
</table>

<br>
<a href="<%= request.getContextPath() %>/index.html">Voltar ao início</a>
</body>
</html>
