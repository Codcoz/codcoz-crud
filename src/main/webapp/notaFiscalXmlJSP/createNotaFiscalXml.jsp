<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="
    com.codcoz.dao.EmpresaDAO,
    com.codcoz.model.Empresa,
    java.util.List
" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Criar Nota Fiscal XML</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
</head>
<body>
<h2>Criar Nota Fiscal XML</h2>

<form action="<%= request.getContextPath() %>/ServletCreateNotaFiscalXml" method="post">
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
    <a href="../empresaJSP/createEmpresa.jsp">Criar Empresa</a>
    <br><br>

    <label for="dataEmissao">Data de Emissão:</label>
    <input type="date" id="dataEmissao" name="dataEmissao" required>
    <br><br>

    <label for="numeroNota">Número da Nota:</label>
    <input type="text" id="numeroNota" name="numeroNota"
           placeholder="Ex: 123456" required>
    <br><br>

    <label for="xmlString">Conteúdo XML:</label>
    <br>
    <textarea id="xmlString" name="xmlString" placeholder="Cole o XML aqui..." required></textarea>
    <br><br>

    <button type="submit">CRIAR NOTA</button>
</form>

<br><br>
<a href="<%= request.getContextPath() %>/ServletReadNotaFiscalXml">
    Voltar à lista
</a>
<br><br>
<a href="<%= request.getContextPath() %>/index.html">
    Voltar ao início
</a>
</body>
</html>

