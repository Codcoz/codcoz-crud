<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="
    com.codcoz.model.Produto,
    com.codcoz.dao.ProdutoDAO,
    com.codcoz.dao.EstoqueDAO,
    com.codcoz.dao.NotaFiscalXmlDAO,
    com.codcoz.dao.EmpresaDAO,
    com.codcoz.model.Estoque,
    com.codcoz.model.NotaFiscalXml,
    com.codcoz.model.Empresa,
    java.util.List
" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    Produto produto = new ProdutoDAO().buscarPorId(id);
    List<Estoque> estoques = new EstoqueDAO().buscarPorEmpresa(produto.getIdEmpresa());
    List<NotaFiscalXml> notas = new NotaFiscalXmlDAO().buscarPorEmpresa(produto.getIdEmpresa());
    Empresa empresa = new EmpresaDAO().buscarPorId(produto.getIdEmpresa());
%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Atualizar Produto</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
</head>
<body>
<div class="container">
    <jsp:include page="./../barraLateral.jsp" />

    <main class="content">
        <header class="topo">
            <h2>Atualizar Produto</h2>
            <img src="<%= request.getContextPath() %>/assets/codcoz_icon.png" alt="Logo" class="logo">
        </header>

        <div class="sub-header">
            <span class="hover-link ativo">Editar Produto</span>
        </div>

        <% if (produto != null) { %>
        <div class="actions">
            <form action="<%= request.getContextPath() %>/ServletUpdateProduto" method="post" style="max-width: 500px;">
                <input type="hidden" name="id" value="<%= produto.getId() %>"/>
                <input type="hidden" name="idEmpresa" value="<%= produto.getIdEmpresa() %>"/>

                <p><strong>Empresa:</strong> <%= empresa.getNome() %></p>

                <label for="idEstoque">Estoque:</label><br>
                <select id="idEstoque" name="idEstoque" class="select-redondo" required>
                    <option value="">Selecione um estoque</option>
                    <% for (Estoque e : estoques) { %>
                    <option value="<%= e.getId() %>" <%= e.getId().equals(produto.getIdEstoque()) ? "selected" : "" %>>
                        <%= e.getTipoEstoque() %>
                    </option>
                    <% } %>
                </select>
                <br>
                <a href="../estoqueJSP/createEstoque.jsp" class="hover-link">Criar Estoque</a>
                <br><br>

                <label for="idNotaFiscal">Nota Fiscal XML:</label><br>
                <select id="idNotaFiscal" name="idNotaFiscal" class="select-redondo" required>
                    <option value="">Selecione uma nota fiscal</option>
                    <% for (NotaFiscalXml n : notas) { %>
                    <option value="<%= n.getId() %>" <%= n.getId().equals(produto.getIdNotaFiscal()) ? "selected" : "" %>>
                        <%= n.getNumeroNota() %>
                    </option>
                    <% } %>
                </select>
                <br>
                <a href="../notaFiscalXmlJSP/createNotaFiscalXml.jsp" class="hover-link">Criar Nota Fiscal XML</a>
                <br><br>

                <label for="unidadeMedida">Unidade de medida:</label><br>
                <select id="unidadeMedida" name="unidadeMedida" class="select-redondo" required>
                    <option value="">Selecione</option>
                    <option value="kg" <%= "kg".equals(produto.getUnidadeMedida()) ? "selected" : "" %>>Kg</option>
                    <option value="g" <%= "g".equals(produto.getUnidadeMedida()) ? "selected" : "" %>>g</option>
                    <option value="L" <%= "L".equals(produto.getUnidadeMedida()) ? "selected" : "" %>>L</option>
                    <option value="ml" <%= "ml".equals(produto.getUnidadeMedida()) ? "selected" : "" %>>ml</option>
                    <option value="unidade" <%= "unidade".equals(produto.getUnidadeMedida()) ? "selected" : "" %>>Unidade</option>
                    <option value="caixa" <%= "caixa".equals(produto.getUnidadeMedida()) ? "selected" : "" %>>Caixa</option>
                </select><br><br>

                <label for="nome">Nome do Produto:</label><br>
                <input type="text" id="nome" name="nome" class="input-redondo"
                       value="<%= produto.getNome() %>" required placeholder="Ex: Arroz Integral"><br><br>

                <label for="estoqueMinimo">Estoque Mínimo:</label><br>
                <input type="number" id="estoqueMinimo" name="estoqueMinimo" class="input-redondo"
                       value="<%= produto.getEstoqueMinimo() %>" required><br><br>

                <label for="categoria">Categoria:</label><br>
                <input type="text" id="categoria" name="categoria" class="input-redondo"
                       value="<%= produto.getCategoria() %>" required><br><br>

                <label for="quantidade">Quantidade:</label><br>
                <input type="number" id="quantidade" name="quantidade" class="input-redondo"
                       value="<%= produto.getQuantidade() %>" required><br><br>

                <button type="submit" class="novo">✔</button>
            </form>
        </div>
        <% } else { %>
        <p style="color: red;">Produto não encontrado.</p>
        <% } %>

        <br>
        <a href="<%= request.getContextPath() %>/ServletReadProduto" class="hover-link">Voltar à lista de produtos</a><br>
        <a href="<%= request.getContextPath() %>/index.jsp" class="hover-link">Voltar ao início</a>
    </main>
</div>
</body>
</html>
