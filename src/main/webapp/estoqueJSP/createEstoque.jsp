<%@ page import="com.codcoz.dao.EmpresaDAO, com.codcoz.model.Empresa, java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Criar Estoque</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
</head>
<body>
<div class="container">
    <aside class="sidebar">
        <jsp:include page="./../barraLateral.jsp" />
    </aside>

    <main class="content">
        <header class="topo">
            <h2>Criar Estoque</h2>
            <img src="<%= request.getContextPath() %>/assets/codcoz_icon.png" alt="Logo" class="logo">
        </header>

        <div class="sub-header">
            <span class="hover-link ativo">Novo Estoque</span>
        </div>

        <div class="actions">
            <form action="<%= request.getContextPath() %>/ServletCreateEstoque" method="post" style="max-width: 500px;">
                <label for="tipoEstoque">Tipo de Estoque:</label><br>
                <input type="text" id="tipoEstoque" name="tipoEstoque" class="input-redondo" maxlength="30" required placeholder="Ex: Refrigerado"><br><br>

                <label for="capacidade">Capacidade (Kg/L):</label><br>
                <input type="number" id="capacidade" step="1" name="capacidade" class="input-redondo" required placeholder="Ex: 1000"><br><br>

                <label for="idEmpresa">Empresa:</label><br>
                <%
                    List<Empresa> empresas = new EmpresaDAO().read();
                %>
                <select id="idEmpresa" name="idEmpresa" class="select-redondo" required>
                    <option value="">Selecione uma empresa</option>
                    <% for (Empresa emp : empresas) { %>
                    <option value="<%= emp.getId() %>"><%= emp.getNome() %></option>
                    <% } %>
                </select>
                <br>
                <a href="../empresaJSP/createEmpresa.jsp" class="hover-link">Criar Empresa</a>
                <br><br>

                <button type="submit" class="novo">+</button>
            </form>
        </div>

        <br>
        <a href="<%= request.getContextPath() %>/ServletReadEstoque" class="hover-link">Voltar à lista</a><br>
        <a href="<%= request.getContextPath() %>/index.JSP" class="hover-link">Voltar ao início</a>
    </main>
</div>
</body>
</html>
