package com.codcoz.servlet.alerta;

import com.codcoz.dao.AlertaDAO;
import com.codcoz.model.Alerta;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet(name = "ServletUpdateAlerta", value = "/ServletUpdateAlerta")
public class ServletUpdateAlerta extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Cria o objeto Alerta com os dados do formulário
        Alerta alerta = new Alerta(
                Integer.parseInt(request.getParameter("id")),
                Integer.parseInt(request.getParameter("idEmpresa")),
                Integer.parseInt(request.getParameter("idProduto")),
                Date.valueOf(request.getParameter("dataCriacao")),
                request.getParameter("status"),
                request.getParameter("tipoAlerta")
        );

        // Chama o DAO para atualizar
        AlertaDAO dao = new AlertaDAO();
        int resultado = dao.update(alerta);

        // Define a mensagem com base no resultado
        String mensagem;
        switch (resultado) {
            case 1:
                mensagem = "A atualização do alerta " + alerta.getId() + " foi realizada com sucesso.";
                break;
            case 0:
                mensagem = "A atualização do alerta " + alerta.getId() + " falhou: erro interno. Entre em contato pelo e-mail contato.codcoz@gmail.com.";
                break;
            default:
                mensagem = "A atualização do alerta " + alerta.getId() + " falhou: erro desconhecido. Entre em contato pelo e-mail contato.codcoz@gmail.com.";
                break;
        }

        // Define atributos para a JSP
        request.setAttribute("mensagem", mensagem);
        List<Alerta> lista = dao.read();
        request.setAttribute("listaAlertas", lista);

        // Encaminha para a página de listagem
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/alertaJSP/readAlerta.jsp");
        dispatcher.forward(request, response);
    }
}