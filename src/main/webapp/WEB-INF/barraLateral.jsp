<%--
  Created by IntelliJ IDEA.
  User: fbbor
  Date: 11/10/2025
  Time: 13:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div style="padding: 0.5%; justify-content: center; display: flex; align-items: center">
<aside class="sidebar">
    <div class="perfil">
        <img src="<%= request.getContextPath() %>/assets/user_icon.png" alt="Perfil" class="perfil-img">
        <p class="perfil-nome"><%=request.getSession().getAttribute("nomeAdm")%></p>
    </div>

        <nav class="menu">
            <a href="<%= request.getContextPath() %>/ServletReadEndereco">Endereços</a>
            <a href="<%= request.getContextPath() %>/ServletReadEmpresa">Empresas</a>
            <a href="<%= request.getContextPath() %>/ServletReadFuncionario">Funcionário</a>
            <a href="<%= request.getContextPath() %>/ServletReadEstoque">Estoques</a>
            <a href="<%= request.getContextPath() %>/ServletReadNotaFiscalXml">Notas Fiscais XML</a>
            <a href="<%= request.getContextPath() %>/ServletReadProduto">Produtos</a>
            <a href="<%= request.getContextPath() %>/ServletReadAlerta">Alerta</a>
        </nav>

    <button class="logout">
        <img src="<%= request.getContextPath() %>/assets/exit_icon.png" alt=""> Sair
    </button>
</aside>
</div>
