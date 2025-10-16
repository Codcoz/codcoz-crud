<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="
    com.codcoz.dao.EmpresaDAO,
    com.codcoz.model.Empresa,
    java.util.List
" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Criar Nota Fiscal XML</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
</head>
<body>
<div class="container">
        <jsp:include page="./../barraLateral.jsp" />
    <main class="content">
        <header class="topo">
            <h2>Criar Nota Fiscal XML</h2>
            <img src="<%= request.getContextPath() %>/assets/codcoz_icon.png" alt="Logo" class="logo">
        </header>

        <div class="sub-header">
            <span class="hover-link ativo">Nova Nota Fiscal</span>
        </div>

        <div class="actions">
            <form action="<%= request.getContextPath() %>/ServletCreateNotaFiscalXml" method="post" style="max-width: 500px;">
                <label for="idEmpresa">Empresa:</label><br>
                <%
                    List<Empresa> empresas = new EmpresaDAO().read();
                %>
                <select id="idEmpresa" name="idEmpresa" class="select-redondo" required>
                    <option value="">Selecione uma empresa</option>
                    <% for (Empresa emp : empresas) { %>
                    <option value="<%= emp.getId() %>">
                        <%= emp.getNome() %> (CNPJ: <%= emp.getCnpj() %>)
                    </option>
                    <% } %>
                </select>
                <br>
                <a href="../empresaJSP/createEmpresa.jsp" class="hover-link">Criar Empresa</a>
                <br><br>

                <label for="dataEmissao">Data de Emissão:</label><br>
                <input type="date" id="dataEmissao" name="dataEmissao" class="input-redondo" required><br><br>

                <label for="numeroNota">Número da Nota:</label><br>
                <input type="text" id="numeroNota" name="numeroNota" class="input-redondo"
                       placeholder="Ex: 123456" required><br><br>

                <label for="xmlString">Conteúdo XML:</label><br>
                <textarea id="xmlString" name="xmlString" class="input-redondo" rows="6"
                          placeholder="Cole o XML aqui..." required></textarea><br><br>

                <button type="submit" class="novo">+</button>
            </form>
        </div>

        <br>
        <div style="display: flex">
            <a href="<%= request.getContextPath() %>/ServletReadNotaFiscalXml" class="hover-link">Voltar à lista</a><br>
            <a href="<%= request.getContextPath() %>/index.jsp" class="hover-link">Voltar ao início</a>
        </div>
    </main>
</div>
</body>
</html>
