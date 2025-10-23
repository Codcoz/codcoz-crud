<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="
    com.codcoz.model.Estoque,
    com.codcoz.model.Empresa,
    com.codcoz.dao.EmpresaDAO,
    java.util.List
" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Lista de Estoques</title>
    <!-- Estilos e fontes -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/icone.png">
    <style>
        .tabela-container {
            flex: 1;
            overflow-y: auto;
            max-height: 60vh;
            margin-top: 20px;
            border: 1px solid #ccc;
            border-radius: 8px;
            background-color: white;
        }
    </style>
</head>
<body>
<div class="container">

    <!-- Inclui a barra lateral -->
    <jsp:include page="./../barraLateral.jsp" />

    <main class="content">
        <header class="topo">
            <h2>Lista de Estoques</h2>
            <img src="<%= request.getContextPath() %>/assets/codcoz_icon.png" alt="Logo" class="logo" title="Logo Codcoz">
        </header>

        <div class="sub-header">
            <span class="hover-link ativo" title="Visualizando todos os estoques cadastrados">Estoques</span>
        </div>

        <div class="actions">
            <!-- Botão para cadastrar novo estoque -->
            <form action="<%= request.getContextPath() %>/estoqueJSP/createEstoque.jsp" method="get">
                <button type="submit" class="novo" title="Cadastrar novo estoque">+</button>
            </form>
            <!-- Filtro por empresa -->
            <form style="display: flex" action="ServletReadEstoque" class="filtro">
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
                String cor = mensagem.toLowerCase().contains("sucesso") ? "green" : "red";
        %>
        <p style="color: <%= cor %>" title="Mensagem do sistema"><%= mensagem %></p>
        <%
            }
        %>

        <div class="tabela-container">
            <table>
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Tipo de Estoque</th>
                    <th>Capacidade</th>
                    <th>Empresa</th>
                    <th>Update</th>
                    <th>Delete</th>
                </tr>
                </thead>
                <tbody>
                <%
                    // Recupera lista de estoques e exibe na tabela
                    List<Estoque> lista = (List<Estoque>) request.getAttribute("listaEstoques");
                    EmpresaDAO empresaDAO = new EmpresaDAO();

                    if (lista != null && !lista.isEmpty()) {
                        for (Estoque estoque : lista) {
                            Empresa empresa = empresaDAO.buscarPorId(estoque.getIdEmpresa());
                %>
                <tr>
                    <td title="ID do estoque"><%= estoque.getId() %></td>
                    <td title="Tipo de armazenamento"><%= estoque.getTipoEstoque() %></td>
                    <td title="Capacidade total"><%= estoque.getCapacidade() %></td>
                    <td title="Empresa associada"><%= empresa != null ? empresa.getNome() : "N/A" %></td>
                    <!-- Link para editar estoque -->
                    <td class="acoes">
                        <a href="<%= request.getContextPath() %>/estoqueJSP/updateEstoque.jsp?id=<%= estoque.getId() %>" title="Editar estoque">
                            <img src="<%= request.getContextPath() %>/assets/edit_icon.png" alt="Editar" title="Editar estoque">
                        </a>
                    </td>
                    <!-- Link para excluir estoque com confirmação -->
                    <td class="acoes">
                        <a href="<%= request.getContextPath() %>/ServletDeleteEstoque?id=<%= estoque.getId() %>"
                           onclick="return confirm('Tem certeza que deseja excluir este estoque?');"
                           title="Excluir estoque">
                            <img src="<%= request.getContextPath() %>/assets/delete_icon.png" alt="Excluir" title="Excluir estoque">
                        </a>
                    </td>
                </tr>
                <%
                    }
                } else {
                %>
                <!-- Caso não haja estoques cadastrados -->
                <tr>
                    <td colspan="6" title="Nenhum estoque foi encontrado">Nenhum estoque encontrado.</td>
                </tr>
                <%
                    }
                %>
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
