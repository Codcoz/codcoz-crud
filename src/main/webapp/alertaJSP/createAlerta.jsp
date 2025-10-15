<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="
    java.util.List,
    com.codcoz.dao.EmpresaDAO,
    com.codcoz.dao.ProdutoDAO,
    com.codcoz.model.Empresa,
    com.codcoz.model.Produto
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
    <aside class="sidebar">
        <jsp:include page="./../barraLateral.jsp" />
    </aside>

    <main class="content">
        <header class="topo">
            <h2>Criar Alerta</h2>
            <img src="<%= request.getContextPath() %>/assets/codcoz_icon.png" alt="Logo" class="logo">
        </header>

        <div class="sub-header">
            <span class="hover-link ativo">Novo Alerta</span>
        </div>

        <%
            int idEmpresa = Integer.parseInt(request.getParameter("idEmpresa"));
            Empresa empresa = new EmpresaDAO().buscarPorId(idEmpresa);
            List<Produto> produtos = new ProdutoDAO().buscarPorEmpresa(idEmpresa);
        %>

        <div class="actions">
            <form action="<%= request.getContextPath() %>/ServletCreateAlerta" method="post" style="max-width: 500px;">
                <input type="hidden" value="<%= idEmpresa %>" name="idEmpresa">
                <p><strong>Empresa do Alerta:</strong> <%= empresa.getNome() %></p>

                <label for="idProduto">Produto:</label><br>
                <select id="idProduto" name="idProduto" class="select-redondo" required>
                    <option value="">Selecione um produto</option>
                    <% for (Produto p : produtos) { %>
                    <option value="<%= p.getId() %>"><%= p.getNome() %>, <%= p.getUnidadeMedida() %>, id: <%= p.getId() %></option>
                    <% } %>
                </select>
                <br>
                <a href="../produtoJSP/escolhaEmpresaDoProduto.jsp" class="hover-link">Criar Produto</a>
                <br><br>

                <label for="dataCriacao">Data de Criação:</label><br>
                <input type="date" id="dataCriacao" name="dataCriacao" class="input-redondo" required><br><br>

                <label for="status">Status:</label><br>
                <select id="status" name="status" class="select-redondo" required>
                    <option value="">Selecione o status</option>
                    <option value="Pendente">Pendente</option>
                    <option value="Resolvido">Resolvido</option>
                    <option value="Ignorado">Ignorado</option>
                </select><br><br>

                <label for="tipoAlerta">Tipo de Alerta:</label><br>
                <input type="text" id="tipoAlerta" name="tipoAlerta" class="input-redondo"
                       maxlength="50" placeholder="Ex: Estoque baixo" required><br><br>

                <button type="submit" class="novo">+</button>
            </form>
        </div>

        <br>
        <a href="<%= request.getContextPath() %>/ServletReadAlerta" class="hover-link">Voltar à lista</a><br>
        <a href="<%= request.getContextPath() %>/index.JSP" class="hover-link">Voltar ao início</a>
    </main>
</div>
</body>
</html>
