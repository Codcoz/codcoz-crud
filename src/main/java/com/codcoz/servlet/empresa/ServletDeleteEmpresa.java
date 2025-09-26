package com.codcoz.servlet.empresa;

import com.codcoz.dao.EmpresaDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;
import com.codcoz.model.Empresa;

@WebServlet(name = "ServletDeleteEmpresa", value = "/ServletDeleteEmpresa")
public class ServletDeleteEmpresa extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        EmpresaDAO dao = new EmpresaDAO();
        dao.delete(id);
        List<Empresa> lista = dao.read();

        request.setAttribute("listaEmpresas", lista);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/empresaJSP/readEmpresa.jsp");
        dispatcher.forward(request, response);
    }
}