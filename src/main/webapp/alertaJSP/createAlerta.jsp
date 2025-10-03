
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
</head>
<body>
<h2>Criar Alerta</h2>

<form action="<%= request.getContextPath() %>/ServletCreateAlerta" method="post">
    <label for="idEmpresa">Empresa:</label>
    <%
        List<Empresa> empresas = new EmpresaDAO().read();
    %>
    <select id="idEmpresa" name="idEmpresa" required>
        <option value="">Selecione uma empresa</option>
        <% for (Empresa emp : empresas) { %>
        <option value="<%= emp.getId() %>"><%= emp.getNome() %> (CNPJ: <%= emp.getCnpj() %>)</option>
        <% } %>
    </select>
    <a href="../empresaJSP/createEmpresa.jsp">Criar Empresa</a>
    <br><br>

    <label for="idProduto">Produto:</label>
    <%
        List<Produto> produtos = new ProdutoDAO().read();
    %>
    <select id="idProduto" name="idProduto" required>
        <option value="">Selecione um produto</option>
        <% for (Produto prod : produtos) { %>
        <option value="<%= prod.getId() %>"><%= prod.getNome() %> - <%= prod.getCategoria() %></option>
        <% } %>
    </select>
    <a href="../produtoJSP/createProduto.jsp">Criar Produto</a>
    <br><br>

    <label for="dataCriacao">Data de Criação:</label>
    <input type="date" id="dataCriacao" name="dataCriacao" required>
    <br><br>

    <label for="status">Status:</label>
    <select id="status" name="status" required>
        <option value="">Selecione o status</option>
        <option value="ativo">Ativo</option>
        <option value="inativo">Inativo</option>
    </select>
    <br><br>

    <label for="tipoAlerta">Tipo de Alerta:</label>
    <input type="text" id="tipoAlerta" name="tipoAlerta" placeholder="Tipo de alerta" required>
    <br><br>

    <button type="submit">Criar</button>
</form>

<br><br>
<a href="<%= request.getContextPath() %>/ServletReadAlerta">Voltar à lista</a>
<br><br>
<a href="<%= request.getContextPath() %>/index.html">Voltar ao início</a>
</body>
</html>
