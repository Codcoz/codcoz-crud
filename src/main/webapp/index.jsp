<%--
  Created by IntelliJ IDEA.
  User: felipeboregio-ieg
  Date: 15/09/2025
  Time: 18:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Gerenciamento de Endereços</title>
</head>
<body>

<%-- FORM CREATE --%>
<h2>Criar Endereço</h2>
<form action="ServletCreateEndereco" method="post">
    <label for="rua">Rua:</label>
    <input type="text" name="rua" id="rua" required placeholder="Ex: Av. Paulista"><br><br>

    <label for="complemento">Complemento:</label>
    <input type="text" name="complemento" id="complemento" placeholder="Ex: Apto 12, Fundos"><br><br>

    <label for="cidade">Cidade:</label>
    <input type="text" name="cidade" id="cidade" required placeholder="Ex: São Paulo"><br><br>

    <label for="estado">Estado (UF):</label>
    <select name="estado" id="estado" required>
        <option value="">Selecione...</option>
        <option value="AC">AC</option>
        <option value="AL">AL</option>
        <option value="AP">AP</option>
        <option value="AM">AM</option>
        <option value="BA">BA</option>
        <option value="CE">CE</option>
        <option value="DF">DF</option>
        <option value="ES">ES</option>
        <option value="GO">GO</option>
        <option value="MA">MA</option>
        <option value="MT">MT</option>
        <option value="MS">MS</option>
        <option value="MG">MG</option>
        <option value="PA">PA</option>
        <option value="PB">PB</option>
        <option value="PR">PR</option>
        <option value="PE">PE</option>
        <option value="PI">PI</option>
        <option value="RJ">RJ</option>
        <option value="RN">RN</option>
        <option value="RS">RS</option>
        <option value="RO">RO</option>
        <option value="RR">RR</option>
        <option value="SC">SC</option>
        <option value="SP">SP</option>
        <option value="SE">SE</option>
        <option value="TO">TO</option>
    </select> <br> <br>

    <label for="cep">CEP:</label>
    <input type="text" name="cep" id="cep" required pattern="\d{8}" title="Digite 8 números" placeholder="Ex: 01001000"><br><br>

    <label for="numero">Número:</label>
    <input type="text" name="numero" id="numero" required placeholder="Ex: 123"><br><br>

    <button type="submit">CREATE ENDERECO</button>
</form>

<hr>

<%-- FORM READ --%>
<h2>Ler Endereços</h2>
<form action="ServletReadEndereco" method="get">
    <button type="submit">LER ENDERECO</button>
</form>

<hr>

<%-- FORM UPDATE --%>
<h2>Atualizar Endereço</h2>
<form action="ServletUpdateEndereco" method="post">
    <label for="id1">ID para alterar:</label>
    <input type="number" id="id1" name="id1" required placeholder="Digite o ID do endereço"><br><br>

    <label for="rua1">Rua:</label>
    <input type="text" id="rua1" name="rua1" required placeholder="Ex: Av. Paulista"><br><br>

    <label for="complemento1">Complemento:</label>
    <input type="text" id="complemento1" name="complemento1" placeholder="Ex: Apto 101, Fundos"><br><br>

    <label for="cidade1">Cidade:</label>
    <input type="text" id="cidade1" name="cidade1" required placeholder="Ex: São Paulo"><br><br>

    <label for="estado">Estado (UF):</label>
    <select name="estado1" id="estado1" required>
        <option value="">Selecione...</option>
        <option value="AC">AC</option>
        <option value="AL">AL</option>
        <option value="AP">AP</option>
        <option value="AM">AM</option>
        <option value="BA">BA</option>
        <option value="CE">CE</option>
        <option value="DF">DF</option>
        <option value="ES">ES</option>
        <option value="GO">GO</option>
        <option value="MA">MA</option>
        <option value="MT">MT</option>
        <option value="MS">MS</option>
        <option value="MG">MG</option>
        <option value="PA">PA</option>
        <option value="PB">PB</option>
        <option value="PR">PR</option>
        <option value="PE">PE</option>
        <option value="PI">PI</option>
        <option value="RJ">RJ</option>
        <option value="RN">RN</option>
        <option value="RS">RS</option>
        <option value="RO">RO</option>
        <option value="RR">RR</option>
        <option value="SC">SC</option>
        <option value="SP">SP</option>
        <option value="SE">SE</option>
        <option value="TO">TO</option>
    </select> <br> <br>

    <label for="cep1">CEP:</label>
    <input type="text" id="cep1" name="cep1" required placeholder="Ex: 01311-000"><br><br>

    <label for="numero1">Número:</label>
    <input type="text" id="numero1" name="numero1" required placeholder="Ex: 1578"><br><br>

    <button type="submit">UPDATE ENDERECO</button>
</form>

<hr>

<form action="ServletDeleteEndereco" method="post">
    <h2>Deletar Endereço</h2>
    <label for="id2">ID:</label>
    <input type="text" id="id2" name="id2" required placeholder="Ex: 1"><br><br>

    <button type="submit">DELETE ENDERECO</button>
</form>

</body>
</html>