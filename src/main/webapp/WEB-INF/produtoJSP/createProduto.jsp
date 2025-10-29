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
    <!-- Estilos e fontes -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="icon" type="image/png" href="<%=request.getContextPath() %>/assets/codcoz_icon.png">
</head>
<body>
<div class="container">
    <!-- Inclui a barra lateral -->
    <jsp:include page="../barraLateral.jsp" />

    <main class="content" style="overflow: auto">
        <header class="topo">
            <h2>Criar Produto</h2>
            <img src="<%= request.getContextPath() %>/assets/codcoz_icon.png" alt="Logo" class="logo" title="Logo Codcoz">
        </header>

        <div class="sub-header">
            <span class="hover-link ativo" title="Preencha os dados para cadastrar um novo produto">Novo Produto</span>
        </div>

        <%
            // Recupera dados da empresa e listas de estoques e notas fiscais associadas
            int idEmpresa = Integer.parseInt(request.getParameter("idEmpresa"));
            Empresa empresa = new EmpresaDAO().buscarPorId(idEmpresa);
            List<Estoque> estoques = new EstoqueDAO().buscarPorEmpresa(idEmpresa);
            List<NotaFiscalXml> notaFiscalXmls = new NotaFiscalXmlDAO().buscarPorEmpresa(idEmpresa);
        %>

        <div class="actions" style="margin-top: 30px;">
            <!-- Formulário para criação de produto -->
            <form action="<%= request.getContextPath() %>/ServletCreateProduto" method="post" style="max-width: 500px; width: 100%;">
                <input type="hidden" name="idEmpresa" value="<%= idEmpresa %>">
                <p><strong>Empresa do Produto:</strong> <%= empresa.getNome() %></p>

                <!-- Campo Estoque -->
                <label for="idEstoque">Estoque:</label><br>
                <select id="idEstoque" name="idEstoque" class="select-redondo" required title="Selecione o estoque onde o produto será armazenado">
                    <option value="">Selecione um estoque</option>
                    <% for (Estoque e : estoques) { %>
                    <option value="<%= e.getId() %>"><%= e.getTipoEstoque() %></option>
                    <% } %>
                </select>
                <br>
                <a href="ServletReadEstoque?view=create" class="hover-link" title="Cadastrar novo estoque">Criar Estoque</a>
                <br><br>

                <!-- Campo Nota Fiscal XML -->
                <label for="idNotaFiscal">Nota Fiscal XML:</label><br>
                <select id="idNotaFiscal" name="idNotaFiscal" class="select-redondo" required title="Selecione a nota fiscal associada ao produto">
                    <option value="">Selecione uma nota fiscal</option>
                    <% for (NotaFiscalXml n : notaFiscalXmls) { %>
                    <option value="<%= n.getId() %>"><%= n.getNumeroNota() %></option>
                    <% } %>
                </select>
                <br>
                <a href="ServletReadNotaFiscalXml?view=create" class="hover-link" title="Cadastrar nova nota fiscal">Criar Nota Fiscal XML</a>
                <br><br>

                <!-- Campo Unidade de Medida -->
                <label for="unidadeMedida">Unidade de medida:</label><br>
                <select id="unidadeMedida" name="unidadeMedida" class="select-redondo" required title="Selecione a unidade de medida do produto">
                    <option value="">Selecione</option>
                    <option value="kg">Kg</option>
                    <option value="g">g</option>
                    <option value="L">L</option>
                    <option value="ml">ml</option>
                    <option value="unidade">Unidade</option>
                    <option value="caixa">Caixa</option>
                </select><br><br>

                <!-- Campo Nome do Produto -->
                <label for="nome">Nome do Produto:</label><br>
                <input type="text" id="nome" name="nome" class="input-redondo"
                       placeholder="Ex: Carne" required
                       title="Informe o nome do produto">
                <br><br>

                <label for="codigoEan">Codigo Ean:</label><br>
                <input type="number" step="1" id="codigoEan" name="codigoEan" class="input-redondo"
                       placeholder="Ex: 12345678" maxlength="13"
                       pattern="^.{8}$|^.{13}$"
                       title="Informe o código ean para produto"><br><br>

                <!-- Campo Estoque Mínimo -->
                <label for="estoqueMinimo">Estoque Mínimo:</label><br>
                <input type="number" step="1" id="estoqueMinimo" name="estoqueMinimo" class="input-redondo"
                       placeholder="Ex: 1" required
                       title="Informe o estoque mínimo para produto"><br><br>

                <!-- Campo Categoria -->
                <label for="categoria">Categoria:</label><br>
                <input type="text" id="categoria" name="categoria" class="input-redondo"
                       placeholder="Ex: Frios" required
                       title="Informe a categoria do produto"><br><br>

                <!-- Campo Quantidade -->
                <label for="quantidade">Quantidade:</label><br>
                <input type="number" step="1" id="quantidade" name="quantidade" class="input-redondo"
                       placeholder="Ex: 1" required
                       title="Informe a quantidade atual do produto"><br><br>

                <!-- Botão de envio -->
                <button type="submit" class="novo" title="Salvar novo produto">+</button>
            </form>
        </div>

        <br>
        <!-- Navegação -->
        <div style="display: flex; gap: 20px;">
            <a href="<%= request.getContextPath() %>/ServletReadProduto" class="hover-link" title="Ver lista de produtos">Voltar à lista de produtos</a>
            <a href="<%= request.getContextPath() %>/WEB-INF/index.jsp" class="hover-link" title="Voltar à página inicial">Voltar ao início</a>
        </div>

    </main>
</div>
</body>
</html>
