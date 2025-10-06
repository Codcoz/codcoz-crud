<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="
    com.codcoz.model.Endereco,
    java.util.List
" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Lista de Endereços</title>
</head>
<body>
<aside>
    <!-- Aside para botões de navegação entre tabelas -->
</aside>

<h2>Lista de Endereços</h2>

<form action="<%= request.getContextPath() %>/enderecoJSP/createEndereco.jsp" method="get">
    <button type="submit">Create</button>
</form>
<br>
<%
    String mensagem = (String) request.getAttribute("mensagem");
    if (mensagem != null) {
        String cor = mensagem.toLowerCase().contains("sucesso") ? "green" : "red";
%>
<p style="color: <%= cor %>"><%= mensagem %></p>
<%
    }
%>
<table border="1" cellpadding="8" cellspacing="0">
    <tr>
        <th>ID</th>
        <th>Rua</th>
        <th>Complemento</th>
        <th>Cidade</th>
        <th>Estado</th>
        <th>CEP</th>
        <th>Número</th>
        <th>Update</th>
        <th>Delete</th>
    </tr>
    <%
        List<Endereco> lista = (List<Endereco>) request.getAttribute("listaEnderecos");
        if (lista != null && !lista.isEmpty()) {
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
        <td>
            <form action="<%= request.getContextPath() %>/enderecoJSP/updateEndereco.jsp" method="post">
                <input type="hidden" name="id" value="<%= endereco.getId() %>"/>
                <button type="submit">Update</button>
            </form>
        </td>
        <td>
            <form action="<%= request.getContextPath() %>/ServletDeleteEndereco" method="post">
                <input type="hidden" name="id" value="<%= endereco.getId() %>"/>
                <button type="submit">Delete</button>
            </form>
        </td>
    </tr>
    <%
        }
    } else {
    %>
    <tr>
        <td colspan="9">Nenhum endereço encontrado.</td>
    </tr>
    <%
        }
    %>
</table>

<br>
<a href="<%= request.getContextPath() %>/index.html">Voltar ao início</a>
</body>
</html>
