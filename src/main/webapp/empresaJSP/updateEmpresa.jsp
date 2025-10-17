<%@ page import="com.codcoz.model.Empresa" %>
<%@ page import="com.codcoz.dao.EmpresaDAO" %>
<%@ page import="com.codcoz.dao.EnderecoDAO" %>
<%@ page import="com.codcoz.model.Endereco" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Integer id = Integer.parseInt(request.getParameter("id"));
    Empresa empresa = null;
    List<Endereco> enderecos = new EnderecoDAO().read();

    if (id != null) {
        EmpresaDAO empresaDAO = new EmpresaDAO();
        empresa = empresaDAO.buscarPorId(id);
    }
%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Atualizar Empresa</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
</head>
<body>
<div class="container">

    <jsp:include page="./../barraLateral.jsp" />

    <main class="content">
        <header class="topo">
            <h2>Atualizar Empresa</h2>
            <img src="<%= request.getContextPath() %>/assets/codcoz_icon.png" alt="Logo" class="logo">
        </header>

        <div class="sub-header">
            <span class="hover-link ativo">Editar Empresa</span>
        </div>


        <% if (empresa != null) { %>
        <div class="actions">
            <form action="<%=request.getContextPath()%>/ServletUpdateEmpresa" method="post" style="max-width: 500px;">
                <input type="hidden" name="id" value="<%= empresa.getId() %>"/>

                <label for="nome">Nome:</label><br>
                <input type="text" id="nome" name="nome" class="input-redondo" value="<%= empresa.getNome() %>" maxlength="150"
                       required placeholder="Ex: Codcoz Ltda"><br><br>

                <label for="cnpj">CNPJ:</label><br>
                <input type="text" id="cnpj" name="cnpj" class="input-redondo" value="<%= empresa.getCnpj() %>" maxlength="14"
                       pattern="^\d{2}\.\d{3}\.\d{3}/\d{4}-\d{2}$|^\d{14}$" required placeholder="Ex: 12.345.678/0001-90"><br><br>
                <label for="idEndereco">Endereço:</label><br>
                <select id="idEndereco" name="idEndereco" class="select-redondo" required>
                    <option value="">Selecione um endereço</option>
                    <% for (Endereco e : enderecos) { %>
                    <option value="<%= e.getId() %>" <%= e.getId() == empresa.getIdEndereco() ? "selected" : "" %>>
                        (<%= e.getCep() %>) <%= e.getCidade() %>, rua <%= e.getRua() %>, <%= e.getNumero() %> - <%= e.getEstado() %>
                    </option>
                    <% } %>
                </select>
                <br>
                <a href="../enderecoJSP/createEndereco.jsp" class="hover-link">Criar Endereço</a>
                <br><br>

                <label for="email">Email:</label><br>
                <input type="email" id="email" name="email" class="input-redondo" value="<%= empresa.getEmail() %>"
                       pattern="^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.((com|net|org|gov|edu|info|biz|co)(\\.br)?|br)$"
                       required placeholder="Ex: contato@empresa.com.br">
                <br><br>

                <button type="submit" class="novo">✔</button>
            </form>
        </div>
        <% } else { %>
        <p style="color: red;">Empresa não encontrada.</p>
        <% } %>

        <br>
        <div style="display: flex;">
            <a href="<%=request.getContextPath()%>/ServletReadEmpresa" class="hover-link">Voltar à lista</a>
            <a href="<%=request.getContextPath()%>/index.jsp" class="hover-link">Voltar ao início</a>
        </div>
    </main>
</div>
</body>
</html>