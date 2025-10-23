<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="
    com.codcoz.dao.NotaFiscalXmlDAO,
    com.codcoz.dao.EmpresaDAO,
    com.codcoz.model.NotaFiscalXml,
    com.codcoz.model.Empresa,
    java.util.List
" %>
<%
    // Recupera a nota fiscal pelo ID recebido como parâmetro
    Integer id = null;
    try {
        id = Integer.parseInt(request.getParameter("id"));
    } catch (Exception e) {}

    NotaFiscalXml nota = null;
    List<Empresa> empresas = new EmpresaDAO().read();

    if (id != null) {
        nota = new NotaFiscalXmlDAO().buscarPorId(id);
    }
%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Atualizar Nota Fiscal XML</title>
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
            <h2>Atualizar Nota Fiscal XML</h2>
            <img src="<%= request.getContextPath() %>/assets/codcoz_icon.png" alt="Logo" class="logo" title="Logo Codcoz">
        </header>

        <div class="sub-header">
            <span class="hover-link ativo" title="Edite os dados da nota fiscal selecionada">Editar Nota Fiscal</span>
        </div>

        <% if (nota != null) { %>
        <div class="actions" style="margin-top: 30px;">
            <!-- Formulário para atualizar nota fiscal XML -->
            <form action="<%= request.getContextPath() %>/ServletUpdateNotaFiscalXml" method="post" style="max-width: 500px; width: 100%;">
                <input type="hidden" name="id" value="<%= nota.getId() %>"/>

                <!-- Campo Empresa -->
                <label for="idEmpresa">Empresa:</label><br>
                <select id="idEmpresa" name="idEmpresa" class="select-redondo" required title="Selecione a empresa emissora da nota fiscal">
                    <option value="">Selecione uma empresa</option>
                    <% for (Empresa emp : empresas) { %>
                    <option value="<%= emp.getId() %>" <%= emp.getId().equals(nota.getIdEmpresa()) ? "selected" : "" %>>
                        <%= emp.getNome() %> (CNPJ: <%= emp.getCnpj() %>)
                    </option>
                    <% } %>
                </select>
                <br>
                <!-- Link para cadastrar nova empresa -->
                <a href="../empresaJSP/createEmpresa.jsp" class="hover-link" title="Cadastrar nova empresa">Criar Empresa</a>
                <br><br>

                <!-- Campo Data de Emissão -->
                <label for="dataEmissao">Data de Emissão:</label><br>
                <input type="date" id="dataEmissao" name="dataEmissao" class="input-redondo"
                       value="<%= nota.getDataEmissao() %>" required
                       title="Informe a data de emissão da nota fiscal"><br><br>

                <!-- Campo Número da Nota -->
                <label for="numeroNota">Número da Nota:</label><br>
                <input type="text" id="numeroNota" name="numeroNota" class="input-redondo"
                       value="<%= nota.getNumeroNota() %>" required
                       placeholder="Ex: NF-2025-001" title="Informe o número da nota fiscal"><br><br>

                <!-- Campo Conteúdo XML -->
                <label for="xmlString">Conteúdo XML:</label><br>
                <textarea id="xmlString" name="xmlString" class="input-redondo" rows="6" required
                          placeholder="Cole o conteúdo XML aqui" title="Cole o conteúdo XML da nota fiscal"><%= nota.getXmlString() %></textarea><br><br>

                <!-- Botão para salvar alterações -->
                <button type="submit" class="novo" title="Salvar alterações">+</button>
            </form>
        </div>
        <% } else { %>
        <!-- Mensagem de erro caso a nota fiscal não seja encontrada -->
        <p style="color: red;" title="Erro ao carregar nota fiscal">Nota Fiscal não encontrada ou ID inválido.</p>
        <% } %>

        <br>
        <!-- Navegação -->
        <div style="display: flex; gap: 20px;">
            <a href="<%= request.getContextPath() %>/ServletReadNotaFiscalXml" class="hover-link" title="Ver lista de notas fiscais">Voltar à lista</a>
            <a href="<%= request.getContextPath() %>/menu.jsp" class="hover-link" title="Voltar à página inicial">Voltar ao início</a>
        </div>

    </main>
</div>
</body>
</html>
