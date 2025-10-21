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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String cnpjOriginal = request.getParameter("cnpj");
        String cnpj = cnpjOriginal.replaceAll("\\D", "");

        String email = request.getParameter("email");
        String emailRegex = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.(com|net|org|gov|edu|info|biz|co)(\\.br)?$";

        if (!email.matches(emailRegex)) {
            request.setAttribute("mensagem", "Email inválido. Use um formato como nome@empresa.com.br");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/empresaJSP/updateEmpresa.jsp");
            dispatcher.forward(request, response);
            return;
        }

        Empresa empresa = new Empresa(
                Integer.parseInt(request.getParameter("id")),
                Integer.parseInt(request.getParameter("idEndereco")),
                request.getParameter("nome"),
                cnpj,
                email
        );

        EmpresaDAO dao = new EmpresaDAO();
        int status = dao.update(empresa);

        String mensagem;
        switch (status) {
            case 1:
                mensagem = "A atualizaçao de " + empresa.getNome() + " foi realizada com sucesso";
                break;
            case 0:
                mensagem = "A atualizaçao de " + empresa.getNome() + " falhou, esse cnpj ja foi vinculado";
                break;
            case -1:
                mensagem = "A atualizaçao de " + empresa.getNome() + " falhou, esse email ja foi vinculado";
                break;
            case -2:
                mensagem = "A atualizaçao falhou: erro desconhecido. Entre em contato em contato.codcoz@gmail.com";
                break;
            default:
                mensagem = "A atualizaçao falhou: erro interno. Entre em contato em contato.codcoz@gmail.com";
        }

        request.setAttribute("mensagem", mensagem);
        List<Empresa> lista = dao.read();
        request.setAttribute("listaEmpresas", lista);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/empresaJSP/readEmpresa.jsp");
        dispatcher.forward(request, response);
    }
}
