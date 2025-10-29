<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="
    java.util.List,
    com.codcoz.model.Alerta,
    com.codcoz.model.Empresa,
    com.codcoz.model.Produto,
    com.codcoz.dao.EmpresaDAO,
    com.codcoz.dao.ProdutoDAO
" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Lista de Alertas</title>
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
            <h2>Lista de Alertas</h2>
            <img src="<%= request.getContextPath() %>/assets/codcoz_icon.png" alt="Logo" class="logo">
        </header>

        <div class="sub-header">
            <span class="hover-link ativo">Alertas</span>
        </div>

        <div class="actions">
            <!-- Botão para criar novo alerta -->
            <form action="<%= request.getContextPath() %>/ServletReadAlerta" method="get">
                <button type="submit" class="novo" title="Cadastrar novo alerta">+</button>
                <input  type="hidden" name="view" value="escolhaEmpresaCreate">
            </form>
            <!-- Filtro por empresa -->
            <form style="display: flex" action="ServletReadAlerta" class="filtro">
                <label for="buscarPorEmpresa">Filtro: </label>
                <select class="select-redondo" name="buscarPorEmpresa" id="buscarPorEmpresa">
                    <option selected disabled value=""><%=request.getAttribute("filtro")!=null ? request.getAttribute("filtro"):"Selecione uma empresa"%></option>
                    <%List<Empresa> empresas = new EmpresaDAO().read();
                        for (Empresa empresa: empresas) {%>
                    <option value="<%=empresa.getId()%>"><%=empresa.getNome()%></option>
                    <%}%>
                </select>
                <button type="submit">Filtrar</button>
            </form>
        </div>

        <!-- Exibe mensagem de retorno, com cor baseada no conteúdo -->
        <% String mensagem = (String) request.getAttribute("mensagem");
            if (mensagem != null) {
                String cor = mensagem.toLowerCase().contains("sucesso") ? "green" : "red"; %>
        <p style="color: <%= cor %>"><%= mensagem %></p>
        <% } %>

        <div class="tabela-container">
            <table>
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Empresa</th>
                    <th>Produto</th>
                    <th>Data de Criação</th>
                    <th>Status</th>
                    <th>Tipo de Alerta</th>
                    <th>Editar</th>
                    <th>Deletar</th>
                </tr>
                </thead>
                <tbody>
                <%
                    // Recupera a lista de alertas e os dados relacionados
                    List<Alerta> lista = (List<Alerta>) request.getAttribute("listaAlertas");
                    ProdutoDAO produtoDAO = new ProdutoDAO();
                    EmpresaDAO empresaDAO = new EmpresaDAO();

                    if (lista != null && !lista.isEmpty()) {
                        for (Alerta alerta : lista) {
                            Produto produto = produtoDAO.buscarPorId(alerta.getIdProduto());
                            Empresa empresa = produto != null ? empresaDAO.buscarPorId(produto.getIdEmpresa()) : null;
                %>
                <tr>
                    <td><%= alerta.getId() %></td>
                    <td><%= empresa != null ? empresa.getNome() : "Empresa não encontrada" %></td>
                    <td><%= produto != null ? produto.getNome() : "Produto não encontrado" %></td>
                    <td><%= alerta.getDataCriacao() %></td>
                    <td style="color: <%= alerta.getStatus().equalsIgnoreCase("pendente") ? "red" : "green" %>;">
                        <%= alerta.getStatus() %>
                    </td>
                    <td><%= alerta.getTipoAlerta() %></td>
                    <!-- Link para editar alerta -->
                    <td class="acoes">
                        <a href="<%= request.getContextPath() %>/ServletReadAlerta?view=escolhaEmpresaUpdate&id=<%= alerta.getId() %>">
                            <img src="<%= request.getContextPath() %>/assets/edit_icon.png" alt="Editar">
                        </a>
                    </td>
                    <!-- Link para deletar alerta com confirmação -->
                    <td class="acoes">
                        <a href="<%= request.getContextPath() %>/ServletDeleteAlerta?id=<%= alerta.getId() %>"
                           onclick="return confirm('Tem certeza que deseja excluir este alerta?');">
                            <img src="<%= request.getContextPath() %>/assets/delete_icon.png" alt="Excluir">
                        </a>
                    </td>
                </tr>
                <%     }
                } else { %>
                <!-- Caso não haja alertas -->
                <tr>
                    <td colspan="8">Nenhum alerta encontrado.</td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>

        <br>
        <!-- Link para voltar à página inicial -->
        <a href="<%= request.getContextPath() %>/index.jsp" class="hover-link">Voltar ao início</a>
    </main>
</div>
</body>
</html>
