package com.codcoz.servlet.empresa;

import com.codcoz.dao.EmpresaDAO;
import com.codcoz.model.Empresa;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ServletCreateEmpresa", value = "/ServletCreateEmpresa")
public class ServletCreateEmpresa extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String cnpj = request.getParameter("cnpj");

        // Validação de CNPJ
        if (cnpj == null || !cnpj.matches("^\\d{2}\\.\\d{3}\\.\\d{3}/\\d{4}-\\d{2}$|^\\d{14}$")) {
            request.setAttribute("erroCnpj", "CNPJ inválido. Use o formato 00.000.000/0000-00 ou apenas números.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/empresaJSP/createEmpresa.jsp");
            dispatcher.forward(request, response);
            return;
        }
        Empresa empresa = new Empresa(
                Integer.parseInt(request.getParameter("idEndereco")),
                request.getParameter("nome"),cnpj,
                request.getParameter("email")
        );

        EmpresaDAO dao = new EmpresaDAO();
        dao.create(empresa);
        List<Empresa> lista = dao.read();

        request.setAttribute("listaEmpresas", lista);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/empresaJSP/readEmpresa.jsp");
        dispatcher.forward(request, response);
    }
}