<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Criar Endereço</title>
</head>
<body>
<h1>Criar Endereço</h1>
<form action="<%=request.getContextPath()%>/ServletCreateEndereco" method="post">
    <label for="rua">Rua:</label>
    <input type="text" id="rua" name="rua" placeholder="rua" max="100" required><br><br>

    <label for="complemento">Complemento:</label>
    <input type="text" id="complemento" name="complemento" placeholder="complemento" maxlength="50" required><br><br>

    <label for="cidade">Cidade:</label>
    <input type="text" id="cidade" name="cidade" placeholder="cidade" maxlength="80" required><br><br>

    <label for="estado">Estado:</label>
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
    </select><br><br>

    <label for="cep">CEP:</label>
    <input type="text" id="cep" name="cep" placeholder="cep" maxlength="8" ><br><br>
    <c:if test="${not empty erroCep}">
        <p style="color:red">${erroCep}</p>
    </c:if>


    <label for="numero">Número:</label>
    <input type="text" id="numero" name="numero" placeholder="numero" maxlength="10"><br><br>

    <button type="submit">CRIAR</button><br><br>

    <a href="<%=request.getContextPath()%>/ServletReadEndereco">Voltar à lista</a><br><br>
    <a href="<%=request.getContextPath()%>/index.html">Voltar ao início</a>
</form>
</body>
</html>