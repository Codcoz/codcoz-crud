<%@ page import="com.codcoz.dao.EmpresaDAO" %>
<%@ page import="com.codcoz.model.Empresa" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Criar Nota Fiscal XML</title>
</head>
<body>
<h2>Criar Nota Fiscal XML</h2>

<form action="<%=request.getContextPath()%>/ServletCreateNotaFiscalXml" method="post">
    <label for="idEmpresa">Empresa:</label>
    <%
        List<Empresa> empresas = new EmpresaDAO().read();
    %>
    <select id="idEmpresa" name="idEmpresa" required>
        <option value="">Selecione uma empresa</option>
        <% for (Empresa emp : empresas) { %>
        <option value="<%=emp.getId()%>"><%=emp.getNome()%> (CNPJ: <%=emp.getCnpj()%>)</option>
        <% } %>
    </select><br><br>

    <label for="dataEmissao">Data de Emissão:</label>
    <input type="date" id="dataEmissao" name="dataEmissao" required><br><br>

    <label for="numeroNota">Número da Nota:</label>
    <input type="text" id="numeroNota" name="numeroNota" required placeholder="Ex: 123456"><br><br>

    <label for="xmlString">Conteúdo XML:</label><br>
    <textarea id="xmlString" name="xmlString" rows="10" cols="60" required placeholder="Cole o XML aqui..."></textarea><br><br>

    <button type="submit">CRIAR NOTA</button>
</form>

<br><br>
<a href="<%=request.getContextPath()%>/ServletReadNotaFiscalXml">Voltar à lista</a> <br><br>
<a href="<%=request.getContextPath()%>/index.html">Voltar ao início</a>
</body>
</html>

