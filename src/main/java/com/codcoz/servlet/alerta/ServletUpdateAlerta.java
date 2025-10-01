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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //          cria o objeto Endereco já com os dados do form
        Alerta alerta = new Alerta(
                Integer.parseInt(request.getParameter("id_empresa")),
                Integer.parseInt(request.getParameter("id_produto")),
                Date.valueOf(request.getParameter("data_criacao")),
                request.getParameter("status"),
                request.getParameter("tipo_alerta")
        );

//          chama o DAO para update
        AlertaDAO alertaDAO = new AlertaDAO();
        alertaDAO.update(alerta);
//          redireciona pra o read
        List<Alerta> lista = alertaDAO.read();

        // Define a lista como atributo da request
        request.setAttribute("listaAlerta", lista);

        // Encaminha para a página JSP mantendo os dados
        RequestDispatcher dispatcher = request.getRequestDispatcher("readAlerta.jsp");
        dispatcher.forward(request, response);
    }
}

