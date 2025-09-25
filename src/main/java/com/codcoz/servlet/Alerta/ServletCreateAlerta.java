package com.codcoz.servlet.Alerta;

import com.codcoz.dao.AlertaDAO;
import com.codcoz.dao.EnderecoDAO;
import com.codcoz.model.Alerta;
import com.codcoz.model.Endereco;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ServletCreateAlerta", value = "/ServletCreateAlerta")
public class ServletCreateAlerta extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Alerta alerta = new Alerta(
                Integer.parseInt(request.getParameter("id_empresa")),
                Integer.parseInt(request.getParameter("id_produto")),
                request.getParameter("data_criacao"),
                request.getParameter("status"),
                request.getParameter("tipo_alerta")
        );
        // Chama o DAO
        AlertaDAO dao = new AlertaDAO();
        dao.create(alerta);
        List<Alerta> lista = dao.read();

        // Define a lista como atributo da request
        request.setAttribute("listaAlerta", lista);

        // Encaminha para a página JSP mantendo os dados
        RequestDispatcher dispatcher = request.getRequestDispatcher("readAlerta.jsp");
        dispatcher.forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
