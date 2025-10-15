<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="
    java.util.List,
    com.codcoz.model.Alerta,
    com.codcoz.model.Empresa,
    com.codcoz.model.Produto,
    com.codcoz.dao.AlertaDAO,
    com.codcoz.dao.EmpresaDAO,
    com.codcoz.dao.ProdutoDAO
" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    Alerta alerta = new AlertaDAO().buscarPorId(id);
%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Atualizar Alerta</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
</head>
<body>
<div class="container">

    <jsp:include page="./../barraLateral.jsp" />

    <main class="content">
        <header class="topo">
            <h2>Atualizar Alerta</h2>
            <img src="<%= request.getContextPath() %>/assets/codcoz_icon.png" alt="Logo" class="logo">
        </header>

        <div class="sub-header">
            <span class="hover-link ativo">Editar Alerta</span>
        </div>

        <% if (alerta != null) { %>
        <div class="actions">
            <form action="<%= request.getContextPath() %>/ServletUpdateAlerta" method="post" style="max-width: 500px;">
                <input type="hidden" name="id" value="<%= id %>"/>
                <input type="hidden" name="idEmpresa" value="<%= request.getParameter("idEmpresa") %>"/>

                <%
                    int idEmpresa = Integer.parseInt(request.getParameter("idEmpresa"));
                    Empresa empresa = new EmpresaDAO().buscarPorId(idEmpresa);
                    List<Produto> produtos = new ProdutoDAO().buscarPorEmpresa(idEmpresa);
                %>

                <label for="idProduto">Produto:</label><br>
                <select id="idProduto" name="idProduto" class="select-redondo" required>
                    <option value="">Selecione um produto</option>
                    <% for (Produto prod : produtos) { %>
                    <option value="<%= prod.getId() %>" <%= prod.getId().equals(alerta.getIdProduto()) ? "selected" : "" %>>
                        <%= prod.getNome() %>, <%= prod.getUnidadeMedida() %>, id: <%= prod.getId() %>
                    </option>
                    <% } %>
                </select>
                <br>
                <a href="../produtoJSP/createProduto.jsp" class="hover-link">Criar Produto</a>
                <br><br>

                <label for="dataCriacao">Data de Criação:</label><br>
                <input type="date" id="dataCriacao" name="dataCriacao" class="input-redondo"
                       value="<%= alerta.getDataCriacao().toString() %>" required><br><br>

                <label for="status">Status:</label><br>
                <select id="status" name="status" class="select-redondo" required>
                    <option value="">Selecione o status</option>
                    <option value="Pendente" <%= "Pendente".equals(alerta.getStatus()) ? "selected" : "" %>>Pendente</option>
                    <option value="Resolvido" <%= "Resolvido".equals(alerta.getStatus()) ? "selected" : "" %>>Resolvido</option>
                    <option value="Ignorado" <%= "Ignorado".equals(alerta.getStatus()) ? "selected" : "" %>>Ignorado</option>
                </select><br><br>

                <label for="tipoAlerta">Tipo de Alerta:</label><br>
                <input type="text" id="tipoAlerta" name="tipoAlerta" class="input-redondo"
                       value="<%= alerta.getTipoAlerta() %>" maxlength="50" required placeholder="Ex: Estoque baixo"><br><br>

                <button type="submit" class="novo">✔</button>
            </form>
        </div>
        <% } else { %>
        <p style="color: red;">Alerta não encontrado.</p>
        <% } %>

        <br>
        <a href="<%= request.getContextPath() %>/ServletReadAlerta" class="hover-link">Voltar à lista</a><br>
        <a href="<%= request.getContextPath() %>/index.JSP" class="hover-link">Voltar ao início</a>
    </main>
</div>
</body>
</html>
