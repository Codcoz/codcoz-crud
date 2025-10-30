<%@ page import="com.codcoz.model.Empresa" %>
<%@ page import="com.codcoz.dao.EmpresaDAO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Criar Funcionário</title>
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
            <h2>Criar Funcionário</h2>
            <img src="<%= request.getContextPath() %>/assets/codcoz_icon.png" alt="Logo" class="logo" title="Logo Codcoz">
        </header>

        <div class="sub-header">
            <span class="hover-link ativo" title="Preencha os dados para cadastrar um novo funcionário">Novo Funcionário</span>
        </div>

        <div class="actions" style="margin-top: 30px;">
            <!-- Formulário para criação de funcionário -->
            <form action="<%= request.getContextPath() %>/ServletCreateFuncionario" method="post" style="max-width: 500px; width: 100%;">
                <!-- Campo Nome -->
                <label for="nome">Nome:</label><br>
                <input type="text" id="nome" name="nome" class="input-redondo"
                       placeholder="Nome" maxlength="50" required
                       title="Informe o primeiro nome do funcionário"><br><br>

                <!-- Campo Sobrenome -->
                <label for="sobrenome">Sobrenome:</label><br>
                <input type="text" id="sobrenome" name="sobrenome" class="input-redondo"
                       placeholder="Sobrenome" maxlength="50" required
                       title="Informe o sobrenome do funcionário"><br><br>

                <!-- Campo CPF -->
                <label for="cpf">CPF:</label><br>
                <input type="text" id="cpf" name="cpf" class="input-redondo"
                       placeholder="000.000.000-00 ou 00000000000"
                       maxlength="14"
                       pattern="\d{3}\.\d{3}\.\d{3}-\d{2}|\d{11}"
                       required
                       title="Informe o CPF no formato 000.000.000-00 ou apenas números"><br><br>

                <!-- Campo E-mail -->
                <label for="email">E-mail:</label><br>
                <input type="text" id="email" name="email" class="input-redondo"
                       placeholder="Ex: nome@empresa.com.br"
                       maxlength="100"
                       required
                       pattern="^[A-Za-z0-9._%+-]+@(gmail\.com|net\.com|outlook\.com|hotmail\.com|yahoo\.com|icloud\.com|uol\.com\.br|terra\.com\.br|bol\.com\.br)$"
                       title="É preciso que o formato corresponda ao exigido. Informe o e-mail do funcionário com domínio permitido: gmail.com, outlook.com, uol.com.br, etc."><br><br>



                <!-- Campo Função -->
                <label for="funcao">Função:</label><br>
                <select id="funcao" name="funcao" class="select-redondo" required title="Selecione a função do funcionário">
                    <option value="" disabled selected>Selecione a função</option>
                    <option value="Estoquista">Estoquista</option>
                    <option value="Gestor">Gestor</option>
                </select><br><br>

                <!-- Campo Status -->
                <label for="status">Status:</label><br>
                <select id="status" name="status" class="select-redondo" required>
                    <option value="Ativo">Ativo</option>
                    <option value="Inativo">Intativo</option>
                    <option value="Férias">Férias</option>
                </select><br><br>

                <!-- Campo Empresa -->
                <label for="idEmpresa">Empresa:</label><br>
                <%
                    // Carrega lista de empresas para o select
                    List<Empresa> empresas = new EmpresaDAO().read();
                %>
                <select id="idEmpresa" name="idEmpresa" class="select-redondo" required title="Selecione a empresa associada ao funcionário">
                    <option value="">Selecione uma empresa</option>
                    <% for (Empresa emp : empresas) { %>
                    <option value="<%= emp.getId() %>">
                        <%= emp.getNome() %> (CNPJ: <%= emp.getCnpj() %>)
                    </option>
                    <% } %>
                </select>
                <br>
                <!-- Link para cadastrar nova empresa -->
                <a href="ServletReadEmpresa?view=create" class="hover-link" title="Cadastrar nova empresa">Criar Empresa</a>
                <br><br>

                <!-- Botão de envio -->
                <button type="submit" class="novo" title="Salvar novo funcionário">+</button>
            </form>
        </div>

        <br>
        <!-- Navegação -->
        <div style="display: flex; gap: 20px;">
            <a href="<%= request.getContextPath() %>/ServletReadFuncionario" class="hover-link" title="Ver lista de funcionários">Voltar à lista</a>
            <a href="<%= request.getContextPath() %>/login.jsp" class="hover-link" title="Voltar à página inicial">Voltar ao início</a>
        </div>

    </main>
</div>
</body>
</html>