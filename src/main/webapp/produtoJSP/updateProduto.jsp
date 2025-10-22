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
    Integer id = null;
    try {
        id = Integer.parseInt(request.getParameter("id"));
    } catch (Exception e) {}

    Produto produto = null;
    List<Estoque> estoques = null;
    List<NotaFiscalXml> notas = null;
    Empresa empresa = null;

    if (id != null) {
        produto = new ProdutoDAO().buscarPorId(id);
        if (produto != null) {
            estoques = new EstoqueDAO().buscarPorEmpresa(produto.getIdEmpresa());
            notas = new NotaFiscalXmlDAO().buscarPorEmpresa(produto.getIdEmpresa());
            empresa = new EmpresaDAO().buscarPorId(produto.getIdEmpresa());
        }
    }
%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Atualizar Produto</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/icone.png">
</head>
<body>
<div class="container">
    <jsp:include page="./../barraLateral.jsp" />

    <main class="content" style="overflow: auto">
        <header class="topo">
            <h2>Atualizar Produto</h2>
            <img src="<%= request.getContextPath() %>/assets/codcoz_icon.png" alt="Logo" class="logo" title="Logo Codcoz">
        </header>

        <div class="sub-header">
            <span class="hover-link ativo" title="Edite os dados do produto selecionado">Editar Produto</span>
        </div>

        <% if (produto != null) { %>
        <div class="actions" style="margin-top: 30px;">
            <form action="<%= request.getContextPath() %>/ServletUpdateProduto" method="post" style="max-width: 500px; width: 100%;">
                <input type="hidden" name="id" value="<%= produto.getId() %>"/>
                <input type="hidden" name="idEmpresa" value="<%= produto.getIdEmpresa() %>"/>

                <p><strong>Empresa:</strong> <%= empresa.getNome() %></p>

                <label for="idEstoque">Estoque:</label><br>
                <select id="idEstoque" name="idEstoque" class="select-redondo" required title="Selecione o estoque associado ao produto">
                    <option value="">Selecione um estoque</option>
                    <% for (Estoque e : estoques) { %>
                    <option value="<%= e.getId() %>" <%= e.getId().equals(produto.getIdEstoque()) ? "selected" : "" %>>
                        <%= e.getTipoEstoque() %>
                    </option>
                    <% } %>
                </select>
                <br>
                <a href="../estoqueJSP/createEstoque.jsp" class="hover-link" title="Cadastrar novo estoque">Criar Estoque</a>
                <br><br>

                <label for="idNotaFiscal">Nota Fiscal XML:</label><br>
                <select id="idNotaFiscal" name="idNotaFiscal" class="select-redondo" required title="Selecione a nota fiscal associada ao produto">
                    <option value="">Selecione uma nota fiscal</option>
                    <% for (NotaFiscalXml n : notas) { %>
                    <option value="<%= n.getId() %>" <%= n.getId().equals(produto.getIdNotaFiscal()) ? "selected" : "" %>>
                        <%= n.getNumeroNota() %>
                    </option>
                    <% } %>
                </select>
                <br>
                <a href="../notaFiscalXmlJSP/createNotaFiscalXml.jsp" class="hover-link" title="Cadastrar nova nota fiscal">Criar Nota Fiscal XML</a>
                <br><br>

                <label for="unidadeMedida">Unidade de Medida:</label><br>
                <select id="unidadeMedida" name="unidadeMedida" class="select-redondo" required title="Selecione a unidade de medida">
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
                       value="<%= produto.getNome() %>" required
                       placeholder="Ex: Arroz Integral" title="Informe o nome do produto"><br><br>

                <label for="estoqueMinimo">Estoque Mínimo:</label><br>
                <input type="number" id="estoqueMinimo" name="estoqueMinimo" class="input-redondo"
                       value="<%= produto.getEstoqueMinimo() %>" required
                       title="Informe o estoque mínimo para o produto"><br><br>

                <label for="categoria">Categoria:</label><br>
                <input type="text" id="categoria" name="categoria" class="input-redondo"
                       value="<%= produto.getCategoria() %>" required
                       title="Informe a categoria do produto"><br><br>

                <label for="quantidade">Quantidade:</label><br>
                <input type="number" id="quantidade" name="quantidade" class="input-redondo"
                       value="<%= produto.getQuantidade() %>" required
                       title="Informe a quantidade atual do produto"><br><br>

                <button type="submit" class="novo" title="Salvar alterações">✔</button>
            </form>
        </div>
        <% } else { %>
        <p style="color: red;" title="Erro ao carregar produto">Produto não encontrado ou ID inválido.</p>
        <% } %>

        <br>
        <div style="display: flex; gap: 20px;">
            <a href="<%= request.getContextPath() %>/ServletReadProduto" class="hover-link" title="Ver lista de produtos">Voltar à lista</a>
            <a href="<%= request.getContextPath() %>/index.jsp" class="hover-link" title="Voltar à página inicial">Voltar ao início</a>
        </div>
    </main>
</div>
</body>
</html>
