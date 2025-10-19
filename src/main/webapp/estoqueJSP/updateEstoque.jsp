<%@ page import="com.codcoz.model.Estoque" %>
<%@ page import="com.codcoz.dao.EstoqueDAO" %>
<%@ page import="com.codcoz.dao.EmpresaDAO" %>
<%@ page import="com.codcoz.model.Empresa" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Integer id = Integer.parseInt(request.getParameter("id"));
    Estoque estoque = null;
    List<Empresa> empresas = new EmpresaDAO().read();

    if (id != null) {
        EstoqueDAO dao = new EstoqueDAO();
        estoque = dao.buscarPorId(id);
    }
%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Atualizar Estoque</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
</head>
<body>
<div class="container">
    <jsp:include page="./../barraLateral.jsp" />

    <main class="content" style="overflow: auto">
        <header class="topo">
            <h2>Atualizar Estoque</h2>
            <img src="<%= request.getContextPath() %>/assets/codcoz_icon.png" alt="Logo" class="logo" title="Logo Codcoz">
        </header>

        <div class="sub-header">
            <span class="hover-link ativo" title="Edite os dados do estoque selecionado">Editar Estoque</span>
        </div>

        <% if (estoque != null) { %>
        <div class="actions" style="margin-top: 30px;">
            <form action="<%= request.getContextPath() %>/ServletUpdateEstoque" method="post" style="max-width: 500px; width: 100%;">
                <input type="hidden" name="id" value="<%= estoque.getId() %>"/>

                <label for="tipoEstoque">Tipo de Estoque:</label><br>
                <input type="text" id="tipoEstoque" name="tipoEstoque" class="input-redondo"
                       value="<%= estoque.getTipoEstoque() %>" maxlength="30" required
                       placeholder="Ex: Seco, Refrigerado" title="Informe o tipo de estoque"><br><br>

                <label for="capacidade">Capacidade (Kg/L):</label><br>
                <input type="number" id="capacidade" name="capacidade" class="input-redondo"
                       value="<%= estoque.getCapacidade() %>" required
                       placeholder="Ex: 1000" title="Informe a capacidade total do estoque"><br><br>

                <label for="idEmpresa">Empresa:</label><br>
                <select id="idEmpresa" name="idEmpresa" class="select-redondo" required title="Selecione a empresa associada ao estoque">
                    <option value="">Selecione uma empresa</option>
                    <% for (Empresa emp : empresas) { %>
                    <option value="<%= emp.getId() %>" <%= emp.getId().equals(estoque.getIdEmpresa()) ? "selected" : "" %>>
                        <%= emp.getNome() %>
                    </option>
                    <% } %>
                </select>
                <br>
                <a href="../empresaJSP/createEmpresa.jsp" class="hover-link" title="Cadastrar nova empresa">Criar Empresa</a>
                <br><br>

                <button type="submit" class="novo" title="Salvar alterações">+</button>
            </form>
        </div>
        <% } else { %>
        <p style="color: red;" title="Erro ao carregar estoque">Estoque não encontrado.</p>
        <% } %>

        <br>
        <div style="display: flex; gap: 20px;">
            <a href="<%= request.getContextPath() %>/ServletReadEstoque" class="hover-link" title="Ver lista de estoques">Voltar à lista</a>
            <a href="<%= request.getContextPath() %>/index.jsp" class="hover-link" title="Voltar à página inicial">Voltar ao início</a>

        </div>
    </main>
</div>
</body>
</html>
