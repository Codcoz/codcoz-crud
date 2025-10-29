<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Login - CodCoz</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="icon" type="image/png" href="WEB-INF/assets/icone.png">
    <link rel="stylesheet" href="style.css">
</head>
<body class="login-page">
<div class="login-container">
    <div class="login-left">
        <div class="login-logo">
            <img src="WEB-INF/assets/codcoz.png" alt="CodCoz">
        </div>
        <div class="login-subtitle" style="color: white;">Login área administrador</div>
    </div>

    <div class="login-divider"></div>

    <div class="login-right">
        <form action="<%= request.getContextPath() %>/ServletLogin" method="post" style="width: 100%; max-width: 300px; display: flex; flex-direction: column; gap: 6px; margin-top: 20px;">
            <label for="email" class="label-login">Email:</label>
            <input type="email" id="email" name="email" class="input-login" placeholder="Digite seu email" required>

            <label for="senha" class="label-login">Senha:</label>
            <input type="password" id="senha" name="senha" class="input-login" style="margin-bottom: 5px" placeholder="Digite sua senha" required>
            <p style="color: red; text-align: left";><%=request.getAttribute("mensagemErro")!=null ? request.getAttribute("mensagemErro") : ""%></p>

            <button type="submit" class="botao-menu">Entrar</button>
        </form>
    </div>
</div>
</body>
</html>
