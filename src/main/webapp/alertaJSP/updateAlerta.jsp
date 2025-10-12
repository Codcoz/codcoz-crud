<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="
    java.util.List,
    com.codcoz.model.Alerta,
    com.codcoz.model.Empresa,
    com.codcoz.model.Produto,
    com.codcoz.dao.AlertaDAO,
    com.codcoz.dao.EmpresaDAO,
    com.codcoz.dao.ProdutoDAO
" %>
<%
    Integer id = Integer.parseInt(request.getParameter("id"));
    Alerta alerta = new AlertaDAO().buscarPorId(id);
%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Atualizar Alerta</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
</head>
<body>

<% if (alerta != null) { %>
<h2>Atualizar Alerta de ID <%= alerta.getId() %></h2>

<form action="<%= request.getContextPath() %>/ServletUpdateAlerta" method="post">
    <input type="hidden" name="id" value="<%= alerta.getId() %>"/>


    <%
        int idEmpresa = Integer.parseInt(request.getParameter("idEmpresa"));
        Empresa empresa = new EmpresaDAO().buscarPorId(idEmpresa);
        List<Produto> produtos = new ProdutoDAO().buscarPorEmpresa(idEmpresa);
    %>

    <label for="idProduto">Produto:</label>
    <select id="idProduto" name="idProduto" required>
        <option value="">Selecione um produto</option>
        <% for (Produto prod : produtos) { %>
        <option value="<%= prod.getId() %>" <%= prod.getId().equals(alerta.getIdProduto()) ? "selected" : "" %>>
            <%= prod.getNome() %>
        </option>
        <% } %>
    </select>
    <a href="../produtoJSP/createProduto.jsp">Criar Produto</a>
    <br><br>

    <label for="dataCriacao">Data de Criação:</label>
    <input type="date" id="dataCriacao" name="dataCriacao"
           value="<%= alerta.getDataCriacao().toString() %>" required><br><br>

    <label for="status">Status:</label>
    <select id="status" name="status" required>
        <option value="">Selecione o status</option>
        <option value="Pendente" <%= "Pendente".equals(alerta.getStatus()) ? "selected" : "" %>>Pendente</option>
        <option value="Resolvido" <%= "Resolvido".equals(alerta.getStatus()) ? "selected" : "" %>>Resolvido</option>
        <option value="Ignorado" <%= "Ignorado".equals(alerta.getStatus()) ? "selected" : "" %>>Ignorado</option>
    </select><br><br>

    <label for="tipoAlerta">Tipo de Alerta:</label>
    <input type="text" id="tipoAlerta" name="tipoAlerta"
           value="<%= alerta.getTipoAlerta() %>" maxlength="50" required placeholder="Ex: Estoque baixo"><br><br>

    <button type="submit">Atualizar</button>
</form>
<% } else { %>
<p>Alerta não encontrado.</p>
<% } %>

<br><br>
<a href="<%= request.getContextPath() %>/ServletReadAlerta">Voltar à lista</a><br><br>
<a href="<%= request.getContextPath() %>/index.html">Voltar ao início</a>
</body>
</html>