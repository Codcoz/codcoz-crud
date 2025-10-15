<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="
    com.codcoz.dao.NotaFiscalXmlDAO,
    com.codcoz.dao.EmpresaDAO,
    com.codcoz.model.NotaFiscalXml,
    com.codcoz.model.Empresa,
    java.util.List
" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Atualizar Nota Fiscal XML</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
</head>
<body>
<%
    // Obtém o ID da nota a partir do parâmetro e carrega dados
    Integer id = null;
        id = Integer.parseInt(request.getParameter("id"));

    NotaFiscalXml nota = null;
    List<Empresa> empresas = new EmpresaDAO().read();

    if (id != null) {
        nota = new NotaFiscalXmlDAO().buscarPorId(id);
    }
%>

<% if (nota != null) { %>
<h2>Atualizar Nota Fiscal nº <%= nota.getNumeroNota() %></h2>

<form action="<%= request.getContextPath() %>/ServletUpdateNotaFiscalXml" method="post">
    <input type="hidden" name="id" value="<%= nota.getId() %>"/>

    <label for="idEmpresa">Empresa:</label>
    <select id="idEmpresa" name="idEmpresa" required>
        <option value="">Selecione uma empresa</option>
        <% for (Empresa emp : empresas) { %>
        <option value="<%= emp.getId() %>"
                <%= emp.getId().equals(nota.getIdEmpresa()) ? "selected" : "" %>>
            <%= emp.getNome() %> (CNPJ: <%= emp.getCnpj() %>)
        </option>
        <% } %>
    </select><br>
    <a href="../empresaJSP/createEmpresa.jsp">Criar Empresa</a>
    <br><br>

    <label for="dataEmissao">Data de Emissão:</label>
    <input type="date" id="dataEmissao" name="dataEmissao"
           value="<%= nota.getDataEmissao() %>" required>
    <br><br>

    <label for="numeroNota">Número da Nota:</label>
    <input type="text" id="numeroNota" name="numeroNota"
           value="<%= nota.getNumeroNota() %>" required>
    <br><br>

    <label for="xmlString">Conteúdo XML:</label>
    <br>
    <textarea id="xmlString" name="xmlString" required>
        <%= nota.getXmlString() %>
    </textarea>
    <br><br>

    <button type="submit">Atualizar Nota</button>
</form>
<% } else { %>
<p>Nota Fiscal não encontrada ou ID inválido.</p>
<% } %>

<br><br>
<a href="<%= request.getContextPath() %>/ServletReadNotaFiscalXml">Voltar à lista</a>
<br><br>
<a href="<%= request.getContextPath() %>/index.html">Voltar ao início</a>
</body>
</html>
