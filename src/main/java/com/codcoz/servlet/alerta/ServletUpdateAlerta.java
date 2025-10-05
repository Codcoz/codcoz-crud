package com.codcoz.servlet.Alerta;

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
                Integer.parseInt(request.getParameter("id")),
                Integer.parseInt(request.getParameter("idEmpresa")),
                Integer.parseInt(request.getParameter("idProduto")),
                Date.valueOf(request.getParameter("dataCriacao")),
                request.getParameter("status"),
                request.getParameter("tipoAlerta")
        );

//          chama o DAO para update
        AlertaDAO dao = new AlertaDAO();
        dao.update(alerta);
//          redireciona pra o read
        List<Alerta> lista = dao.read();

        // Define a lista como atributo da request
        request.setAttribute("listaAlertas", lista);

        // Encaminha para a página JSP mantendo os dados
        RequestDispatcher dispatcher = request.getRequestDispatcher("/alertaJSP/readAlerta.jsp");
        dispatcher.forward(request, response);
    }
}

