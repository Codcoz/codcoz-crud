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
    <!-- Estilos e fontes -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/icone.png">
</head>
<body>
<div class="container">

    <!-- Inclui a barra lateral -->
    <jsp:include page="./../barraLateral.jsp" />

    <main class="content">
        <header class="topo">
            <h2>Lista de Notas Fiscais XML</h2>
            <img src="<%= request.getContextPath() %>/assets/codcoz_icon.png" alt="Logo" class="logo" title="Logo Codcoz">
        </header>

        <div class="sub-header">
            <span class="hover-link ativo" title="Visualizando todas as notas fiscais cadastradas">Notas Fiscais XML</span>
        </div>

        <div style="display: flex" class="actions">
            <!-- Botão para criar nova nota fiscal -->
            <form action="<%= request.getContextPath() %>/notaFiscalXmlJSP/createNotaFiscalXml.jsp" method="post">
                <button type="submit" class="novo" title="Criar nova nota fiscal">+</button>
            </form>
            <!-- Filtro por empresa -->
            <form style="display: flex" action="ServletReadNotaFiscalXml">
                <select class="select-redondo" name="buscarPorEmpresa" id="buscarPorEmpresa">
                    <option selected disabled value="">Selecione uma empresa</option>
                    <%List<Empresa> empresas = new EmpresaDAO().read();
                        for (Empresa empresa: empresas) {%>
                    <option value="<%=empresa.getId()%>"><%=empresa.getNome()%></option>
                    <%}%>
                </select>
                <button type="submit">Filtrar</button>
            </form>
        </div>

        <!-- Exibe mensagem de retorno, se houver -->
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
                    // Recupera lista de notas fiscais e exibe na tabela
                    NotaFiscalXmlDAO notaDao = new NotaFiscalXmlDAO();
                    List<NotaFiscalXml> notas = notaDao.read();
                    EmpresaDAO empresaDAO = new EmpresaDAO();

                    if (notas != null && !notas.isEmpty()) {
                        for (NotaFiscalXml nota : notas) {
                            Empresa empresa = empresaDAO.buscarPorId(nota.getIdEmpresa());
                %>
                <tr>
                    <td title="ID da nota fiscal"><%= nota.getId() %></td>
                    <td title="Empresa emissora"><%= empresa != null ? empresa.getNome() : "Desconhecida" %></td>
                    <td title="Data de emissão da nota"><%= nota.getDataEmissao() %></td>
                    <td title="Número da nota fiscal"><%= nota.getNumeroNota() %></td>
                    <!-- Link para editar nota fiscal -->
                    <td class="acoes">
                        <a href="<%= request.getContextPath() %>/notaFiscalXmlJSP/updateNotaFiscalXml.jsp?id=<%= nota.getId() %>" title="Editar nota fiscal">
                            <img src="<%= request.getContextPath() %>/assets/edit_icon.png" alt="Editar" title="Editar nota fiscal">
                        </a>
                    </td>
                    <!-- Link para excluir nota fiscal com confirmação -->
                    <td class="acoes">
                        <a href="<%= request.getContextPath() %>/ServletDeleteNotaFiscalXml?id=<%= nota.getId() %>"
                           onclick="return confirm('Tem certeza que deseja excluir esta nota fiscal?');"
                           title="Excluir nota fiscal">
                            <img src="<%= request.getContextPath() %>/assets/delete_icon.png" alt="Excluir" title="Excluir nota fiscal">
                        </a>
                    </td>
                </tr>
                <%     }
                } else { %>
                <!-- Caso não haja notas fiscais cadastradas -->
                <tr>
                    <td colspan="6" title="Nenhuma nota fiscal foi encontrada">Nenhuma nota fiscal encontrada.</td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>

        <br>
        <!-- Link para voltar à página inicial -->
        <a href="<%= request.getContextPath() %>/index.jsp" class="hover-link" title="Voltar à página inicial">Voltar ao início</a>
    </main>

</div>
</body>
</html>
