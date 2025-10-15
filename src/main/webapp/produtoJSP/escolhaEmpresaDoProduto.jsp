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
    <title>Empresa do Produto</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
</head>
<body>
<div class="container">

    <main class="content">
        <header class="topo">
            <h2>Empresa do Produto</h2>
            <img src="<%= request.getContextPath() %>/assets/codcoz_icon.png" alt="Logo" class="logo">
        </header>

        <form action="<%= request.getContextPath() %>/produtoJSP/createProduto.jsp" method="post">
            <label for="idEmpresa">Empresa:</label>
            <select name="idEmpresa" id="idEmpresa" required>
                <option value="">Selecione...</option>
                <%
                    List<Empresa> empresas = new EmpresaDAO().read();
                    for (Empresa empresa : empresas){
                %>
                <option value="<%= empresa.getId() %>"><%= empresa.getNome() %></option>
                <%
                    }
                %>
            </select><br>
            <a href="../empresaJSP/createEmpresa.jsp">Criar Empresa</a>
            <br><br>

            <button type="submit">Confirmar</button>
        </form>

        <br>
        <a href="<%= request.getContextPath() %>/ServletReadProduto" class="hover-link">Voltar à lista de produtos</a><br><br>
        <a href="<%= request.getContextPath() %>/index.jsp" class="hover-link">Voltar ao início</a>
    </main>
</div>
</body>
</html>