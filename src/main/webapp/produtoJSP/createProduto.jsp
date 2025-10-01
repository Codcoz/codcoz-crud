<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="
    java.util.List,
    com.codcoz.dao.EmpresaDAO,
    com.codcoz.model.Empresa
" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Criar Produto</title>
</head>
<body>
<h2>Criar Produto</h2>

<form action="<%= request.getContextPath() %>/ServletCreateProduto" method="post">
    <label for="nome">Nome:</label>
    <input type="text" id="nome" name="nome" placeholder="Nome do produto" required>
    <br><br>

    <label for="categoria">Categoria:</label>
    <input type="text" id="categoria" name="categoria" placeholder="Categoria" required>
    <br><br>

    <label for="unidadeMedida">Unidade de Medida:</label>
    <select id="unidadeMedida" name="unidadeMedida" required>
        <option value="">Selecione</option>
        <option value="kg">Kg</option>
        <option value="L">L</option>
        <option value="unid">Unidade</option>
    </select>
    <br><br>

    <label for="estoqueMinimo">Estoque Mínimo:</label>
    <input type="number" step="0.01" id="estoqueMinimo" name="estoqueMinimo" placeholder="Quantidade mínima" required>
    <br><br>

    <label for="quantidade">Quantidade:</label>
    <input type="number" id="quantidade" name="quantidade" placeholder="Quantidade atual" required>
    <br><br>

    <label for="idEmpresa">Empresa:</label>
    <%
        List<Empresa> empresas = new EmpresaDAO().read();
    %>
    <select id="idEmpresa" name="idEmpresa" required>
        <option value="">Selecione uma empresa</option>
        <% for (Empresa emp : empresas) { %>
        <option value="<%= emp.getId() %>">
            <%= emp.getNome() %> (CNPJ: <%= emp.getCnpj() %>)
        </option>
        <% } %>
    </select>
    <br><br>

    <button type="submit">Criar</button>
</form>

<br><br>
<a href="<%= request.getContextPath() %>/ServletReadProduto">Voltar à lista</a>
<br><br>
<a href="<%= request.getContextPath() %>/index.html">Voltar ao início</a>
</body>
</html>