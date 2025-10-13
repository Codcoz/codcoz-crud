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
    <title>Editar Empresa do Produto</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
</head>
<body>
<h2>Editar Empresa do Produto:</h2>

<%
    int idSelecionado = Integer.parseInt(request.getParameter("id"));
%>

<form action="<%= request.getContextPath() %>/produtoJSP/updateProduto.jsp" method="post">
    <input type="hidden" name="id" value="<%= request.getParameter("id") %>"/>

    <label for="idEmpresa">Empresa:</label>
    <select name="idEmpresa" id="idEmpresa" required>
        <option value="">Selecione...</option>
        <%
            List<Empresa> empresas = new EmpresaDAO().read();
            for (Empresa emp : empresas) {
        %>
        <option value="<%= emp.getId() %>" <%= emp.getId() == idSelecionado ? "selected" : "" %>>
            <%= emp.getNome() %>
        </option>
        <%
            }
        %>
    </select><br>
    <a href="../empresaJSP/createEmpresa.jsp">Criar Empresa</a>
    <br><br>

    <button type="submit">Confirmar</button>
</form>

<br><br>
<a href="<%= request.getContextPath() %>/ServletReadProduto">Voltar à lista de produtos</a><br><br>
<a href="<%= request.getContextPath() %>/index.html">Voltar ao início</a>
</body>
</html>