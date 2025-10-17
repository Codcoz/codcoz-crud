<%@ page import="com.codcoz.model.Empresa" %>
<%@ page import="com.codcoz.dao.EmpresaDAO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Criar Funcionário</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
</head>
<body>
<div class="container">
    <jsp:include page="./../barraLateral.jsp" />

    <main class="content" style="overflow: auto">
        <header class="topo">
            <h2>Criar Funcionário</h2>
            <img src="<%= request.getContextPath() %>/assets/codcoz_icon.png" alt="Logo" class="logo" title="Logo Codcoz">
        </header>

        <div class="sub-header">
            <span class="hover-link ativo" title="Preencha os dados para cadastrar um novo funcionário">Novo Funcionário</span>
        </div>

        <div class="actions" style="margin-top: 30px;">
            <form action="<%= request.getContextPath() %>/ServletCreateFuncionario" method="post" style="max-width: 500px; width: 100%;">
                <label for="nome">Nome:</label><br>
                <input type="text" id="nome" name="nome" class="input-redondo"
                       placeholder="Nome" maxlength="50" required
                       title="Informe o primeiro nome do funcionário"><br><br>

                <label for="sobrenome">Sobrenome:</label><br>
                <input type="text" id="sobrenome" name="sobrenome" class="input-redondo"
                       placeholder="Sobrenome" maxlength="50" required
                       title="Informe o sobrenome do funcionário"><br><br>

                <label for="cpf">CPF:</label><br>

                <input type="text" id="cpf" name="cpf" class="input-redondo"
                       placeholder="CPF" maxlength="11"
                       pattern="^\\d{3}\\.\\d{3}\\.\\d{3}-\\d{2}$|^\\d{11}$" required
                       title="Informe o CPF no formato 000.000.000-00 ou apenas números"><br><br>

                <input type="text" id="cpf" name    ="cpf" class="input-redondo" placeholder="CPF" maxlength="11"
                       pattern="^\\d{3}\\.\\d{3}\\.\\d{3}-\\d{2}$|^\\d{11}$" required><br><br>

                <label for="email">E-mail:</label><br>
                <input type="email" id="email" name="email" class="input-redondo"
                       placeholder="E-mail" maxlength="100" required
                       title="Informe o e-mail do funcionário"><br><br>

                <label for="funcao">Função:</label><br>
                <select id="funcao" name="funcao" class="select-redondo" required title="Selecione a função do funcionário">
                    <option value="" disabled selected>Selecione a função</option>
                    <option value="Estoquista">Estoquista</option>
                    <option value="Gestor">Gestor</option>
                </select><br><br>

                <!-- ====== ADIÇÃO ESSENCIAL: STATUS ====== -->
                <label for="status">Status:</label><br>
                <select id="status" name="status" class="select-redondo" required>
                    <option value="ATIVO" selected>ATIVO</option>
                    <option value="INATIVO">INATIVO</option>
                </select><br><br>
                <!-- ===================================== -->

                <label for="idEmpresa">Empresa:</label><br>
                <%
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
                <a href="../empresaJSP/createEmpresa.jsp" class="hover-link" title="Cadastrar nova empresa">Criar Empresa</a>
                <br><br>

                <button type="submit" class="novo" title="Salvar novo funcionário">+</button>
            </form>
        </div>

        <br>
        <div style="display: flex; gap: 20px;">
            <a href="<%= request.getContextPath() %>/ServletReadFuncionario" class="hover-link" title="Ver lista de funcionários">Voltar à lista</a>
            <a href="<%= request.getContextPath() %>/index.jsp" class="hover-link" title="Voltar à página inicial">Voltar ao início</a>
        </div>

    </main>
</div>
</body>
</html>
