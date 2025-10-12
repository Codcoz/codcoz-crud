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
</head>
<body>
<div class="container">

    <main class="content">
        <header class="topo">
            <h2>Criar Produto</h2>
            <img src="<%= request.getContextPath() %>/assets/codcoz_icon.png" alt="Logo" class="logo">
        </header>

        <%
            int idEmpresa = Integer.parseInt(request.getParameter("idEmpresa"));
            Empresa empresa = new EmpresaDAO().buscarPorId(idEmpresa);
            List<Estoque> estoques = new EstoqueDAO().buscarPorEmpresa(idEmpresa);
            List<NotaFiscalXml> notaFiscalXmls = new NotaFiscalXmlDAO().buscarPorEmpresa(idEmpresa);
        %>

        <form action="<%= request.getContextPath() %>/ServletCreateProduto" method="post">
            <input type="hidden" name="idEmpresa" value="<%= idEmpresa %>">
            <p>Empresa do Produto: <strong><%= empresa.getNome() %></strong></p>

            <label for="idEstoque">Estoque:</label>
            <select id="idEstoque" name="idEstoque" required>
                <option value="">Selecione um estoque</option>
                <% for (Estoque e : estoques) { %>
                <option value="<%= e.getId() %>"><%= e.getTipoEstoque() %></option>
                <% } %>
            </select>
            <a href="../estoqueJSP/createEstoque.jsp">Criar Estoque</a>
            <br><br>

            <label for="idNotaFiscal">Nota Fiscal XML:</label>
            <select id="idNotaFiscal" name="idNotaFiscal" required>
                <option value="">Selecione uma nota fiscal</option>
                <% for (NotaFiscalXml n : notaFiscalXmls) { %>
                <option value="<%= n.getId() %>"><%= n.getNumeroNota() %></option>
                <% } %>
            </select>
            <a href="../notaFiscalXmlJSP/createNotaFiscalXml.jsp">Criar Nota Fiscal XML</a>
            <br><br>

            <label for="unidadeMedida">Unidade de medida:</label>
            <select id="unidadeMedida" name="unidadeMedida" required>
                <option value="">Selecione</option>
                <option value="kg">Kg</option>
                <option value="g">g</option>
                <option value="L">L</option>
                <option value="ml">ml</option>
                <option value="unidade">Unidade</option>
                <option value="caixa">Caixa</option>
            </select>
            <br><br>

            <label for="nome">Nome do Produto:</label>
            <input type="text" id="nome" name="nome" placeholder="Ex: Carne" required>
            <br><br>

            <label for="estoqueMinimo">Estoque Mínimo:</label>
            <input type="number" step="1" id="estoqueMinimo" name="estoqueMinimo" placeholder="Ex: 1" required>
            <br><br>

            <label for="categoria">Categoria:</label>
            <input type="text" id="categoria" name="categoria" placeholder="Ex: Frios" required>
            <br><br>

            <label for="quantidade">Quantidade:</label>
            <input type="number" step="1" id="quantidade" name="quantidade" placeholder="Ex: 1" required>
            <br><br>

            <button type="submit">Criar Produto</button>
        </form>

        <br>
        <a href="<%= request.getContextPath() %>/ServletReadProduto" class="hover-link">Voltar à lista de produtos</a><br><br>
        <a href="<%= request.getContextPath() %>/index.html" class="hover-link">Voltar ao início</a>
    </main>
</div>
</body>
</html>