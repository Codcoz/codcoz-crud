package com.codcoz.servlet.Alerta;

import com.codcoz.dao.AlertaDAO;
import com.codcoz.model.Alerta;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet(name = "ServletCreateAlerta", value = "/ServletCreateAlerta")
public class ServletCreateAlerta extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Alerta alerta = new Alerta(
                Integer.parseInt(request.getParameter("idEmpresa")),
                Integer.parseInt(request.getParameter("idProduto")),
                Date.valueOf(request.getParameter("dataCriacao")),
                request.getParameter("status"),
                request.getParameter("tipoAlerta")
        );
        // Chama o DAO
        AlertaDAO dao = new AlertaDAO();
        dao.create(alerta);
        List<Alerta> lista = dao.read();

        // Define a lista como atributo da request
        request.setAttribute("listaAlertas", lista);

        // Encaminha para a página JSP mantendo os dados
        RequestDispatcher dispatcher = request.getRequestDispatcher("/alertaJSP/readAlerta.jsp");
        dispatcher.forward(request, response);
    }

}
