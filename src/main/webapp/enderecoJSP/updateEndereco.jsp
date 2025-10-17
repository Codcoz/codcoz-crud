<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="
    com.codcoz.dao.EnderecoDAO,
    com.codcoz.model.Endereco
" %>
<%
    Integer id = null;
    try {
        id = Integer.valueOf(request.getParameter("id"));
    } catch (Exception e) {}

    Endereco endereco = null;
    if (id != null) {
        endereco = new EnderecoDAO().buscarPorId(id);
    }
%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Atualizar Endereço</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
</head>
<body>
<div class="container">
    <jsp:include page="./../barraLateral.jsp" />
    <main class="content" style="overflow: auto">
        <header class="topo">
            <h2>Atualizar Endereço</h2>
            <img src="<%= request.getContextPath() %>/assets/codcoz_icon.png" alt="Logo" class="logo" title="Logo Codcoz">
        </header>

        <div class="sub-header">
            <span class="hover-link ativo" title="Edite os dados do endereço selecionado">Editar Endereço</span>
        </div>

        <% if (endereco != null) { %>
        <div class="actions" style="margin-top: 30px;">
            <form action="<%= request.getContextPath() %>/ServletUpdateEndereco" method="post" style="max-width: 500px; width: 100%;">
                <input type="hidden" name="id" value="<%= endereco.getId() %>"/>

                <label for="rua">Rua:</label><br>
                <input type="text" id="rua" name="rua" class="input-redondo"
                       value="<%= endereco.getRua() %>" maxlength="100"
                       required placeholder="Ex: Av. Paulista" title="Informe o nome da rua"><br><br>

                <label for="complemento">Complemento:</label><br>
                <input type="text" id="complemento" name="complemento" class="input-redondo"
                       value="<%= endereco.getComplemento() %>" maxlength="50"
                       placeholder="Ex: Apto 101, Fundos" title="Informe o complemento, se houver"><br><br>

                <label for="cidade">Cidade:</label><br>
                <input type="text" id="cidade" name="cidade" class="input-redondo"
                       value="<%= endereco.getCidade() %>" maxlength="80"
                       required placeholder="Ex: São Paulo" title="Informe a cidade"><br><br>

                <label for="estado">Estado (UF):</label><br>
                <select id="estado" name="estado" class="select-redondo" required title="Selecione o estado">
                    <option value="">Selecione...</option>
                    <% String[] estados = { "AC", "AL", "AP", "AM", "BA", "CE", "DF", "ES", "GO", "MA", "MT", "MS", "MG", "PA", "PB", "PR", "PE", "PI", "RJ", "RN", "RS", "RO", "RR", "SC", "SP", "SE", "TO" };
                        for (String uf : estados) { %>
                    <option value="<%= uf %>" <%= uf.equals(endereco.getEstado()) ? "selected" : "" %>><%= uf %></option>
                    <% } %>
                </select><br><br>

                <label for="cep">CEP:</label><br>
                <input type="text" id="cep" name="cep" class="input-redondo"
                       value="<%= endereco.getCep() %>" maxlength="8"
                       pattern="^\d{5}-?\d{3}$" required placeholder="Ex: 01311000" title="Informe o CEP no formato 00000-000"><br><br>

                <label for="numero">Número:</label><br>
                <input type="text" id="numero" name="numero" class="input-redondo"
                       value="<%= endereco.getNumero() %>" maxlength="10"
                       required placeholder="Ex: 1578" title="Informe o número da residência"><br><br>

                <button type="submit" class="novo" title="Salvar alterações">+</button>
            </form>
        </div>
        <% } else { %>
        <p style="color: red;" title="Erro ao carregar endereço">Endereço não encontrado ou ID inválido.</p>
        <% } %>

        <br>
        <div style="display: flex; gap: 20px;">
            <a href="<%= request.getContextPath() %>/ServletReadEndereco" class="hover-link" title="Ver lista de endereços">Voltar à lista</a>
            <a href="<%= request.getContextPath() %>/index.jsp" class="hover-link" title="Voltar à página inicial">Voltar ao início</a>

        </div>
    </main>
</div>
</body>
</html>
