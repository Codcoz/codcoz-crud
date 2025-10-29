<%@ page import="com.codcoz.model.Funcionario" %>
<%@ page import="com.codcoz.dao.FuncionarioDAO" %>
<%@ page import="com.codcoz.model.Empresa" %>
<%@ page import="com.codcoz.dao.EmpresaDAO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Recupera o funcionário pelo ID recebido como parâmetro
    Integer id = null;
    try {
        id = Integer.parseInt(request.getParameter("id"));
    } catch (Exception e) { }

    Funcionario funcionario = null;
    List<Empresa> empresas = new EmpresaDAO().read();

    if (id != null) {
        FuncionarioDAO funcionarioDAO = new FuncionarioDAO();
        funcionario = funcionarioDAO.buscarPorId(id);
    }
%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Atualizar Funcionário</title>
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
            <h2>Atualizar Funcionário</h2>
            <img src="<%= request.getContextPath() %>/assets/codcoz_icon.png" alt="Logo" class="logo" title="Logo Codcoz">
        </header>

        <div class="sub-header">
            <span class="hover-link ativo" title="Edite os dados do funcionário selecionado">Editar Funcionário</span>
        </div>

        <% if (funcionario != null) { %>
        <div class="actions" style="margin-top: 30px;">
            <!-- Formulário para atualizar funcionário -->
            <form action="<%= request.getContextPath() %>/ServletUpdateFuncionario" method="post" style="max-width: 500px; width: 100%;">
                <input type="hidden" name="id" value="<%= funcionario.getId() %>"/>

                <!-- Campo Nome -->
                <label for="nome">Nome:</label><br>
                <input type="text" id="nome" name="nome" class="input-redondo"
                       value="<%= funcionario.getNome() %>" maxlength="50"
                       required placeholder="Ex: Ana" title="Informe o primeiro nome do funcionário"><br><br>

                <!-- Campo Sobrenome -->
                <label for="sobrenome">Sobrenome:</label><br>
                <input type="text" id="sobrenome" name="sobrenome" class="input-redondo"
                       value="<%= funcionario.getSobrenome() %>" maxlength="50"
                       required placeholder="Ex: Silva" title="Informe o sobrenome do funcionário"><br><br>

                <!-- Campo CPF -->
                <label for="cpf">CPF:</label><br>
                <input type="text" id="cpf" name="cpf" class="input-redondo"
                       value="<%= funcionario.getCpf() %>" maxlength="11"
                       pattern="^\d{3}\.\d{3}\.\d{3}-\d{2}$|^\d{11}$"
                       required placeholder="Ex: 123.456.789-00" title="Informe o CPF do funcionário"><br><br>

                <!-- Campo E-mail -->
                <label for="email">E-mail:</label><br>
                <input type="email" id="email" name="email" class="input-redondo"
                       value="<%= funcionario.getEmail() %>" maxlength="100"
                       required placeholder="Ex: nome@empresa.com.br" title="Informe o e-mail do funcionário"><br><br>

                <!-- Campo Empresa -->
                <label for="idEmpresa">Empresa:</label><br>
                <select id="idEmpresa" name="idEmpresa" class="select-redondo" required title="Selecione a empresa associada ao funcionário">
                    <option value="">Selecione uma empresa</option>
                    <% for (Empresa e : empresas) { %>
                    <option value="<%= e.getId() %>"
                            <%= (e.getId() != null && e.getId().equals(funcionario.getIdEmpresa())) ? "selected" : "" %>>
                        <%= e.getNome() %>
                    </option>
                    <% } %>
                </select>
                <br>
                <!-- Link para cadastrar nova empresa -->
                <a href="ServletReadEmpresa?view=create" class="hover-link" title="Cadastrar nova empresa">Criar Empresa</a>
                <br><br>

                <!-- Campo Função -->
                <label for="funcao">Função:</label><br>
                <select id="funcao" name="funcao" class="select-redondo" required title="Selecione a função do funcionário">
                    <option value="">Selecione a função</option>
                    <option value="Estoquista" <%= "Estoquista".equals(funcionario.getFuncao()) ? "selected" : "" %>>Estoquista</option>
                    <option value="Gestor" <%= "Gestor".equals(funcionario.getFuncao()) ? "selected" : "" %>>Gestor</option>
                </select><br><br>

                <!-- ====== ADIÇÃO ESSENCIAL: STATUS ====== -->

                <label for="status">Status:</label><br>
                <select id="status" name="status" class="select-redondo" required>
                    <option value="Ativo"   <%= "Ativo".equalsIgnoreCase(funcionario.getStatus())   ? "selected" : "" %>>Ativo</option>
                    <option value="Inativo" <%= "Intativo".equalsIgnoreCase(funcionario.getStatus()) ? "selected" : "" %>>Intativo</option>
                    <option value="Férias" <%= "Férias".equalsIgnoreCase(funcionario.getStatus()) ? "selected" : "" %>>Férias</option>
                </select><br><br>

                <button type="submit" class="novo">✔</button>
            </form>
        </div>
        <% } else { %>
        <!-- Mensagem de erro caso o funcionário não seja encontrado -->
        <p style="color: red;" title="Erro ao carregar funcionário">Funcionário não encontrado.</p>
        <% } %>

        <br>
        <!-- Navegação -->
        <div style="display: flex; gap: 20px;">
            <a href="<%= request.getContextPath() %>/ServletReadFuncionario" class="hover-link" title="Ver lista de funcionários">Voltar à lista</a>
            <a href="<%= request.getContextPath() %>/WEB-INF/menu.jsp" class="hover-link" title="Voltar à página inicial">Voltar ao início</a>
        </div>

    </main>
</div>
</body>
</html>
