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
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
</head>
<body>
<div class="container">

    <jsp:include page="./../barraLateral.jsp" />

    <main class="content">
        <header class="topo">
            <h2>Lista de Produtos</h2>
            <img src="<%= request.getContextPath() %>/assets/codcoz_icon.png" alt="Logo" class="logo">
        </header>

        <div class="sub-header">
            <span class="hover-link ativo">Produtos</span>
        </div>

        <div class="actions">
            <form action="<%= request.getContextPath() %>/produtoJSP/escolhaEmpresaDoProduto.jsp" method="get">
                <button type="submit" class="novo">+</button>
            </form>
        </div>

        <% String mensagem = (String) request.getAttribute("mensagem");
            if (mensagem != null) {
                String cor = mensagem.contains("sucesso") ? "green" : "red"; %>
        <p style="color: <%= cor %>"><%= mensagem %></p>
        <% } %>

        <div class="tabela-container">
            <table>
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Nome</th>
                    <th>Categoria</th>
                    <th>Unidade</th>
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
                <td><%= produto.getId() %></td>
                <td><%= produto.getNome() %></td>
                <td><%= produto.getCategoria() %></td>
                <td><%= produto.getUnidadeMedida() %></td>
                <td><%= produto.getEstoqueMinimo() %></td>
                <td><%= produto.getQuantidade() %></td>
                <td><%= estoque != null ? estoque.getTipoEstoque() : "N/A" %></td>
                <td><%= nota != null ? nota.getNumeroNota() : "N/A" %></td>
                <td><%= empresa != null ? empresa.getNome() : "Desconhecida" %></td>
                <td class="acoes">
                    <a href="<%= request.getContextPath() %>/produtoJSP/updateEmpresaDoProduto.jsp?id=<%= produto.getId() %>">
                        <img src="<%= request.getContextPath() %>/assets/edit_icon.png" alt="Editar">
                    </a>
                </td>
                <td class="acoes">
                    <form action="<%= request.getContextPath() %>/ServletDeleteProduto" method="get">
                        <input type="hidden" name="id" value="<%= produto.getId() %>"/>
                        <button type="submit" class="icon-button">

                    if (lista != null && !lista.isEmpty()) {
                        for (Produto produto : lista) {
                            Estoque estoque = estoqueDAO.buscarPorId(produto.getIdEstoque());
                            NotaFiscalXml nota = notaDAO.buscarPorId(produto.getIdNotaFiscal());
                            Empresa empresa = empresaDAO.buscarPorId(produto.getIdEmpresa());
                %>
                <tr>
                    <td><%= produto.getId() %></td>
                    <td><%= produto.getNome() %></td>
                    <td><%= produto.getCategoria() %></td>
                    <td><%= produto.getUnidadeMedida() %></td>
                    <td><%= produto.getEstoqueMinimo() %></td>
                    <td><%= produto.getQuantidade() %></td>
                    <td><%= estoque != null ? estoque.getTipoEstoque() : "N/A" %></td>
                    <td><%= nota != null ? nota.getNumeroNota() : "N/A" %></td>
                    <td><%= empresa != null ? empresa.getNome() : "Desconhecida" %></td>
                    <td class="acoes">
                        <a href="<%= request.getContextPath() %>/produtoJSP/updateEmpresaDoProduto.jsp?id=<%= produto.getId() %>">
                            <img src="<%= request.getContextPath() %>/assets/edit_icon.png" alt="Editar">
                        </a>
                    </td>
                    <td class="acoes">
                        <a href="<%= request.getContextPath() %>/ServletDeleteProduto?id=<%= produto.getId() %>"
                           onclick="return confirm('Tem certeza que deseja excluir <%=produto.getNome()%>?');">

                            <img src="<%= request.getContextPath() %>/assets/delete_icon.png" alt="Excluir">
                        </a>
                    </td>
                </tr>
                <%   }
                } else { %>
                <tr>
                    <td colspan="11">Nenhum produto encontrado.</td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>

        <br>
        <a href="<%= request.getContextPath() %>/index.jsp" class="hover-link">Voltar ao início</a>
    </main>
</div>
</body>
</html>