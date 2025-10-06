package com.codcoz.servlet.alerta;

import com.codcoz.dao.AlertaDAO;
import com.codcoz.model.Alerta;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ServletDeleteAlerta", value = "/ServletDeleteAlerta")
public class ServletDeleteAlerta extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        AlertaDAO dao = new AlertaDAO();
        String alerta = dao.buscarPorId(id).getTipoAlerta();

        // Executa a exclusão via DAO e recebe o status da operação
        int status = dao.delete(id);

        // Define a mensagem com base no status da exclusão
        String mensagem;
        switch (status) {
            case 1:
                mensagem = "A exclusão de " + alerta + " foi realizada com sucesso.";
                break;
            case 0:
                mensagem = "A exclusão falhou: a empresa " + alerta + " está associada a outra tabela. Apague os campos relacionados primeiro.";
                break;
            case -1:
                mensagem = "A exclusão de " + alerta + " falhou: erro interno. Entre em contato pelo e-mail contato.codcoz@gmail.com.";
                break;
            default:
                mensagem = "A exclusão de " + alerta + " falhou: erro desconhecido. Entre em contato pelo e-mail contato.codcoz@gmail.com.";
                break;
        }

        request.setAttribute("mensagem", mensagem);
        List<Alerta> lista = dao.read();

        // Define a lista como atributo da request
        request.setAttribute("listaAlertas", lista);

        // Encaminha para a página JSP mantendo os dados
        RequestDispatcher dispatcher = request.getRequestDispatcher("/alertaJSP/readAlerta.jsp");
        dispatcher.forward(request, response);
    }
}
