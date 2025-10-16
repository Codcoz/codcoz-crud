<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="
    java.util.List,
    com.codcoz.dao.EmpresaDAO,
    com.codcoz.model.Empresa,
    com.codcoz.model.NotaFiscalXml,
    com.codcoz.dao.NotaFiscalXmlDAO,
    com.codcoz.model.Estoque,
    com.codcoz.dao.EstoqueDAO
" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Criar Produto</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
</head>
<body>
<div class="container">


        <jsp:include page="./../barraLateral.jsp" />
    <main class="content">
        <header class="topo">
            <h2>Criar Produto</h2>
            <img src="<%= request.getContextPath() %>/assets/codcoz_icon.png" alt="Logo" class="logo">
        </header>

        <div class="sub-header">
            <span class="hover-link ativo">Novo Produto</span>
        </div>

        <%
            int idEmpresa = Integer.parseInt(request.getParameter("idEmpresa"));
            Empresa empresa = new EmpresaDAO().buscarPorId(idEmpresa);
            List<Estoque> estoques = new EstoqueDAO().buscarPorEmpresa(idEmpresa);
            List<NotaFiscalXml> notaFiscalXmls = new NotaFiscalXmlDAO().buscarPorEmpresa(idEmpresa);
        %>

        <div class="actions">
            <form action="<%= request.getContextPath() %>/ServletCreateProduto" method="post" style="max-width: 500px;">
                <input type="hidden" name="idEmpresa" value="<%= idEmpresa %>">
                <p><strong>Empresa do Produto:</strong> <%= empresa.getNome() %></p>

                <label for="idEstoque">Estoque:</label><br>
                <select id="idEstoque" name="idEstoque" class="select-redondo" required>
                    <option value="">Selecione um estoque</option>
                    <% for (Estoque e : estoques) { %>
                    <option value="<%= e.getId() %>"><%= e.getTipoEstoque() %></option>
                    <% } %>
                </select>
                <br>
                <a href="../estoqueJSP/createEstoque.jsp" class="hover-link">Criar Estoque</a>
                <br><br>

                <label for="idNotaFiscal">Nota Fiscal XML:</label><br>
                <select id="idNotaFiscal" name="idNotaFiscal" class="select-redondo" required>
                    <option value="">Selecione uma nota fiscal</option>
                    <% for (NotaFiscalXml n : notaFiscalXmls) { %>
                    <option value="<%= n.getId() %>"><%= n.getNumeroNota() %></option>
                    <% } %>
                </select>
                <br>
                <a href="../notaFiscalXmlJSP/createNotaFiscalXml.jsp" class="hover-link">Criar Nota Fiscal XML</a>
                <br><br>

                <label for="unidadeMedida">Unidade de medida:</label><br>
                <select id="unidadeMedida" name="unidadeMedida" class="select-redondo" required>
                    <option value="">Selecione</option>
                    <option value="kg">Kg</option>
                    <option value="g">g</option>
                    <option value="L">L</option>
                    <option value="ml">ml</option>
                    <option value="unidade">Unidade</option>
                    <option value="caixa">Caixa</option>
                </select><br><br>

                <label for="nome">Nome do Produto:</label><br>
                <input type="text" id="nome" name="nome" class="input-redondo" placeholder="Ex: Carne" required><br><br>

                <label for="estoqueMinimo">Estoque Mínimo:</label><br>
                <input type="number" step="1" id="estoqueMinimo" name="estoqueMinimo" class="input-redondo" placeholder="Ex: 1" required><br><br>

                <label for="categoria">Categoria:</label><br>
                <input type="text" id="categoria" name="categoria" class="input-redondo" placeholder="Ex: Frios" required><br><br>

                <label for="quantidade">Quantidade:</label><br>
                <input type="number" step="1" id="quantidade" name="quantidade" class="input-redondo" placeholder="Ex: 1" required><br><br>

                <button type="submit" class="novo">+</button>
            </form>
        </div>

        <br>
        <a href="<%= request.getContextPath() %>/ServletReadProduto" class="hover-link">Voltar à lista de produtos</a><br>
        <a href="<%= request.getContextPath() %>/index.jsp" class="hover-link">Voltar ao início</a>
    </main>
</div>
</body>
</html>
