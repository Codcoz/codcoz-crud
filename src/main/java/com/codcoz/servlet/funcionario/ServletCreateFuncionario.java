package com.codcoz.servlet.funcionario;

import com.codcoz.dao.FuncionarioDAO;
import com.codcoz.model.Funcionario;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ServletCreateFuncionario", value = "/ServletCreateFuncionario")
public class ServletCreateFuncionario extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String cpfNormalizado = request.getParameter("cpf").replaceAll("\\D", "");

        Funcionario funcionario = new Funcionario(
                Integer.parseInt(request.getParameter("idEmpresa")),
                request.getParameter("funcao"),
                request.getParameter("nome"),
                request.getParameter("sobrenome"),
                cpfNormalizado,
                request.getParameter("email"),
                request.getParameter("status")
        );

        FuncionarioDAO dao = new FuncionarioDAO();
        int status = dao.create(funcionario);

        String mensagem;
        switch (status) {
            case 1:
                mensagem = "A criação de " + funcionario.getNome() + " foi realizada com sucesso.";
                break;
            case 0:
                mensagem = "A criação de " + funcionario.getNome() + " falhou: esse CPF já está vinculado.";
                break;
            case -1:
                mensagem = "A criação de " + funcionario.getNome() + " falhou: esse e-mail já está vinculado.";
                break;
            case -2:
                mensagem = "A criação falhou: erro desconhecido. Entre em contato pelo e-mail contato.codcoz@gmail.com.";
                break;
            default:
                mensagem = "A1 criação falhou: erro interno. Entre em contato pelo e-mail contato.codcoz@gmail.com.";
        }

        request.setAttribute("mensagem", mensagem);
        List<Funcionario> lista = dao.read();
        request.setAttribute("listaFuncionarios", lista);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/funcionarioJSP/readFuncionario.jsp");
        dispatcher.forward(request, response);
    }
}