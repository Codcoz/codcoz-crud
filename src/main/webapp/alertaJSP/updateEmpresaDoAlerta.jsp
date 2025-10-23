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
    <title>Editar Empresa do Alerta</title>
    <!-- Estilos e fontes -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/icone.png">
</head>
<body>
<div class="container">
    <!-- Inclui a barra lateral -->
    <jsp:include page="./../barraLateral.jsp" />

    <main class="content" style="overflow: auto">
        <header class="topo">
            <h2>Editar Empresa do Alerta</h2>
            <img src="<%= request.getContextPath() %>/assets/codcoz_icon.png" alt="Logo" class="logo" title="Logo Codcoz">
        </header>

        <div class="sub-header">
            <span class="hover-link ativo" title="Selecione a empresa associada ao alerta">Selecionar Empresa</span>
        </div>

        <div class="actions" style="margin-top: 30px;">
            <!-- Formulário para selecionar nova empresa associada ao alerta -->
            <form action="<%= request.getContextPath() %>/alertaJSP/updateAlerta.jsp" method="post" style="max-width: 500px; width: 100%;">
                <input type="hidden" name="id" value="<%= request.getParameter("id") %>"/>

                <!-- Campo de seleção de empresa -->
                <label for="idEmpresa">Empresa:</label><br>
                <select name="idEmpresa" id="idEmpresa" class="select-redondo" required title="Selecione a empresa para editar o alerta">
                    <option value="">Selecione...</option>
                    <%
                        // Carrega lista de empresas e marca a empresa selecionada, se houver
                        List<Empresa> empresas = new EmpresaDAO().read();
                        int idSelecionado = Integer.parseInt(request.getParameter("idEmpresa") != null ? request.getParameter("idEmpresa") : "0");
                        for (Empresa emp : empresas) {
                    %>
                    <option value="<%= emp.getId() %>" <%= emp.getId() == idSelecionado ? "selected" : "" %>>
                        <%= emp.getNome() %>
                    </option>
                    <% } %>
                </select>
                <br>
                <!-- Link para cadastrar nova empresa -->
                <a href="../empresaJSP/createEmpresa.jsp" class="hover-link" title="Cadastrar nova empresa">Criar Empresa</a>
                <br><br>

                <!-- Botão para enviar alterações -->
                <button type="submit" class="novo" title="Salvar alterações">+</button>
            </form>
        </div>

        <br>
        <!-- Navegação -->
        <div style="display: flex; gap: 20px;">
            <a href="<%= request.getContextPath() %>/ServletReadAlerta" class="hover-link" title="Ver lista de alertas">Voltar à lista</a>
            <a href="<%= request.getContextPath() %>/index.jsp" class="hover-link" title="Voltar à página inicial">Voltar ao início</a>
        </div>

    </main>
</div>
</body>
</html>
