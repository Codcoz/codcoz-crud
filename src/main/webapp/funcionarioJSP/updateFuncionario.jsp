<%@ page import="com.codcoz.model.Funcionario" %>
<%@ page import="com.codcoz.dao.FuncionarioDAO" %>
<%@ page import="com.codcoz.model.Empresa" %>
<%@ page import="com.codcoz.dao.EmpresaDAO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Recupera o parâmetro id com segurança
    String idParam = request.getParameter("id");
    Integer id = null;
    if (idParam != null && !idParam.trim().isEmpty()) {
        try {
            id = Integer.parseInt(idParam.trim());
        } catch (NumberFormatException e) {
            id = null;
        }
    }

    Funcionario funcionario = null;
    List<Empresa> empresas = null; // será usado no select (opcional)

    if (id != null) {
        FuncionarioDAO fdao = new FuncionarioDAO();
        funcionario = fdao.buscarPorId(id);
    }

    // tenta carregar empresas apenas se existir EmpresaDAO/import disponível.
    try {
        empresas = new EmpresaDAO().read();
    } catch (Throwable t) {
        // se não tiver EmpresaDAO, ignora — o select será omitido
        empresas = null;
    }
%>

<html>
<head>
    <meta charset="UTF-8">
    <title>Atualizar Funcionário</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; }
        label { display:block; margin-top:10px; }
        input[type="text"], input[type="number"], select { width: 100%; padding:6px; box-sizing: border-box; }
        .actions { margin-top: 12px; }
    </style>
</head>
<body>
<% if (funcionario != null) { %>
<h2>Atualizar Funcionário - ID <%= funcionario.getId() %></h2>

<form action="<%=request.getContextPath()%>/ServletUpdateFuncionario" method="post" accept-charset="UTF-8">
    <input type="hidden" name="id" value="<%= funcionario.getId() %>"/>

    <% if (empresas != null) { %>
    <label for="idEmpresa">Empresa:</label>
    <select id="idEmpresa" name="idEmpresa" required>
        <option value="">Selecione uma empresa</option>
        <% for (Empresa e : empresas) { %>
        <option value="<%= e.getId() %>" <%= (funcionario.getIdEmpresa()!=null && e.getId().equals(funcionario.getIdEmpresa())) ? "selected" : "" %> >
            <%= e.getNome() %> (ID: <%= e.getId() %>)
        </option>
        <% } %>
    </select>
    <% } else { %>
    <label for="idEmpresa">ID Empresa:</label>
    <input type="number" id="idEmpresa" name="idEmpresa" value="<%= funcionario.getIdEmpresa() != null ? funcionario.getIdEmpresa() : "" %>" required />
    <% } %>

    <label for="funcao">Função (código ou descrição):</label>
    <input type="text" id="funcao" name="funcao" value="<%= funcionario.getFuncao() != null ? funcionario.getFuncao() : "" %>" required />

    <label for="nome">Nome:</label>
    <input type="text" id="nome" name="nome" value="<%= funcionario.getNome() != null ? funcionario.getNome() : "" %>" required />

    <label for="sobrenome">Sobrenome:</label>
    <input type="text" id="sobrenome" name="sobrenome" value="<%= funcionario.getSobrenome() != null ? funcionario.getSobrenome() : "" %>" />

    <label for="cpf">CPF:</label>
    <input type="text" id="cpf" name="cpf" value="<%= funcionario.getCpf() != null ? funcionario.getCpf() : "" %>" />

    <div class="actions">
        <button type="submit">Salvar</button>
        <a href="<%=request.getContextPath()%>/ServletReadFuncionario">Cancelar</a>
    </div>
</form>

<% } else if (idParam != null) { %>
<p>Funcionário não encontrado para o id informado.</p>
<a href="<%=request.getContextPath()%>/ServletReadFuncionario">Voltar à lista</a>
<% } else { %>
<p>ID do funcionário não informado.</p>
<a href="<%=request.getContextPath()%>/ServletReadFuncionario">Voltar à lista</a>
<% } %>

<br><br>
<a href="<%=request.getContextPath()%>/index.html">Voltar ao início</a>
</body>
</html>
