<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="
    com.codcoz.dao.EmpresaDAO,
    com.codcoz.dao.NotaFiscalXmlDAO,
    com.codcoz.model.Empresa,
    com.codcoz.model.NotaFiscalXml,
    java.util.List
" %>
<!DOCTYPE html>
<html>
<head>
    <title>Criar Item da Nota Fiscal</title>
</head>
<body>
<h2>Criar Item da Nota Fiscal</h2>

<form action="<%= request.getContextPath() %>/ServletCreateItemNotaFiscal" method="post">
    <label for="idNotaFiscalXml">Nota Fiscal:</label>
    <%
        List<NotaFiscalXml> notas = new NotaFiscalXmlDAO().read();
    %>
    <select id="idNotaFiscalXml" name="idNotaFiscalXml" required>
        <option value="">Selecione uma nota fiscal</option>
        <% for (NotaFiscalXml nf : notas) { %>
        <option value="<%= nf.getId() %>">
            Nota nº <%= nf.getNumeroNota() %>
        </option>
        <% } %>
    </select>
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

    <label for="quantidade">Quantidade:</label>
    <input type="number" step="0.01" id="quantidade" name="quantidade" required>
    <br><br>

    <label for="preco">Preço Unitário:</label>
    <input type="number" step="0.01" id="preco" name="preco" required>
    <br><br>

    <button type="submit">CRIAR ITEM</button>
</form>

<br><br>
<a href="<%= request.getContextPath() %>/ServletReadItemNotaFiscal">
    Voltar à lista
</a>
<br><br>
<a href="<%= request.getContextPath() %>/index.html">
    Voltar ao início
</a>
</body>
</html>

