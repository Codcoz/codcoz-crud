<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="
    com.codcoz.dao.NotaFiscalXmlDAO,
    com.codcoz.dao.EmpresaDAO,
    com.codcoz.model.NotaFiscalXml,
    com.codcoz.model.Empresa,
    java.util.List
" %>
<%
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
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
</head>
<body>
<div class="container">
    <jsp:include page="./../barraLateral.jsp" />

    <main class="content">
        <header class="topo">
            <h2>Atualizar Nota Fiscal XML</h2>
            <img src="<%= request.getContextPath() %>/assets/codcoz_icon.png" alt="Logo" class="logo">
        </header>

        <div class="sub-header">
            <span class="hover-link ativo">Editar Nota Fiscal</span>
        </div>

        <% if (nota != null) { %>
        <div class="actions">
            <form action="<%= request.getContextPath() %>/ServletUpdateNotaFiscalXml" method="post" style="max-width: 500px;">
                <input type="hidden" name="id" value="<%= nota.getId() %>"/>

                <label for="idEmpresa">Empresa:</label><br>
                <select id="idEmpresa" name="idEmpresa" class="select-redondo" required>
                    <option value="">Selecione uma empresa</option>
                    <% for (Empresa emp : empresas) { %>
                    <option value="<%= emp.getId() %>" <%= emp.getId().equals(nota.getIdEmpresa()) ? "selected" : "" %>>
                        <%= emp.getNome() %> (CNPJ: <%= emp.getCnpj() %>)
                    </option>
                    <% } %>
                </select>
                <br>
                <a href="../empresaJSP/createEmpresa.jsp" class="hover-link">Criar Empresa</a>
                <br><br>

                <label for="dataEmissao">Data de Emissão:</label><br>
                <input type="date" id="dataEmissao" name="dataEmissao" class="input-redondo"
                       value="<%= nota.getDataEmissao() %>" required><br><br>

                <label for="numeroNota">Número da Nota:</label><br>
                <input type="text" id="numeroNota" name="numeroNota" class="input-redondo"
                       value="<%= nota.getNumeroNota() %>" required placeholder="Ex: NF-2025-001"><br><br>

                <label for="xmlString">Conteúdo XML:</label><br>
                <textarea id="xmlString" name="xmlString" class="input-redondo" rows="6" required
                          placeholder="Cole o conteúdo XML aqui"><%= nota.getXmlString() %></textarea><br><br>

                <button type="submit" class="novo">✔</button>
            </form>
        </div>
        <% } else { %>
        <p style="color: red;">Nota Fiscal não encontrada ou ID inválido.</p>
        <% } %>

        <br>
        <a href="<%= request.getContextPath() %>/ServletReadNotaFiscalXml" class="hover-link">Voltar à lista</a><br>
        <a href="<%= request.getContextPath() %>/index.jsp" class="hover-link">Voltar ao início</a>
    </main>
</div>
</body>
</html>
