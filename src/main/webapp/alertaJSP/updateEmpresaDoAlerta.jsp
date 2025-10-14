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
    <title>Editar Alerta</title>
</head>
<body>
<h2>Editar alerta da empresa:</h2>
<form action="<%= request.getContextPath() %>/alertaJSP/updateAlerta.jsp" method="post">
    <input  type="hidden" value="<%=request.getParameter("id")%>" name="id">
    <label for="idEmpresa">Empresa: </label>
    <select id="nigga" name="idEmpresa" id="idEmpresa" required>
        <option value="">Selecione...</option>
        <%
            List<Empresa> empresas = new EmpresaDAO().read();
            for (Empresa emp : empresas) {
                System.out.println(emp.getId());
        %>
        <option <%=emp.getId()==Integer.parseInt(request.getParameter("id"))?"selected":""%> value="<%= emp.getId() %>"><%= emp.getNome() %></option>
        <%
            }
        %>
    </select><br>
    <a href="../empresaJSP/createEmpresa.jsp">Criar Empresa</a>
    <br><br>
    <button type="submit">Confirmar</button>
</form>
</body>
</html>