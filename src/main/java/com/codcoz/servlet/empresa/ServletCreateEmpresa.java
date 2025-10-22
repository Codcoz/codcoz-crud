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
        String cnpjOriginal = request.getParameter("cnpj");
        String cnpj = cnpjOriginal.replaceAll("\\D", "");

        Empresa empresa = new Empresa(
                Integer.parseInt(request.getParameter("idEndereco")),
                request.getParameter("nome"),
                cnpj,
                request.getParameter("email")
        );

        EmpresaDAO dao = new EmpresaDAO();
        String mensagem;
        int status= dao.create(empresa);
        switch (status){
            case 1:
                mensagem = "A criação de " + empresa.getNome() + " foi realizada com sucesso";
                break;
            case 0:
                mensagem = "A criaçao de " + empresa.getNome() + " falhou, esse cnpj ja foi vinculado";
                break;
            case -1:
                mensagem = "A criaçao de " + empresa.getNome() + " falhou, esse email ja foi vinculado";
                break;
            case -2:
               mensagem = "A criação falhou: erro desconhecido. Entre em contato em contato.codcoz@gmail.com";
               break;
            default:
                mensagem = "A criação falhou: erro interno. Entre em contato em contato.codcoz@gmail.com";
        }

        request.setAttribute("mensagem", mensagem);
        List<Empresa> lista = dao.read();
        request.setAttribute("listaEmpresas", lista);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/empresaJSP/readEmpresa.jsp");
        dispatcher.forward(request, response);
    }
}
