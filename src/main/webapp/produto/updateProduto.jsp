<%@ page import="com.codcoz.model.Produto" %>
<%@ page import="com.codcoz.dao.ProdutoDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Integer id = Integer.parseInt(request.getParameter("id"));
    Produto produto = null;

    if (id != null) {
        ProdutoDAO produtoDAO = new ProdutoDAO();
        produto = produtoDAO.buscarPorId(id);
    }
%>

<html>
<head>
    <title>Atualizar Endereço</title>
</head>
<body>
<h2>Atualizar Endereço de ID <%= endereco.getId() %></h2>
<% if (endereco != null) { %>
<form action="ServletUpdateEndereco" method="post">
    <input type="hidden" name="id" value="<%= endereco.getId() %>"/>

    <label for="rua">Rua:</label>
    <input type="text" id="rua" name="rua" value="<%= endereco.getRua() %>" required placeholder="Ex: Av. Paulista"><br><br>

    <label for="complemento">Complemento:</label>
    <input type="text" id="complemento" name="complemento" value="<%= endereco.getComplemento() %>" placeholder="Ex: Apto 101, Fundos"><br><br>

    <label for="cidade">Cidade:</label>
    <input type="text" id="cidade" name="cidade" value="<%= endereco.getCidade() %>" required placeholder="Ex: São Paulo"><br><br>

    <label for="estado">Estado (UF):</label>
    <select name="estado" id="estado" required>
        <option value="">Selecione...</option>
        <option value="AC" <%= endereco.getEstado().equals("AC") ? "selected" : "" %>>AC</option>
        <option value="AL" <%= endereco.getEstado().equals("AL") ? "selected" : "" %>>AL</option>
        <option value="AP" <%= endereco.getEstado().equals("AP") ? "selected" : "" %>>AP</option>
        <option value="AM" <%= endereco.getEstado().equals("AM") ? "selected" : "" %>>AM</option>
        <option value="BA" <%= endereco.getEstado().equals("BA") ? "selected" : "" %>>BA</option>
        <option value="CE" <%= endereco.getEstado().equals("CE") ? "selected" : "" %>>CE</option>
        <option value="DF" <%= endereco.getEstado().equals("DF") ? "selected" : "" %>>DF</option>
        <option value="ES" <%= endereco.getEstado().equals("ES") ? "selected" : "" %>>ES</option>
        <option value="GO" <%= endereco.getEstado().equals("GO") ? "selected" : "" %>>GO</option>
        <option value="MA" <%= endereco.getEstado().equals("MA") ? "selected" : "" %>>MA</option>
        <option value="MT" <%= endereco.getEstado().equals("MT") ? "selected" : "" %>>MT</option>
        <option value="MS" <%= endereco.getEstado().equals("MS") ? "selected" : "" %>>MS</option>
        <option value="MG" <%= endereco.getEstado().equals("MG") ? "selected" : "" %>>MG</option>
        <option value="PA" <%= endereco.getEstado().equals("PA") ? "selected" : "" %>>PA</option>
        <option value="PB" <%= endereco.getEstado().equals("PB") ? "selected" : "" %>>PB</option>
        <option value="PR" <%= endereco.getEstado().equals("PR") ? "selected" : "" %>>PR</option>
        <option value="PE" <%= endereco.getEstado().equals("PE") ? "selected" : "" %>>PE</option>
        <option value="PI" <%= endereco.getEstado().equals("PI") ? "selected" : "" %>>PI</option>
        <option value="RJ" <%= endereco.getEstado().equals("RJ") ? "selected" : "" %>>RJ</option>
        <option value="RN" <%= endereco.getEstado().equals("RN") ? "selected" : "" %>>RN</option>
        <option value="RS" <%= endereco.getEstado().equals("RS") ? "selected" : "" %>>RS</option>
        <option value="RO" <%= endereco.getEstado().equals("RO") ? "selected" : "" %>>RO</option>
        <option value="RR" <%= endereco.getEstado().equals("RR") ? "selected" : "" %>>RR</option>
        <option value="SC" <%= endereco.getEstado().equals("SC") ? "selected" : "" %>>SC</option>
        <option value="SP" <%= endereco.getEstado().equals("SP") ? "selected" : "" %>>SP</option>
        <option value="SE" <%= endereco.getEstado().equals("SE") ? "selected" : "" %>>SE</option>
        <option value="TO" <%= endereco.getEstado().equals("TO") ? "selected" : "" %>>TO</option>
    </select><br><br>


    <label for="cep">CEP:</label>
    <input type="text" id="cep" name="cep" value="<%= endereco.getCep() %>" required placeholder="Ex: 01311000"><br><br>

    <label for="numero">Número:</label>
    <input type="text" id="numero" name="numero" value="<%= endereco.getNumero() %>" required placeholder="Ex: 1578"><br><br>

    <button type="submit">Update</button>

</form>
<% } else { %>
<p>Endereço não encontrado.</p>
<% } %>

<a href="ServletReadEndereco">Voltar à lista</a>
</body>
</html>