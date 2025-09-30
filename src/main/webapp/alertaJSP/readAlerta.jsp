
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="
    java.util.List,
    com.codcoz.model.Alerta,
    com.codcoz.model.Empresa,
    com.codcoz.model.Produto,
    com.codcoz.dao.EmpresaDAO,
    com.codcoz.dao.ProdutoDAO
" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Lista de Alertas</title>
</head>
<body>
<aside>
</aside>

<h2>Lista de Alertas</h2>

<form action="<%= request.getContextPath() %>/alertaJSP/createAlerta.jsp" method="get">
    <button type="submit">Create</button>
</form>
<br>

<table border="1" cellpadding="8" cellspacing="0">
    <tr>
        <th>ID</th>
        <th>Empresa</th>
        <th>Produto</th>
        <th>Data de Criação</th>
        <th>Status</th>
        <th>Tipo de Alerta</th>
        <th>Update</th>
        <th>Delete</th>
    </tr>
    <%
        List<Alerta> lista = (List<Alerta>) request.getAttribute("listaAlertas");
        EmpresaDAO empresaDAO = new EmpresaDAO();
        ProdutoDAO produtoDAO = new ProdutoDAO();

        if (lista != null && !lista.isEmpty()) {
            for (Alerta alerta : lista) {
                Empresa empresa = empresaDAO.buscarPorId(alerta.getIdEmpresa());
                Produto produto = produtoDAO.buscarPorId(alerta.getIdProduto());
    %>
    <tr>
        <td><%= alerta.getId() %></td>
        <td><%= empresa.getNome() %></td>
        <td><%= produto.getNome()%></td>
        <td><%= alerta.getDataCriacao() %></td>
        <td><%= alerta.getStatus() %></td>
        <td><%= alerta.getTipoAlerta() %></td>
        <td>
            <form action="<%= request.getContextPath() %>/alertaJSP/updateAlerta.jsp" method="get">
                <input type="hidden" name="id" value="<%= alerta.getId() %>"/>
                <button type="submit">Update</button>
            </form>
        </td>
        <td>
            <form action="<%= request.getContextPath() %>/ServletDeleteAlerta" method="post">
                <input type="hidden" name="id" value="<%= alerta.getId() %>"/>
                <button type="submit">Delete</button>
            </form>
        </td>
    </tr>
    <%
        }
    } else {
    %>
    <tr>
        <td colspan="8">Nenhum alerta encontrado.</td>
    </tr>
    <%
        }
    %>
</table>

<br>
<a href="<%= request.getContextPath() %>/index.html">Voltar ao início</a>
</body>
</html>