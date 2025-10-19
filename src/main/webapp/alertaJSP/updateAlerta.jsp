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

    <main class="content" style="overflow: auto">
        <header class="topo">
            <h2>Atualizar Alerta</h2>
            <img src="<%= request.getContextPath() %>/assets/codcoz_icon.png" alt="Logo" class="logo" title="Logo Codcoz">
        </header>

        <div class="sub-header">
            <span class="hover-link ativo" title="Edite os dados do alerta selecionado">Editar Alerta</span>
        </div>

        <% if (alerta != null) { %>
        <div class="actions" style="margin-top: 30px;">
            <form action="<%= request.getContextPath() %>/ServletUpdateAlerta" method="post" style="max-width: 500px; width: 100%;">
                <input type="hidden" name="id" value="<%= id %>"/>
                <input type="hidden" name="idEmpresa" value="<%= request.getParameter("idEmpresa") %>"/>

                <%
                    int idEmpresa = Integer.parseInt(request.getParameter("idEmpresa"));
                    Empresa empresa = new EmpresaDAO().buscarPorId(idEmpresa);
                    List<Produto> produtos = new ProdutoDAO().buscarPorEmpresa(idEmpresa);
                %>

                <p><strong>Empresa do Alerta:</strong> <%= empresa.getNome() %></p>

                <label for="idProduto">Produto:</label><br>
                <select id="idProduto" name="idProduto" class="select-redondo" required title="Selecione o produto relacionado ao alerta">
                    <option value="">Selecione um produto</option>
                    <% for (Produto prod : produtos) { %>
                    <option value="<%= prod.getId() %>" <%= prod.getId().equals(alerta.getIdProduto()) ? "selected" : "" %>>
                        <%= prod.getNome() %>, <%= prod.getUnidadeMedida() %>, id: <%= prod.getId() %>
                    </option>
                    <% } %>
                </select>
                <br>
                <a href="../produtoJSP/escolhaEmpresaDoProduto.jsp" class="hover-link" title="Cadastrar novo produto">Criar Produto</a>
                <br><br>

                <label for="dataCriacao">Data de Criação:</label><br>
                <input type="date" id="dataCriacao" name="dataCriacao" class="input-redondo"
                       value="<%= alerta.getDataCriacao().toString() %>" required
                       title="Informe a data de criação do alerta"><br><br>

                <label for="status">Status:</label><br>
                <select id="status" name="status" class="select-redondo" required title="Selecione o status atual do alerta">
                    <option value="">Selecione o status</option>
                    <option value="Pendente" <%= "Pendente".equals(alerta.getStatus()) ? "selected" : "" %>>Pendente</option>
                    <option value="Resolvido" <%= "Resolvido".equals(alerta.getStatus()) ? "selected" : "" %>>Resolvido</option>
                    <option value="Ignorado" <%= "Ignorado".equals(alerta.getStatus()) ? "selected" : "" %>>Ignorado</option>
                </select><br><br>

                <label for="tipoAlerta">Tipo de Alerta:</label><br>
                <input type="text" id="tipoAlerta" name="tipoAlerta" class="input-redondo"
                       value="<%= alerta.getTipoAlerta() %>" maxlength="50" required
                       placeholder="Ex: Estoque baixo"
                       title="Informe o tipo de alerta (ex: Estoque baixo)"><br><br>

                <button type="submit" class="novo" title="Salvar alterações">+</button>
            </form>
        </div>
        <% } else { %>
        <p style="color: red;" title="Erro ao carregar alerta">Alerta não encontrado.</p>
        <% } %>

        <br>
        <div style="display: flex; gap: 20px;">
            <a href="<%= request.getContextPath() %>/ServletReadAlerta" class="hover-link" title="Ver lista de alertas">Voltar à lista</a>
            <a href="<%= request.getContextPath() %>/index.jsp" class="hover-link" title="Voltar à página inicial">Voltar ao início</a>
        </div>

    </main>
</div>
</body>
</html>
