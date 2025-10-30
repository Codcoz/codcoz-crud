<%@ page import="com.codcoz.dao.EmpresaDAO, com.codcoz.model.Empresa, java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Criar Estoque</title>
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
            <h2>Criar Estoque</h2>
            <img src="<%= request.getContextPath() %>/assets/codcoz_icon.png" alt="Logo" class="logo" title="Logo Codcoz">
        </header>

        <div class="sub-header">
            <span class="hover-link ativo" title="Preencha os dados para cadastrar um novo estoque">Novo Estoque</span>
        </div>

        <div class="actions" style="margin-top: 30px;">
            <!-- Formulário para criação de estoque -->
            <form action="<%= request.getContextPath() %>/ServletCreateEstoque" method="post" style="max-width: 500px; width: 100%;">
                <!-- Campo Tipo de Estoque -->
                <label for="tipoEstoque">Tipo de Estoque:</label><br>
                <input type="text" id="tipoEstoque" name="tipoEstoque" class="input-redondo"
                       maxlength="30" required placeholder="Ex: Refrigerado"
                       title="Informe o tipo de estoque"><br><br>

                <!-- Campo Capacidade -->
                <label for="capacidade">Capacidade (Kg/L):</label><br>
                <input type="number" id="capacidade" step="1" name="capacidade" class="input-redondo"
                       required placeholder="Ex: 1000"
                       title="Informe a capacidade total do estoque"><br><br>

                <!-- Campo Empresa -->
                <label for="idEmpresa">Empresa:</label><br>
                <%
                    // Carrega lista de empresas para o select
                    List<Empresa> empresas = new EmpresaDAO().read();
                %>
                <select id="idEmpresa" name="idEmpresa" class="select-redondo" required title="Selecione a empresa associada ao estoque">
                    <option value="">Selecione uma empresa</option>
                    <% for (Empresa emp : empresas) { %>
                    <option value="<%= emp.getId() %>"><%= emp.getNome() %></option>
                    <% } %>
                </select>
                <br>
                <!-- Link para cadastrar nova empresa -->
                <a href="ServletReadEmpresa?view=create" class="hover-link" title="Cadastrar nova empresa">Criar Empresa</a>
                <br><br>

                <!-- Botão de envio -->
                <button type="submit" class="novo" title="Salvar novo estoque">+</button>
            </form>
        </div>

        <br>
        <!-- Navegação -->
        <div style="display: flex; gap: 20px;">
            <a href="<%= request.getContextPath() %>/ServletReadEstoque" class="hover-link" title="Ver lista de estoques">Voltar à lista</a>
            <a href="<%= request.getContextPath() %>/login.jsp" class="hover-link" title="Voltar à página inicial">Voltar ao início</a>
        </div>

    </main>
</div>
</body>
</html>
