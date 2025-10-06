<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="
    java.util.List,
    com.codcoz.dao.EmpresaDAO,
    com.codcoz.dao.EstoqueDAO,
    com.codcoz.dao.NotaFiscalXmlDAO,
    com.codcoz.model.Empresa,
    com.codcoz.model.Estoque,
    com.codcoz.model.NotaFiscalXml
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
        <option value="g">g</option>
        <option value="kg">Kg</option>
        <option value="ml">ml</option>
        <option value="L">L</option>
        <option value="caixa">Caixa</option>
        <option value="unidade">Unidade</option>
    </select>
    <br><br>

    <label for="estoqueMinimo">Estoque Mínimo:</label>
    <input type="number" step="0.01" id="estoqueMinimo" name="estoqueMinimo" placeholder="Quantidade mínima" required>
    <br><br>

    <label for="quantidade">Quantidade:</label>
    <input type="number" id="quantidade" name="quantidade" placeholder="Quantidade atual" required>
    <br><br>

    <label for="idEstoque">Estoque:</label>
    <%
        List<Estoque> estoques = new EstoqueDAO().read();
        EmpresaDAO empresaDAO = new EmpresaDAO();
    %>
    <select id="idEstoque" name="idEstoque" required>
        <option value="">Selecione um estoque</option>
        <% for (Estoque est : estoques) {
            Empresa empresa = empresaDAO.buscarPorId(est.getIdEmpresa());
        %>
        <option value="<%= est.getId() %>">
            <%= est.getTipoEstoque() %> (Empresa: <%= empresa != null ? empresa.getNome() : "Desconhecida" %>)
        </option>
        <% } %>
    </select>
    <a href="../estoqueJSP/createEstoque.jsp">Criar Estoque</a>
    <br><br>

    <label for="idNotaFiscal">Nota Fiscal:</label>
    <%
        List<NotaFiscalXml> notas = new NotaFiscalXmlDAO().read();
    %>
    <select id="idNotaFiscal" name="idNotaFiscal" required>
        <option value="">Selecione uma nota fiscal</option>
        <% for (NotaFiscalXml nota : notas) {
            Empresa empresa = empresaDAO.buscarPorId(nota.getIdEmpresa());
        %>
        <option value="<%= nota.getId() %>">
            Nº <%= nota.getNumeroNota() %> - Empresa: <%= empresa != null ? empresa.getNome() : "Desconhecida" %>
        </option>
        <% } %>
    </select>
    <a href="../notaFiscalJSP/createNotaFiscal.jsp">Criar Nota Fiscal</a>
    <br><br>

    <button type="submit">Criar</button>
</form>

<br><br>
<a href="<%= request.getContextPath() %>/ServletReadProduto">Voltar à lista</a>
<br><br>
<a href="<%= request.getContextPath() %>/index.html">Voltar ao início</a>
</body>
</html>