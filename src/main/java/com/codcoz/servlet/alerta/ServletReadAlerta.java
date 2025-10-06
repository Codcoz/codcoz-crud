package com.codcoz.servlet.alerta;

import com.codcoz.dao.AlertaDAO;
import com.codcoz.model.Alerta;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ServletReadAlerta", value = "/ServletReadAlerta")
public class ServletReadAlerta extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    // Chama o DAO
        AlertaDAO alertaDAO= new AlertaDAO();
        List<Alerta> lista = alertaDAO.read();

        // Define a lista como atributo da request
        request.setAttribute("listaAlertas", lista);

        // Encaminha para a página JSP mantendo os dados
        RequestDispatcher dispatcher = request.getRequestDispatcher("/alertaJSP/readAlerta.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
