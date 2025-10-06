package com.codcoz.servlet.funcionario;

import com.codcoz.dao.FuncionarioDAO;
import com.codcoz.model.Funcionario;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ServletDeleteFuncionario", value = "/ServletDeleteFuncionario")
public class ServletDeleteFuncionario extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        FuncionarioDAO dao = new FuncionarioDAO();

        Funcionario f = dao.buscarPorId(id);
        String nomeExibicao = (f != null)
                ? (f.getNome() + (f.getSobrenome() != null ? " " + f.getSobrenome() : ""))
                : "Funcionário (ID " + id + ")";

        int status = dao.delete(id);

        String mensagem;
        switch (status) {
            case 1:
                mensagem = "A exclusão de " + nomeExibicao + " foi realizada com sucesso.";
                break;
            case 0:
                mensagem = "A exclusão falhou: " + nomeExibicao
                        + " está associado(a) a outra tabela. Apague os registros relacionados primeiro.";
                break;
            case -1:
                mensagem = "A exclusão de " + nomeExibicao
                        + " falhou: erro interno. Entre em contato pelo e-mail contato.codcoz@gmail.com.";
                break;
            default:
                mensagem = "A exclusão de " + nomeExibicao
                        + " falhou: erro desconhecido. Entre em contato pelo e-mail contato.codcoz@gmail.com.";
        }

        request.setAttribute("mensagem", mensagem);
        List<Funcionario> lista = dao.read();
        request.setAttribute("listaFuncionarios", lista);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/funcionarioJSP/readFuncionario.jsp");
        dispatcher.forward(request, response);
    }
}
