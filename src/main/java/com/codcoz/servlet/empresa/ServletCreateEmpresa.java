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
        Empresa empresa = new Empresa(
                Integer.parseInt(request.getParameter("idEndereco")),
                request.getParameter("nome"),
                request.getParameter("cnpj"),
                request.getParameter("email")
        );

        EmpresaDAO dao = new EmpresaDAO();
        String mensagem;
        if (dao.create(empresa)){
            mensagem = "A criação de " + empresa.getNome() + " foi realizada com sucesso";
        }else {
            mensagem = "A criação falhou: erro interno. Entre em contato em contato.codcoz@gmail.com";
        }
        request.setAttribute("mensagem", mensagem);
        List<Empresa> lista = dao.read();

        request.setAttribute("listaEmpresas", lista);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/empresaJSP/readEmpresa.jsp");
        dispatcher.forward(request, response);
    }
}