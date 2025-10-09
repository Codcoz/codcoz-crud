
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="
    java.util.List,
    com.codcoz.dao.EmpresaDAO,
    com.codcoz.model.Empresa
" %>
<%@ page import="com.codcoz.model.NotaFiscalXml" %>
<%@ page import="com.codcoz.dao.NotaFiscalXmlDAO" %>
<%@ page import="com.codcoz.model.Estoque" %>
<%@ page import="com.codcoz.dao.EstoqueDAO" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Criar Produto</title>
</head>
<body>
<h2>Criar Produto</h2>

<form action="<%= request.getContextPath() %>/ServletCreateProduto" method="post">
    <% int idEmpresa = Integer.parseInt(request.getParameter("idEmpresa"));
        Empresa empresa = new EmpresaDAO().buscarPorId(idEmpresa);%>
    <input type="hidden" value="<%=idEmpresa%>" name="idEmpresa">
    <p>Empresa do Alerta: <%=empresa.getNome()%></p>
    <label for="idEstoque">Estoque:</label>
    <select id="idEstoque" name="idEstoque" required>
        <option value="">Selecione um estoque</option>
        <%
            List<Estoque> estoques = new EstoqueDAO().buscarPorEmpresa(idEmpresa);
            for (Estoque e : estoques) {
        %>
        <option value="<%= e.getId() %>"><%= e.getTipoEstoque() %></option>
        <% } %>
    </select>
    <a href="../estoqueJSP/createEstoque.jsp">Criar Estoque</a>
    <br><br>

    <label for="idNotaFiscal">Nota fiscal:</label>
    <select id="idNotaFiscal" name="idNotaFiscal" required>
        <option value="">Selecione um estoque</option>
        <%
            List<NotaFiscalXml> notaFiscalXmls = new NotaFiscalXmlDAO().read();
            for (NotaFiscalXml n : notaFiscalXmls) {
        %>
        <option value="<%= n.getId() %>"><%= n.getNumeroNota() %></option>
        <% } %>
    </select>
    <a href="../notaFiscalXmlJSP/createNotaFiscalXml.jsp">Criar nota fiscal</a>
    <br><br>

    <label for="unidadeMedida">Unidade de medida:</label>
    <select id="unidadeMedida" name="unidadeMedida" required>
        <option value="">Selecione uma Unidade de Medida</option>
        <option value="kg">Kg</option>
        <option value="g">g</option>
        <option value="L">L</option>
        <option value="ml">ml</option>
        <option value="unidade">Unidade</option>
        <option value="caixa">Caixa</option>
    </select>
    <br><br>

    <label for="nome">Nome do Produto:</label>
    <input type="text" id="nome" name="nome" placeholder="Ex:Carne"required>
    <br><br>

    <label for="estoqueMinimo">Estoque Mínimo:</label>
    <input type="number" step="1" id="estoqueMinimo" name="estoqueMinimo" placeholder="Ex:1"required>
    <br><br>

    <label for="categoria">Categoria:</label>
    <input type="text" id="categoria" name="categoria" placeholder="Ex:Frios"required>
    <br><br>

    <label for="quantidade">Quantidade:</label>
    <input type="number" step="1" id="quantidade" name="quantidade" placeholder="Ex:1"required>
    <br><br>

    <button type="submit">Criar Produto</button>
</form>

<br><br>
<a href="<%= request.getContextPath() %>/ServletReadProduto">Voltar à lista de produtos</a>
<br><br>
<a href="<%= request.getContextPath() %>/index.html">Voltar ao início</a>
</body>
</html>