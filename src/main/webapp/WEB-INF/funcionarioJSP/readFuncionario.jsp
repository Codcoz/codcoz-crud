<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="
    com.codcoz.model.Funcionario,
    com.codcoz.model.Empresa,
    com.codcoz.dao.EmpresaDAO,
    java.util.List
" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Lista de Funcionários</title>
    <!-- Estilos e fontes -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/icone.png">
</head>
<body>
<div class="container">

    <!-- Inclui a barra lateral -->
    <jsp:include page="../barraLateral.jsp" />

    <main class="content">
        <header class="topo">
            <h2>Lista de Funcionários</h2>
            <img src="<%= request.getContextPath() %>/assets/codcoz_icon.png" alt="Logo" class="logo" title="Logo Codcoz">
        </header>

        <div class="sub-header">
            <span class="hover-link ativo" title="Visualizando todos os funcionários cadastrados">Funcionários</span>
        </div>

        <div class="actions">
            <!-- Botão para cadastrar novo funcionário -->
            <form action="<%= request.getContextPath() %>/ServletReadFuncionario" method="get">
                <button type="submit" class="novo" title="Cadastrar novo funcionário">+</button>
                <input type="hidden" name="view" value="create">
            </form>
            <!-- Filtro por empresa -->
            <form style="display: flex" action="ServletReadFuncionario" class="filtro">
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

        <!-- Exibe mensagem de retorno, se houver -->
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
                    <th>Nome</th>
                    <th>Sobrenome</th>
                    <th>CPF</th>
                    <th>E-mail</th>
                    <th>Empresa</th>
                    <th>Função</th>
                    <th>Status</th>
                    <th>Update</th>
                    <th>Delete</th>
                </tr>
                </thead>
                <tbody>
                <%
                    // Recupera lista de funcionários e exibe na tabela
                    List<Funcionario> lista = (List<Funcionario>) request.getAttribute("listaFuncionarios");
                    EmpresaDAO empresaDAO = new EmpresaDAO();

                    if (lista != null && !lista.isEmpty()) {
                        for (Funcionario funcionario : lista) {
                            Empresa empresa = null;
                            try {
                                empresa = empresaDAO.buscarPorId(funcionario.getIdEmpresa());
                            } catch (Exception ignore) { }
                            String nomeEmpresa = (empresa != null && empresa.getNome() != null) ? empresa.getNome() : "—";
                %>
                <tr>
                    <td title="ID do funcionário"><%= funcionario.getId() %></td>
                    <td title="Nome do funcionário"><%= funcionario.getNome() %></td>
                    <td title="Sobrenome do funcionário"><%= funcionario.getSobrenome() %></td>
                    <td title="CPF do funcionário"><%= funcionario.getCpf() %></td>
                    <td title="E-mail do funcionário"><%= funcionario.getEmail() %></td>
                    <td title="Empresa associada"><%= nomeEmpresa %></td>
                    <td title="Função desempenhada"><%= funcionario.getFuncao() %></td>
                    <td title="Status do funcionário" style="color: <%=funcionario.getStatus().equals("Ativo")?"green":"red"%>"><%= funcionario.getStatus() %></td>
                    <!-- Link para editar funcionário -->
                    <td class="acoes">
                        <a href="<%= request.getContextPath() %>/ServletReadFuncionario?view=update&id=<%= funcionario.getId() %>" title="Editar funcionário">
                            <img src="<%= request.getContextPath() %>/assets/edit_icon.png" alt="Editar" title="Editar funcionário">
                        </a>
                    </td>
                    <!-- Link para excluir funcionário com confirmação -->
                    <td class="acoes">
                        <a href="<%= request.getContextPath() %>/ServletDeleteFuncionario?id=<%= funcionario.getId() %>" method="post"
                           onclick="return confirm('Tem certeza que deseja excluir este funcionário?');"
                           title="Excluir funcionário">
                            <img src="<%= request.getContextPath() %>/assets/delete_icon.png" alt="Excluir" title="Excluir funcionário">
                        </a>
                    </td>
                </tr>
                <%     }
                } else { %>
                <!-- Caso não haja funcionários cadastrados -->
                <tr>
                    <td colspan="10" title="Nenhum funcionário foi encontrado">Nenhum funcionário encontrado.</td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>

        <br>
        <!-- Link para voltar à página inicial -->
        <a href="<%= request.getContextPath() %>/login.jsp" class="hover-link" title="Voltar à página inicial">Voltar ao início</a>

    </main>
</div>
</body>
</html>
