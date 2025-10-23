<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Criar Endereço</title>
    <!-- Estilos e fontes -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/icone.png">
</head>
<body>
<div class="container">
    <!-- Inclui a barra lateral -->
    <jsp:include page="./../barraLateral.jsp" />

    <main class="content" style="overflow: auto">
        <header class="topo">
            <h2>Criar Endereço</h2>
            <img src="<%= request.getContextPath() %>/assets/codcoz_icon.png" alt="Logo" class="logo" title="Logo Codcoz">
        </header>

        <div class="sub-header">
            <span class="hover-link ativo" title="Preencha os dados para cadastrar um novo endereço">Novo Endereço</span>
        </div>

        <div class="actions" style="margin-top: 30px;">
            <!-- Formulário para criação de endereço -->
            <form action="<%=request.getContextPath()%>/ServletCreateEndereco" method="post" style="max-width: 500px; width: 100%;">
                <!-- Campo Rua -->
                <label for="rua">Rua:</label><br>
                <input type="text" id="rua" name="rua" class="input-redondo"
                       placeholder="Nome da rua" maxlength="100" required
                       title="Informe o nome da rua"><br><br>

                <!-- Campo Complemento -->
                <label for="complemento">Complemento:</label><br>
                <input type="text" id="complemento" name="complemento" class="input-redondo"
                       placeholder="Complemento (opcional)" maxlength="50"
                       title="Informe o complemento, se houver"><br><br>

                <!-- Campo Cidade -->
                <label for="cidade">Cidade:</label><br>
                <input type="text" id="cidade" name="cidade" class="input-redondo"
                       placeholder="Cidade" maxlength="80" required
                       title="Informe a cidade"><br><br>

                <!-- Campo Estado -->
                <label for="estado">Estado:</label><br>
                <% String[] estados = { "AC", "AL", "AP", "AM", "BA", "CE", "DF", "ES", "GO", "MA", "MT", "MS", "MG", "PA", "PB", "PR", "PE", "PI", "RJ", "RN", "RS", "RO", "RR", "SC", "SP", "SE", "TO" }; %>
                <select name="estado" id="estado" class="select-redondo" required title="Selecione o estado">
                    <option value="">Selecione...</option>
                    <% for (String uf : estados) { %>
                    <option value="<%= uf %>"><%= uf %></option>
                    <% } %>
                </select><br><br>

                <!-- Campo CEP -->
                <label for="cep">CEP:</label><br>
                <input type="text" id="cep" name="cep" class="input-redondo"
                       placeholder="CEP (ex: 12345-678)" pattern="^\d{5}-?\d{3}$" maxlength="9" required
                       title="Informe o CEP no formato 00000-000"><br><br>

                <!-- Campo Número -->
                <label for="numero">Número:</label><br>
                <input type="text" id="numero" name="numero" class="input-redondo"
                       placeholder="Número da residência" maxlength="10"
                       title="Informe o número da residência"><br><br>

                <!-- Botão de envio -->
                <button type="submit" class="novo" title="Salvar novo endereço">+</button>
            </form>
        </div>

        <br>
        <!-- Navegação -->
        <div style="display: flex; gap: 20px;">
            <a href="<%=request.getContextPath()%>/ServletReadEndereco" class="hover-link" title="Ver lista de endereços">Voltar à lista</a>
            <a href="<%=request.getContextPath()%>/index.jsp" class="hover-link" title="Voltar à página inicial">Voltar ao início</a>
        </div>

    </main>
</div>
</body>
</html>
=