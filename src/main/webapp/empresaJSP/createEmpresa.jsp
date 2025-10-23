<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="
    java.util.List,
    com.codcoz.dao.EnderecoDAO,
    com.codcoz.model.Endereco
" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Criar Empresa</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/icone.png">
</head>
<body>
<div class="container" style="overflow: auto">

    <jsp:include page="./../barraLateral.jsp" />

    <main class="content">
        <header class="topo">
            <h2>Criar Empresa</h2>
            <img src="<%= request.getContextPath() %>/assets/codcoz_icon.png" alt="Logo" class="logo" title="Logo Codcoz">
        </header>

        <div class="sub-header">
            <span class="hover-link ativo" title="Preencha os dados para cadastrar uma nova empresa">Nova Empresa</span>
        </div>


        <div class="actions" style="margin-top: 30px;">
            <form action="<%= request.getContextPath() %>/ServletCreateEmpresa" method="post" style="max-width: 500px; width: 100%;">
                <label for="nome">Nome:</label><br>
                <input type="text" id="nome" name="nome" class="input-redondo"
                       placeholder="Nome da empresa" maxlength="150" required
                       title="Informe o nome da empresa"><br><br>

                <label for="cnpj">CNPJ:</label><br>
                <input type="text" id="cnpj" name="cnpj" class="input-redondo"
                       pattern="^\d{2}\.\d{3}\.\d{3}/\d{4}-\d{2}$|^\d{14}$"
                       placeholder="CNPJ" maxlength="14" required
                       title="Informe o CNPJ da empresa"><br><br>

                <label for="idEndereco">Endereço:</label><br>
                <%
                    List<Endereco> enderecos = new EnderecoDAO().read();
                %>
                <select id="idEndereco" name="idEndereco" class="select-redondo" required title="Selecione o endereço da empresa">
                    <option value="">Selecione um endereço</option>
                    <% for (Endereco e : enderecos) { %>
                    <option value="<%= e.getId() %>">
                        (<%= e.getCep() %>) <%= e.getCidade() %>, rua <%= e.getRua() %>, <%= e.getNumero() %> - <%= e.getEstado() %>
                    </option>
                    <% } %>
                </select>
                <br>
                <a href="../enderecoJSP/createEndereco.jsp" class="hover-link" title="Cadastrar novo endereço">Criar Endereço</a>
                <br><br>

                <label for="email">Email:</label><br>
                <input type="email" id="email" name="email" class="input-redondo"
                       pattern="^[A-Za-z0-9._%+-]+@(gmail\.com|net\.com|outlook\.com|hotmail\.com|yahoo\.com|icloud\.com|uol\.com\.br|terra\.com\.br|bol\.com\.br)$"
                       placeholder="Email da empresa" required
                       title="Informe o e-mail da empresa"><br><br>

                <button type="submit" class="novo" title="Salvar nova empresa">+</button>
            </form>
        </div>

        <br>
        <div style="display: flex; gap: 20px;">
            <a href="<%=request.getContextPath()%>/ServletReadEmpresa" class="hover-link" title="Ver lista de empresas">Voltar à lista</a>
            <a href="<%=request.getContextPath()%>/index.jsp" class="hover-link" title="Voltar à página inicial">Voltar ao início</a>
        </div>

    </main>
</div>
</body>
</html>
