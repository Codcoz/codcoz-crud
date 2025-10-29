package com.codcoz.servlet.empresa;

import com.codcoz.dao.EmpresaDAO;
import com.codcoz.model.Empresa;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ServletReadEmpresa", value = "/ServletReadEmpresa")
public class ServletReadEmpresa extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Consulta todas as empresas no banco
        EmpresaDAO dao = new EmpresaDAO();
        List<Empresa> lista = dao.read();

        // Define a lista como atributo da request
        request.setAttribute("listaEmpresas", lista);

        // Verifica se há uma view específica solicitada
        String view = request.getParameter("view");
        String destino;

        if ("create".equals(view)) {
            destino = "/WEB-INF/empresaJSP/createEmpresa.jsp";
        } else if ("update".equals(view)) {
            destino = "/WEB-INF/empresaJSP/updateEmpresa.jsp";
        } else {
            destino = "/WEB-INF/empresaJSP/readEmpresa.jsp";
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher(destino);
        dispatcher.forward(request, response);
    }
}