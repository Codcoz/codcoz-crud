package com.codcoz.servlet.funcionario;

import com.codcoz.dao.FuncionarioDAO;
import com.codcoz.model.Funcionario;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ServletUpdateFuncionario", value = "/ServletUpdateFuncionario")
public class ServletUpdateFuncionario extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Normaliza CPF usando regex: aceita "123.456.789-00" ou "12345678900"
        String cpfOriginal = request.getParameter("cpf");
        String cpfNormalizado = cpfOriginal.replaceAll("\\D", "");

        // Monta objeto
        Funcionario funcionario = new Funcionario(
                Integer.parseInt(request.getParameter("id")),
                Integer.parseInt(request.getParameter("idEmpresa")),
                request.getParameter("funcao"),
                request.getParameter("nome"),
                request.getParameter("sobrenome"),
                cpfNormalizado,
                request.getParameter("email"),
                request.getParameter("status")
        );

        // Executa update e interpreta status
        FuncionarioDAO dao = new FuncionarioDAO();
        int status = dao.update(funcionario);

        String mensagem;
        switch (status) {
            case 1:
                mensagem = "A atualização de " + funcionario.getNome() + " foi realizada com sucesso.";
                break;
            case 0:
                mensagem = "A atualização de " + funcionario.getNome() + " falhou: esse CPF já está vinculado.";
                break;
            case -1:
                mensagem = "A atualização de " + funcionario.getNome() + " falhou: esse e-mail já está vinculado.";
                break;
            case -2:
                mensagem = "A atualização falhou: erro desconhecido. Entre em contato pelo e-mail contato.codcoz@gmail.com.";
                break;
            default:
                mensagem = "A atualização falhou: erro interno. Entre em contato pelo e-mail contato.codcoz@gmail.com.";
        }

        request.setAttribute("mensagem", mensagem);
        List<Funcionario> lista = dao.read();
        request.setAttribute("listaFuncionarios", lista);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/funcionarioJSP/readFuncionario.jsp");
        dispatcher.forward(request, response);
    }
}