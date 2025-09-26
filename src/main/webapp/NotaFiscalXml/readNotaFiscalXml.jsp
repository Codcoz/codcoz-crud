<%--
  Created by IntelliJ IDEA.
  User: guilhermebrandao-ieg
  Date: 26/09/2025
  Time: 13:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.codcoz.model.NotaFiscalXml" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<form action="createNotaFiscalXml.jsp" method="post">
    <button type="submit">Create</button>
</form>

<table border="1">
    <tr>
        <th>ID</th>
        <th>ID Empresa</th>
        <th>Data Emissão</th>
        <th>XML String</th>
        <th>Número Nota</th>
        <th>Update</th>
        <th>Delete</th>
    </tr>

    <%
        List<NotaFiscalXml> lista = (List<NotaFiscalXml>) request.getAttribute("listaNotas");
        if (lista != null && lista.size() > 0) {
            for (NotaFiscalXml nota : lista) {
    %>
    <tr>
        <td><%= nota.getId() %></td>
        <td><%= nota.getIdEmpresa() %></td>
        <td><%= nota.getDataEmissao() %></td>
        <td><%= nota.getXmlString() %></td>
        <td><%= nota.getNumeroNota() %></td>

        <!-- Botão de Update -->
        <td>
            <form action="updateNotaFiscalXml.jsp" method="get">
                <input type="hidden" name="id" value="<%= nota.getId() %>"/>
                <button type="submit">Update</button>
            </form>
        </td>

        <!-- Botão de Delete -->
        <td>
            <form action="ServletDeleteNotaFiscalXml" method="post">
                <input type="hidden" name="id" value="<%= nota.getId() %>"/>
                <input type="submit" value="Delete" />
            </form>
        </td>
    </tr>
    <%
        }
    } else {
    %>
    <tr><td colspan="7">Nenhuma Nota Fiscal encontrada.</td></tr>
    <%
        }
    %>
</table>
