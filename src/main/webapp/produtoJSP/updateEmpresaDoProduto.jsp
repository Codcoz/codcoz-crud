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
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
</head>
<body>
<div class="container">
    <jsp:include page="./../barraLateral.jsp" />

    <main class="content">
        <header class="topo">
            <h2>Editar Empresa do Produto</h2>
            <img src="<%= request.getContextPath() %>/assets/codcoz_icon.png" alt="Logo" class="logo">
        </header>

        <div class="sub-header">
            <span class="hover-link ativo">Selecionar Empresa</span>
        </div>

        <div class="actions">
            <%
                int idSelecionado = Integer.parseInt(request.getParameter("id"));
            %>
            <form action="<%= request.getContextPath() %>/produtoJSP/updateProduto.jsp" method="post" style="max-width: 500px;">
                <input type="hidden" name="id" value="<%= request.getParameter("id") %>"/>

                <label for="idEmpresa">Empresa:</label><br>
                <select name="idEmpresa" id="idEmpresa" class="select-redondo" required>
                    <option value="">Selecione...</option>
                    <%
                        List<Empresa> empresas = new EmpresaDAO().read();
                        for (Empresa emp : empresas) {
                    %>
                    <option value="<%= emp.getId() %>" <%= emp.getId() == idSelecionado ? "selected" : "" %>>
                        <%= emp.getNome() %>
                    </option>
                    <% } %>
                </select>
                <br>
                <a href="../empresaJSP/createEmpresa.jsp" class="hover-link">Criar Empresa</a>
                <br><br>

                <button type="submit" class="novo">✔</button>
            </form>
        </div>

        <br>
        <a href="<%= request.getContextPath() %>/ServletReadProduto" class="hover-link">Voltar à lista de produtos</a><br>
        <a href="<%= request.getContextPath() %>/index.JSP" class="hover-link">Voltar ao início</a>
    </main>
</div>
</body>
</html>
