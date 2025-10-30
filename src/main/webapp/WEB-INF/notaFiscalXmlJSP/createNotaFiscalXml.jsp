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
    <!-- Estilos e fontes -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/icone.png">
</head>
<body>
<div class="container">
    <!-- Inclui a barra lateral -->
    <jsp:include page="../barraLateral.jsp" />

    <main class="content" style="overflow: auto">
        <header class="topo">
            <h2>Criar Nota Fiscal XML</h2>
            <img src="<%= request.getContextPath() %>/assets/codcoz_icon.png" alt="Logo" class="logo" title="Logo Codcoz">
        </header>

        <div class="sub-header">
            <span class="hover-link ativo" title="Preencha os dados para cadastrar uma nova nota fiscal">Nova Nota Fiscal</span>
        </div>

        <div class="actions" style="margin-top: 30px;">
            <!-- Formulário para criação de nota fiscal XML -->
            <form action="<%= request.getContextPath() %>/ServletCreateNotaFiscalXml" method="post" style="max-width: 500px; width: 100%;">
                <!-- Campo Empresa -->
                <label for="idEmpresa">Empresa:</label><br>
                <%
                    // Carrega lista de empresas para o select
                    List<Empresa> empresas = new EmpresaDAO().read();
                %>
                <select id="idEmpresa" name="idEmpresa" class="select-redondo" required title="Selecione a empresa emissora da nota fiscal">
                    <option value="">Selecione uma empresa</option>
                    <% for (Empresa emp : empresas) { %>
                    <option value="<%= emp.getId() %>">
                        <%= emp.getNome() %> (CNPJ: <%= emp.getCnpj() %>)
                    </option>
                    <% } %>
                </select>
                <br>
                <!-- Link para cadastrar nova empresa -->
                <a href="ServletReadEmpresa?view=create" class="hover-link" title="Cadastrar nova empresa">Criar Empresa</a>
                <br><br>

                <!-- Campo Data de Emissão -->
                <label for="dataEmissao">Data de Emissão:</label><br>
                <input type="date" id="dataEmissao" name="dataEmissao" class="input-redondo"
                       required title="Informe a data de emissão da nota fiscal"><br><br>

                <!-- Campo Número da Nota -->
                <label for="numeroNota">Número da Nota:</label><br>
                <input type="text" id="numeroNota" name="numeroNota" class="input-redondo"
                       placeholder="Ex: 123456" required
                       title="Informe o número da nota fiscal"><br><br>

                <!-- Campo Conteúdo XML -->
                <label for="xmlString">Conteúdo XML:</label><br>
                <textarea id="xmlString" name="xmlString" class="input-redondo" rows="6"
                          placeholder="Cole o XML aqui..." required
                          title="Cole o conteúdo XML da nota fiscal"></textarea><br><br>

                <!-- Botão de envio -->
                <button type="submit" class="novo" title="Salvar nova nota fiscal">+</button>
            </form>
        </div>

        <br>
        <!-- Navegação -->
        <div style="display: flex; gap: 20px;">
            <a href="<%= request.getContextPath() %>/ServletReadNotaFiscalXml" class="hover-link" title="Ver lista de notas fiscais">Voltar à lista</a>
            <a href="<%= request.getContextPath() %>/login.jsp" class="hover-link" title="Voltar à página inicial">Voltar ao início</a>
        </div>

    </main>
</div>
</body>
</html>
