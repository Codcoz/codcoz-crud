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
        int status = dao.delete(id);
        String mensagem;
        String empresa = dao.buscarPorId(id).getNome();
        switch (status) {
            case 1:
                mensagem = "A exclusão de " + empresa + " foi realizada com sucesso.";
                break;
            case 0:
                mensagem = "A exclusão falhou: a empresa " + empresa + " está associado a outra tabela. Apague os campos relacionados primeiro.";
                break;
            case -1:
                mensagem = "A exclusão de " + empresa + " falhou: erro interno. Entre em contato pelo e-mail contato.codcoz@gmail.com.";
                break;
            default:
                mensagem = "A exclusão de " + empresa + " falhou: erro desconhecido. Entre em contato pelo e-mail contato.codcoz@gmail.com.";
                break;
        }
        request.setAttribute("mensagem", mensagem);
        List<Empresa> lista = dao.read();

        request.setAttribute("listaEmpresas", lista);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/empresaJSP/readEmpresa.jsp");
        dispatcher.forward(request, response);
    }
}