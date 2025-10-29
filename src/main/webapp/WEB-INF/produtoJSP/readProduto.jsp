<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="
    com.codcoz.model.Produto,
    com.codcoz.dao.EstoqueDAO,
    com.codcoz.dao.NotaFiscalXmlDAO,
    com.codcoz.dao.EmpresaDAO,
    com.codcoz.model.Estoque,
    com.codcoz.model.NotaFiscalXml,
    com.codcoz.model.Empresa,
    java.util.List
" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Lista de Produtos</title>
    <!-- Estilos e fontes -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/WEB-INF/assets/icone.png">
</head>
<body>
<div class="container">

    <!-- Inclui a barra lateral -->
    <jsp:include page="../barraLateral.jsp" />

    <main class="content">
        <header class="topo">
            <h2>Lista de Produtos</h2>
            <img src="<%= request.getContextPath() %>/assets/codcoz_icon.png" alt="Logo" class="logo" title="Logo Codcoz">
        </header>

        <div class="sub-header">
            <span class="hover-link ativo" title="Visualizando todos os produtos cadastrados">Produtos</span>
        </div>

        <div style="display: flex" class="actions">
            <!-- Botão para iniciar criação de produto -->
            <form action="<%= request.getContextPath() %>/ServletReadProduto" method="get">
                <button type="submit" class="novo" title="Criar novo produto">+</button>
                <input  type="hidden" name="view" value="escolhaEmpresaCreate">
            </form>
            <!-- Filtro por empresa -->
            <form style="display: flex" action="ServletReadProduto" class="filtro">
                <label for="buscarPorEmpresa">Filtro: </label>
                <select class="select-redondo" name="buscarPorEmpresa" id="buscarPorEmpresa">
                    <option selected disabled value=""><%=request.getAttribute("filtro")!=null ? request.getAttribute("filtro"):"Selecione uma empresa"%></option>
                    <%List<Empresa> empresas = new EmpresaDAO().read();
                        for (Empresa empresa: empresas) {%>
                    <option value="<%=empresa.getId()%>"><%=empresa.getNome()%></option>
                    <%}%>
                </select>
                <button type="submit">Filtrar</button>
            </form>
        </div>

        <!-- Exibe mensagem de retorno, se houver -->
        <%
            String mensagem = (String) request.getAttribute("mensagem");
            if (mensagem != null) {
                String cor = mensagem.contains("sucesso") ? "green" : "red";
        %>
        <p style="color: <%= cor %>" title="Mensagem do sistema"><%= mensagem %></p>
        <% } %>

        <div class="tabela-container">
            <table>
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Nome</th>
                    <th>Categoria</th>
                    <th>Unidade</th>
                    <th>Codigo Ean</th>
                    <th>Estoque Mínimo</th>
                    <th>Quantidade</th>
                    <th>Estoque</th>
                    <th>Nota Fiscal</th>
                    <th>Empresa</th>
                    <th>Update</th>
                    <th>Delete</th>
                </tr>
                </thead>
                <tbody>
                <%
                    // Recupera lista de produtos e exibe na tabela
                    List<Produto> lista = (List<Produto>) request.getAttribute("listaProdutos");
                    EstoqueDAO estoqueDAO = new EstoqueDAO();
                    NotaFiscalXmlDAO notaDAO = new NotaFiscalXmlDAO();
                    EmpresaDAO empresaDAO = new EmpresaDAO();

                    if (lista != null && !lista.isEmpty()) {
                        for (Produto produto : lista) {
                            Estoque estoque = estoqueDAO.buscarPorId(produto.getIdEstoque());
                            NotaFiscalXml nota = notaDAO.buscarPorId(produto.getIdNotaFiscal());
                            Empresa empresa = empresaDAO.buscarPorId(produto.getIdEmpresa());
                %>
                <tr>
                    <td title="ID do produto"><%= produto.getId() %></td>
                    <td title="Nome do produto"><%= produto.getNome() %></td>
                    <td title="Categoria do produto"><%= produto.getCategoria() %></td>
                    <td title="Unidade de medida"><%= produto.getUnidadeMedida() %></td>
                    <td title="Codigo Ean"><%= produto.getCodigoEan() %></td>
                    <td title="Estoque mínimo definido"><%= produto.getEstoqueMinimo() %></td>
                    <td title="Quantidade atual"><%= produto.getQuantidade() %></td>
                    <td title="Tipo de estoque"><%= estoque != null ? estoque.getTipoEstoque() : "N/A" %></td>
                    <td title="Número da nota fiscal"><%= nota != null ? nota.getNumeroNota() : "N/A" %></td>
                    <td title="Empresa associada"><%= empresa != null ? empresa.getNome() : "Desconhecida" %></td>
                    <!-- Link para editar produto -->
                    <td class="acoes">
                        <a href="<%= request.getContextPath() %>/ServletReadProduto?view=escolhaEmpresaUpdate&id=<%= produto.getId() %>" title="Editar produto">
                            <img src="<%= request.getContextPath() %>/assets/edit_icon.png" alt="Editar" title="Editar produto">
                        </a>
                    </td>
                    <!-- Link para excluir produto com confirmação -->
                    <td class="acoes">
                        <a href="<%= request.getContextPath() %>/ServletDeleteProduto?id=<%= produto.getId() %>" method="post"
                           onclick="return confirm('Tem certeza que deseja excluir <%= produto.getNome() %>?');"
                           title="Excluir produto">
                            <img src="<%= request.getContextPath() %>/assets/delete_icon.png" alt="Excluir" title="Excluir produto">
                        </a>
                    </td>
                </tr>
                <%
                    }
                } else {
                %>
                <!-- Caso não haja produtos cadastrados -->
                <tr>
                    <td colspan="11" title="Nenhum produto foi encontrado">Nenhum produto encontrado.</td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>

        <br>
        <!-- Link para voltar à página inicial -->
        <a href="<%= request.getContextPath() %>/WEB-INF/index.jsp" class="hover-link" title="Voltar à página inicial">Voltar ao início</a>
    </main>

</div>
</body>
</html>
