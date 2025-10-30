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
    // Recupera o alerta pelo ID recebido como parâmetro
    int id = Integer.parseInt(request.getParameter("id"));
    Alerta alerta = new AlertaDAO().buscarPorId(id);
%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Atualizar Alerta</title>
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
            <h2>Atualizar Alerta</h2>
            <img src="<%= request.getContextPath() %>/assets/codcoz_icon.png" alt="Logo" class="logo" title="Logo Codcoz">
        </header>

        <div class="sub-header">
            <span class="hover-link ativo" title="Edite os dados do alerta selecionado">Editar Alerta</span>
        </div>

        <% if (alerta != null) { %>
        <div class="actions" style="margin-top: 30px;">
            <!-- Formulário para atualizar alerta -->
            <form action="<%= request.getContextPath() %>/ServletUpdateAlerta" method="post" style="max-width: 500px; width: 100%;">
                <input type="hidden" name="id" value="<%= id %>"/>
                <input type="hidden" name="idEmpresa" value="<%= request.getParameter("idEmpresa") %>"/>

                <%
                    // Recupera empresa e produtos vinculados para preencher o formulário
                    int idEmpresa = Integer.parseInt(request.getParameter("idEmpresa"));
                    Empresa empresa = new EmpresaDAO().buscarPorId(idEmpresa);
                    List<Produto> produtos = new ProdutoDAO().buscarPorEmpresa(idEmpresa);
                %>

                <p><strong>Empresa do Alerta:</strong> <%= empresa.getNome() %></p>

                <!-- Campo de seleção de produto -->
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
                <a href="ServletReadProduto?view=create" class="hover-link" title="Cadastrar novo produto">Criar Produto</a>
                <br><br>

                <!-- Campo de data de criação -->
                <label for="dataCriacao">Data de Criação:</label><br>
                <input type="date" id="dataCriacao" name="dataCriacao" class="input-redondo"
                       value="<%= alerta.getDataCriacao().toString() %>" required
                       title="Informe a data de criação do alerta"><br><br>

                <!-- Campo de status -->
                <label for="status">Status:</label><br>
                <select id="status" name="status" class="select-redondo" required title="Selecione o status atual do alerta">
                    <option value="">Selecione o status</option>
                    <option value="Pendente" <%= "Pendente".equals(alerta.getStatus()) ? "selected" : "" %>>Pendente</option>
                    <option value="Resolvido" <%= "Resolvido".equals(alerta.getStatus()) ? "selected" : "" %>>Resolvido</option>
                    <option value="Ignorado" <%= "Ignorado".equals(alerta.getStatus()) ? "selected" : "" %>>Ignorado</option>
                </select><br><br>

                <!-- Campo de tipo de alerta -->
                <label for="tipoAlerta">Tipo de Alerta:</label><br>
                <input type="text" id="tipoAlerta" name="tipoAlerta" class="input-redondo"
                       value="<%= alerta.getTipoAlerta() %>" maxlength="50" required
                       placeholder="Ex: Estoque baixo"
                       title="Informe o tipo de alerta (ex: Estoque baixo)"><br><br>

                <!-- Botão para salvar alterações -->
                <button type="submit" class="novo" title="Salvar alterações">+</button>
            </form>
        </div>
        <% } else { %>
        <!-- Mensagem de erro caso o alerta não seja encontrado -->
        <p style="color: red;" title="Erro ao carregar alerta">Alerta não encontrado.</p>
        <% } %>

        <br>
        <!-- Navegação -->
        <div style="display: flex; gap: 20px;">
            <a href="<%= request.getContextPath() %>/ServletReadAlerta" class="hover-link" title="Ver lista de alertas">Voltar à lista</a>
            <a href="<%= request.getContextPath() %>/login.jsp" class="hover-link" title="Voltar à página inicial">Voltar ao início</a>
        </div>

    </main>
</div>
</body>
</html>
