<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="
    com.codcoz.dao.NotaFiscalXmlDAO,
    com.codcoz.dao.EmpresaDAO,
    com.codcoz.model.NotaFiscalXml,
    com.codcoz.model.Empresa,
    java.util.List
" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Lista de Notas Fiscais XML</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
</head>
<body>
<div class="container">

    <jsp:include page="./../barraLateral.jsp" />

    <main class="content">
        <header class="topo">
            <h2>Lista de Notas Fiscais XML</h2>
            <img src="<%= request.getContextPath() %>/assets/codcoz_icon.png" alt="Logo" class="logo">
        </header>

        <div class="sub-header">
            <span class="hover-link ativo">Notas Fiscais XML</span>
        </div>

        <div class="actions">
            <form action="<%= request.getContextPath() %>/notaFiscalXmlJSP/createNotaFiscalXml.jsp" method="post">
                <button type="submit" class="novo">+</button>
            </form>
        </div>

        <% String mensagem = (String) request.getAttribute("mensagem");
            if (mensagem != null) {
                String cor = mensagem.toLowerCase().contains("sucesso") ? "green" : "red"; %>
        <p style="color: <%= cor %>"><%= mensagem %></p>
        <% } %>

        <div class="tabela-container">
            <table>
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Empresa</th>
                    <th>Data de Emissão</th>
                    <th>Número da Nota</th>
                    <th>Update</th>
                    <th>Delete</th>
                </tr>
                </thead>
                <tbody>
                <%
                    NotaFiscalXmlDAO notaDao = new NotaFiscalXmlDAO();
                    List<NotaFiscalXml> notas = notaDao.read();
                    EmpresaDAO empresaDAO = new EmpresaDAO();

                    if (notas != null && !notas.isEmpty()) {
                        for (NotaFiscalXml nota : notas) {
                            Empresa empresa = empresaDAO.buscarPorId(nota.getIdEmpresa());
                %>
                <tr>
                    <td><%= nota.getId() %></td>
                    <td><%= empresa != null ? empresa.getNome() : "Desconhecida" %></td>
                    <td><%= nota.getDataEmissao() %></td>
                    <td><%= nota.getNumeroNota() %></td>
                    <td class="acoes">
                        <a href="<%= request.getContextPath() %>/notaFiscalXmlJSP/updateNotaFiscalXml.jsp?id=<%= nota.getId() %>">
                            <img src="<%= request.getContextPath() %>/assets/edit_icon.png" alt="Editar">
                        </a>
                    </td>
                    <td class="acoes">
                        <a href="<%= request.getContextPath() %>/ServletDeleteNotaFiscalXml?id=<%= nota.getId() %>"
                           onclick="return confirm('Tem certeza que deseja excluir esta nota fiscal?');">
                            <img src="<%= request.getContextPath() %>/assets/delete_icon.png" alt="Excluir">
                        </a>
                    </td>
                </tr>
                <%     }
                } else { %>
                <tr>
                    <td colspan="6">Nenhuma nota fiscal encontrada.</td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>

        <br>
        <a href="<%= request.getContextPath() %>/index.JSP" class="hover-link">Voltar ao início</a>
    </main>
</div>
</body>
</html>
