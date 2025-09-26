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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        AlertaDAO alertaDAO = new AlertaDAO();
        alertaDAO.delete(id);
        List<Alerta> lista = alertaDAO.read();

        // Define a lista como atributo da request
        request.setAttribute("listaAlerta", lista);

        // Encaminha para a página JSP mantendo os dados
        RequestDispatcher dispatcher = request.getRequestDispatcher("readAlerta.jsp");
        dispatcher.forward(request, response);
    }
}
