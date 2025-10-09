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
    <title>Criar Produto</title>
</head>
<body>
<h2>Empresa do Produto</h2>

<form action="<%= request.getContextPath() %>/produtoJSP/createProduto.jsp" method="post">
    <label for="idEmpresa">Empresa: </label>
    <select name="idEmpresa" id="idEmpresa">
        <%
            List<Empresa> empresas = new EmpresaDAO().read();
            for (Empresa empresa : empresas){
        %>
        <option value="<%= empresa.getId() %>"><%= empresa.getNome() %></option>
        <%
            }
        %>
    </select>
    <br><br>
    <button type="submit">Confirmar</button>
</form>
</body>
</html>