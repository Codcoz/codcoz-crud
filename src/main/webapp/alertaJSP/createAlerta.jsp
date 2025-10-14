<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="
    java.util.List,
    com.codcoz.dao.EmpresaDAO,
    com.codcoz.dao.ProdutoDAO,
    com.codcoz.model.Empresa,
    com.codcoz.model.Produto
" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Criar Alerta</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
</head>
<body>

<h2>Criar Alerta</h2>
<form action="<%= request.getContextPath() %>/ServletCreateAlerta" method="post">
    <% int idEmpresa = Integer.parseInt(request.getParameter("idEmpresa"));
        Empresa empresa = new EmpresaDAO().buscarPorId(idEmpresa);%>
    <input type="hidden" value="<%=idEmpresa%>" name="idEmpresa">
    <p>Empresa do Alerta: <%=empresa.getNome()%></p>
    <label for="idProduto">Produto:</label>
    <select id="idProduto" name="idProduto" required>
        <option value="">Selecione um produto</option>
        <%
            List<Produto> produtos = new ProdutoDAO().buscarPorEmpresa(idEmpresa);
            for (Produto p : produtos) {
        %>
        <option value="<%= p.getId() %>"><%= p.getNome() + ", " + p.getUnidadeMedida() + ", id: " + p.getId()%></option>
        <% } %>
    </select>
    <a href="../produtoJSP/escolhaEmpresaDoProduto.jsp">Criar Produto</a>
    <br><br>

    <label for="dataCriacao">Data de Criação:</label>
    <input type="date" id="dataCriacao" name="dataCriacao"  required>
    <br><br>

    <label for="status">Status:</label>
    <select id="status" name="status" required>
        <option value="">Selecione o status</option>
        <option value="Pendente">Pendente</option>
        <option value="Resolvido">Resolvido</option>
        <option value="Ignorado">Ignorado</option>
    </select>
    <br><br>

    <label for="tipoAlerta">Tipo de Alerta:</label>
    <input type="text" id="tipoAlerta" name="tipoAlerta" maxlength="50" placeholder="Ex: Estoque baixo" required>
    <br><br>

    <button type="submit">Criar</button>
</form>

<br><br>
<a href="<%= request.getContextPath() %>/ServletReadAlerta">Voltar à lista</a>
<br><br>
<a href="<%= request.getContextPath() %>/index.html">Voltar ao início</a>
</body>
</html>