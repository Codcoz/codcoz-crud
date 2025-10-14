<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="java.util.List, com.codcoz.dao.EmpresaDAO, com.codcoz.dao.AlertaDAO, com.codcoz.model.Empresa, com.codcoz.model.Alerta" %>
<%
    System.out.println("id1:" + request.getParameter("id"));
    int idAlerta = Integer.parseInt(request.getParameter("id"));
    Alerta alerta = new AlertaDAO().buscarPorId(idAlerta);
%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Editar Empresa do alerta</title>
</head>
<body>
<h2>Editar Empresa do alerta:</h2>
<form action="<%= request.getContextPath() %>/alertaJSP/updateAlerta.jsp" method="post">
    <input type="hidden" value="<%=idAlerta%>" name="id">
    <label for="idEmpresa">Empresa: </label>
    <select name="idEmpresa" id="idEmpresa" required>
        <option value="">Selecione...</option>
        <%
            List<Empresa> empresas = new EmpresaDAO().read();
            for (Empresa emp : empresas) {
        %>
        <option value="<%= emp.getId() %>" <%= emp.getId() == alerta.getIdEmpresa() ? "selected" : "" %>>
            <%= emp.getNome() %>
        </option>
        <% } %>
    </select>
    <br><br>
    <button type="submit">Confirmar</button>
</form>
</body>
</html>