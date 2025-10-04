<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="
    com.codcoz.dao.EnderecoDAO,
    com.codcoz.model.Endereco
" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Atualizar Endereço</title>
</head>
<body>
<%
    // Lê o parâmetro 'id' da request e busca o endereço correspondente
    Integer id = null;
    try {
        id = Integer.valueOf(request.getParameter("id"));
    } catch (Exception e) {
        // parâmetro inválido ou ausente
    }

    Endereco endereco = null;
    if (id != null) {
        endereco = new EnderecoDAO().buscarPorId(id);
    }
%>

<% if (endereco != null) { %>
<h2>Atualizar Endereço de ID <%= endereco.getId() %></h2>

<form action="<%= request.getContextPath() %>/ServletUpdateEndereco" method="post">
    <input type="hidden" name="id" value="<%= endereco.getId() %>"/>

    <label for="rua">Rua:</label>
    <input type="text" id="rua" name="rua"
           value="<%= endereco.getRua() %>"
           required placeholder="Ex: Av. Paulista">
    <br><br>

    <label for="complemento">Complemento:</label>
    <input type="text" id="complemento" name="complemento"
           value="<%= endereco.getComplemento() %>"
           placeholder="Ex: Apto 101, Fundos">
    <br><br>

    <label for="cidade">Cidade:</label>
    <input type="text" id="cidade" name="cidade"
           value="<%= endereco.getCidade() %>"
           required placeholder="Ex: São Paulo">
    <br><br>

    <label for="estado">Estado (UF):</label>
    <select id="estado" name="estado" required>
        <option value="">Selecione...</option>
        <option value="AC" <%= "AC".equals(endereco.getEstado()) ? "selected" : "" %>>AC</option>
        <option value="AL" <%= "AL".equals(endereco.getEstado()) ? "selected" : "" %>>AL</option>
        <option value="AP" <%= "AP".equals(endereco.getEstado()) ? "selected" : "" %>>AP</option>
        <option value="AM" <%= "AM".equals(endereco.getEstado()) ? "selected" : "" %>>AM</option>
        <option value="BA" <%= "BA".equals(endereco.getEstado()) ? "selected" : "" %>>BA</option>
        <option value="CE" <%= "CE".equals(endereco.getEstado()) ? "selected" : "" %>>CE</option>
        <option value="DF" <%= "DF".equals(endereco.getEstado()) ? "selected" : "" %>>DF</option>
        <option value="ES" <%= "ES".equals(endereco.getEstado()) ? "selected" : "" %>>ES</option>
        <option value="GO" <%= "GO".equals(endereco.getEstado()) ? "selected" : "" %>>GO</option>
        <option value="MA" <%= "MA".equals(endereco.getEstado()) ? "selected" : "" %>>MA</option>
        <option value="MT" <%= "MT".equals(endereco.getEstado()) ? "selected" : "" %>>MT</option>
        <option value="MS" <%= "MS".equals(endereco.getEstado()) ? "selected" : "" %>>MS</option>
        <option value="MG" <%= "MG".equals(endereco.getEstado()) ? "selected" : "" %>>MG</option>
        <option value="PA" <%= "PA".equals(endereco.getEstado()) ? "selected" : "" %>>PA</option>
        <option value="PB" <%= "PB".equals(endereco.getEstado()) ? "selected" : "" %>>PB</option>
        <option value="PR" <%= "PR".equals(endereco.getEstado()) ? "selected" : "" %>>PR</option>
        <option value="PE" <%= "PE".equals(endereco.getEstado()) ? "selected" : "" %>>PE</option>
        <option value="PI" <%= "PI".equals(endereco.getEstado()) ? "selected" : "" %>>PI</option>
        <option value="RJ" <%= "RJ".equals(endereco.getEstado()) ? "selected" : "" %>>RJ</option>
        <option value="RN" <%= "RN".equals(endereco.getEstado()) ? "selected" : "" %>>RN</option>
        <option value="RS" <%= "RS".equals(endereco.getEstado()) ? "selected" : "" %>>RS</option>
        <option value="RO" <%= "RO".equals(endereco.getEstado()) ? "selected" : "" %>>RO</option>
        <option value="RR" <%= "RR".equals(endereco.getEstado()) ? "selected" : "" %>>RR</option>
        <option value="SC" <%= "SC".equals(endereco.getEstado()) ? "selected" : "" %>>SC</option>
        <option value="SP" <%= "SP".equals(endereco.getEstado()) ? "selected" : "" %>>SP</option>
        <option value="SE" <%= "SE".equals(endereco.getEstado()) ? "selected" : "" %>>SE</option>
        <option value="TO" <%= "TO".equals(endereco.getEstado()) ? "selected" : "" %>>TO</option>
    </select>
    <br><br>

    <label for="cep">CEP:</label>
    <input type="text" id="cep" name="cep"
           value="<%= endereco.getCep() %>"
           required placeholder="Ex: 01311000">
    <br><br>

    <label for="numero">Número:</label>
    <input type="text" id="numero" name="numero"
           value="<%= endereco.getNumero() %>"
           required placeholder="Ex: 1578">
    <br><br>

    <button type="submit">Atualizar</button>
</form>
<% } else { %>
<p>Endereço não encontrado ou ID inválido.</p>
<% } %>

<br>
<a href="<%= request.getContextPath() %>/ServletReadEndereco">Voltar à lista</a>
<br><br>
<a href="<%= request.getContextPath() %>/index.html">Voltar ao início</a>
</body>
</html>
