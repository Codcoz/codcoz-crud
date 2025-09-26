<%--
  Created by IntelliJ IDEA.
  User: guilhermebrandao-ieg
  Date: 26/09/2025
  Time: 13:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.codcoz.model.NotaFiscalXml" %>
<%@ page import="com.codcoz.dao.NotaFiscalXmlDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Integer id = Integer.parseInt(request.getParameter("id"));
    NotaFiscalXml nota = null;

    if (id != null) {
        NotaFiscalXmlDAO dao = new NotaFiscalXmlDAO();
        nota = dao.buscarPorId(id);
    }
%>

<html>
<head>
    <title>Atualizar Nota Fiscal</title>
</head>
<body>
<h2>Atualizar Nota Fiscal ID <%= nota != null ? nota.getId() : "" %></h2>

<% if (nota != null) { %>
<form action="ServletUpdateNotaFiscalXml" method="post">
    <input type="hidden" name="id" value="<%= nota.getId() %>"/>

    <label for="idEmpresa">ID Empresa:</label>
    <input type="number" id="idEmpresa" name="idEmpresa" value="<%= nota.getIdEmpresa() %>" required><br><br>

    <label for="dataEmissao">Data Emissão:</label>
    <input type="text" id="dataEmissao" name="dataEmissao" value="<%= nota.getDataEmissao() %>" required><br><br>

    <label for="xmlString">XML String:</label>
    <input type="text" id="xmlString" name="xmlString" value="<%= nota.getXmlString() %>" required><br><br>

    <label for="numeroNota">Número Nota:</label>
    <input type="text" id="numeroNota" name="numeroNota" value="<%= nota.getNumeroNota() %>" required><br><br>

    <button type="submit">Update</button>
</form>
<% } else { %>
<p>Nota Fiscal não encontrada.</p>
<% } %>

<a href="ServletReadNotaFiscalXml">Voltar à lista</a>
</body>
</html>
