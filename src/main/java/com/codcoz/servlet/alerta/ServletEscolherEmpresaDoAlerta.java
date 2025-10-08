package com.codcoz.servlet.alerta;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class ServletEscolherEmpresaDoAlerta {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Chama o DAO
        request.setAttribute("idEmpresa",request.getParameter("idEmpresa"));
        // Encaminha para a página JSP mantendo os dados
        RequestDispatcher dispatcher = request.getRequestDispatcher("/alertaJSP/createAlerta.jsp");
        dispatcher.forward(request, response);
    }
}