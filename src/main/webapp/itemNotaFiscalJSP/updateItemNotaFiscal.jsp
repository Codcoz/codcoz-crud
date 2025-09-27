<%@ page import="com.codcoz.model.ItemNotaFiscal" %>
<%@ page import="com.codcoz.dao.ItemNotaFiscalDAO" %>
<%@ page import="com.codcoz.dao.EmpresaDAO" %>
<%@ page import="com.codcoz.dao.NotaFiscalXmlDAO" %>
<%@ page import="com.codcoz.model.Empresa" %>
<%@ page import="com.codcoz.model.NotaFiscalXml" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Integer id = Integer.parseInt(request.getParameter("id"));
    ItemNotaFiscal item = null;
    List<Empresa> empresas = new EmpresaDAO().read();
    List<NotaFiscalXml> notas = new NotaFiscalXmlDAO().read();

    if (id != null) {
        ItemNotaFiscalDAO dao = new ItemNotaFiscalDAO();
        item = dao.buscarPorId(id);
    }
%>

<html>
<head>
    <title>Atualizar Item da Nota Fiscal</title>
</head>
<body>
<% if (item != null) { %>
<h2>Atualizar Item de ID <%= item.getId() %></h2>

<form action="<%=request.getContextPath()%>/ServletUpdateItemNotaFiscal" method="post">
    <input type="hidden" name="id" value="<%= item.getId() %>"/>

    <label for="idNotaFiscalXml">Nota Fiscal:</label>
    <select id="idNotaFiscalXml" name="idNotaFiscalXml" required>
        <option value="">Selecione uma nota fiscal</option>
        <% for (NotaFiscalXml nf : notas) { %>
        <option value="<%= nf.getId() %>" <%= nf.getId().equals(item.getIdNotaFiscalXml()) ? "selected" : "" %>>
            Nota nº <%= nf.getNumeroNota() %>
        </option>
        <% } %>
    </select><br><br>

    <label for="idEmpresa">Empresa:</label>
    <select id="idEmpresa" name="idEmpresa" required>
        <option value="">Selecione uma empresa</option>
        <% for (Empresa emp : empresas) { %>
        <option value="<%= emp.getId() %>" <%= emp.getId().equals(item.getIdEmpresa()) ? "selected" : "" %>>
            <%= emp.getNome() %> (CNPJ: <%= emp.getCnpj() %>)
        </option>
        <% } %>
    </select><br><br>

    <label for="quantidade">Quantidade:</label>
    <input type="number" step="0.01" name="quantidade" id="quantidade" value="<%= item.getQuantidade() %>" required><br><br>

    <label for="preco">Preço Unitário:</label>
    <input type="number" step="0.01" name="preco" id="preco" value="<%= item.getPreco() %>" required><br><br>

    <button type="submit">Atualizar</button>
</form>
<% } else { %>
<p>Item da nota fiscal não encontrado.</p>
<% } %>

<br><br>
<a href="<%=request.getContextPath()%>/ServletReadItemNotaFiscal">Voltar à lista</a> <br><br>
<a href="<%=request.getContextPath()%>/index.html">Voltar ao início</a>
</body>
</html>
