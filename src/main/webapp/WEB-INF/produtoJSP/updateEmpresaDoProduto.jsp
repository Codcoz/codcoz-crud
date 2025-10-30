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
    <!-- Estilos e fontes -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/icone.png">
</head>
<body>
<div class="container">
    <!-- Inclui a barra lateral -->
    <jsp:include page="../barraLateral.jsp" />

    <main class="content" style="overflow: auto">
        <header class="topo">
            <h2>Editar Empresa do Produto</h2>
            <img src="<%= request.getContextPath() %>/assets/codcoz_icon.png" alt="Logo" class="logo" title="Logo Codcoz">
        </header>

        <div class="sub-header">
            <span class="hover-link ativo" title="Selecione a empresa associada ao produto">Selecionar Empresa</span>
        </div>

        <div class="actions" style="margin-top: 30px;">
            <%
                // Recupera o ID do produto para edição
                int idSelecionado = Integer.parseInt(request.getParameter("id"));
            %>
            <!-- Formulário para atualizar empresa associada ao produto -->
            <form action="<%= request.getContextPath() %>/ServletReadProduto" method="get" style="max-width: 500px; width: 100%;">
                <input type="hidden" name="view" value="update">
                <input type="hidden" name="id" value="<%= request.getParameter("id") %>"/>

                <!-- Campo Empresa -->
                <label for="idEmpresa">Empresa:</label><br>
                <select name="idEmpresa" id="idEmpresa" class="select-redondo" required title="Selecione a empresa para editar o produto">
                    <option value="">Selecione...</option>
                    <%
                        // Carrega lista de empresas e marca a selecionada
                        List<Empresa> empresas = new EmpresaDAO().read();
                        for (Empresa emp : empresas) {
                    %>
                    <option value="<%= emp.getId() %>" <%= emp.getId() == idSelecionado ? "selected" : "" %>>
                        <%= emp.getNome() %>
                    </option>
                    <% } %>
                </select>
                <br>
                <!-- Link para cadastrar nova empresa -->
                <a href="ServletReadEmpresa?view=create" class="hover-link" title="Cadastrar nova empresa">Criar Empresa</a>
                <br><br>

                <!-- Botão para salvar alterações -->
                <button type="submit" class="novo" title="Salvar alterações">+</button>
            </form>
        </div>

        <br>
        <!-- Navegação -->
        <div style="display: flex; gap: 20px;">
            <a href="<%= request.getContextPath() %>/ServletReadProduto" class="hover-link" title="Ver lista de produtos">Voltar à lista de produtos</a>
            <a href="<%= request.getContextPath() %>/login.jsp" class="hover-link" title="Voltar à página inicial">Voltar ao início</a>
        </div>

    </main>
</div>
</body>
</html>
