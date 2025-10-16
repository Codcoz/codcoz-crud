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
    <title>Criar Alerta</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
</head>
<body>
<div class="container">
        <jsp:include page="./../barraLateral.jsp" />

    <main class="content">
        <header class="topo">
            <h2>Empresa do Alerta</h2>
            <img src="<%= request.getContextPath() %>/assets/codcoz_icon.png" alt="Logo" class="logo">
        </header>

        <div class="sub-header">
            <span class="hover-link ativo">Selecionar Empresa</span>
        </div>

        <div class="actions">
            <form action="<%= request.getContextPath() %>/alertaJSP/createAlerta.jsp" method="post" style="max-width: 500px;">
                <label for="idEmpresa">Empresa:</label><br>
                <select name="idEmpresa" id="idEmpresa" class="select-redondo" required>
                    <option value="">Selecione...</option>
                    <%
                        List<Empresa> empresas = new EmpresaDAO().read();
                        for (Empresa empresa : empresas){
                    %>
                    <option value="<%= empresa.getId() %>"><%= empresa.getNome() %></option>
                    <% } %>
                </select>
                <br>
                <a href="../empresaJSP/createEmpresa.jsp" class="hover-link">Criar Empresa</a>
                <br><br>

                <button type="submit" class="novo">✔</button>
            </form>
        </div>

        <br>
        <a href="<%= request.getContextPath() %>/ServletReadAlerta" class="hover-link">Voltar à lista</a><br>
        <a href="<%= request.getContextPath() %>/index.jsp" class="hover-link">Voltar ao início</a>
    </main>
</div>
</body>
</html>
