package com.codcoz.servlet.empresa;

import com.codcoz.dao.EmpresaDAO;
import com.codcoz.model.Empresa;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ServletUpdateEmpresa", value = "/ServletUpdateEmpresa")
public class ServletUpdateEmpresa extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Empresa empresa = new Empresa(
                Integer.parseInt(request.getParameter("id")),
                Integer.parseInt(request.getParameter("idEndereco")),
                request.getParameter("nome"),
                request.getParameter("cnpj"),
                request.getParameter("email")
        );

        EmpresaDAO dao = new EmpresaDAO();
        int status = dao.update(empresa);
        String mensagem;
        switch (status) {
            case 1:
                mensagem = "A atualização de " +empresa.getNome()+ " foi realizada com sucesso.";
                break;
            case 0:
                mensagem = "A atualização de " +empresa.getNome()+ " falhou: erro interno. Entre em contato pelo e-mail contato.codcoz@gmail.com";
                break;
            default:
                mensagem = "A atualização de " +empresa.getNome()+ " falhou: erro desconhecido. Entre em contato pelo e-mail contato.codcoz@gmail.com.";
                break;
        }
        request.setAttribute("mensagem", mensagem);
        List<Empresa> lista = dao.read();

        request.setAttribute("listaEmpresas", lista);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/empresaJSP/readEmpresa.jsp");
        dispatcher.forward(request, response);
    }
}