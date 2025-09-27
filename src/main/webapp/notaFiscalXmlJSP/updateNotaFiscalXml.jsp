<%@ page import="com.codcoz.model.NotaFiscalXml" %>
<%@ page import="com.codcoz.dao.NotaFiscalXmlDAO" %>
<%@ page import="com.codcoz.dao.EmpresaDAO" %>
<%@ page import="com.codcoz.model.Empresa" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Integer id = Integer.parseInt(request.getParameter("id"));
    NotaFiscalXml nota = null;
    List<Empresa> empresas = new EmpresaDAO().read();

    if (id != null) {
        NotaFiscalXmlDAO dao = new NotaFiscalXmlDAO();
        nota = dao.buscarPorId(id);
    }
%>

<html>
<head>
    <title>Atualizar Nota Fiscal XML</title>
</head>
<body>
<% if (nota != null) { %>
<h2>Atualizar Nota Fiscal nº <%= nota.getNumeroNota() %></h2>

<form action="<%=request.getContextPath()%>/ServletUpdateNotaFiscalXml" method="post">
    <input type="hidden" name="id" value="<%= nota.getId() %>"/>

    <label for="idEmpresa">Empresa:</label>
    <select id="idEmpresa" name="idEmpresa" required>
        <option value="">Selecione uma empresa</option>
        <% for (Empresa emp : empresas) { %>
        <option value="<%= emp.getId() %>" <%= emp.getId().equals(nota.getIdEmpresa()) ? "selected" : "" %>>
            <%= emp.getNome() %> (CNPJ: <%= emp.getCnpj() %>)
        </option>
        <% } %>
    </select><br><br>

    <label for="dataEmissao">Data de Emissão:</label>
    <input type="date" id="dataEmissao" name="dataEmissao" value="<%= nota.getDataEmissao() %>" required><br><br>

    <label for="numeroNota">Número da Nota:</label>
    <input type="text" id="numeroNota" name="numeroNota" value="<%= nota.getNumeroNota() %>" required><br><br>

    <label for="xmlString">Conteúdo XML:</label><br>
    <textarea id="xmlString" name="xmlString" rows="10" cols="60" required><%= nota.getXmlString() %></textarea><br><br>

    <button type="submit">Atualizar Nota</button>
</form>
<% } else { %>
<p>Nota Fiscal não encontrada.</p>
<% } %>

<br><br>
<a href="<%=request.getContextPath()%>/ServletReadNotaFiscalXml">Voltar à lista</a> <br><br>
<a href="<%=request.getContextPath()%>/index.html">Voltar ao início</a>
</body>
</html>

