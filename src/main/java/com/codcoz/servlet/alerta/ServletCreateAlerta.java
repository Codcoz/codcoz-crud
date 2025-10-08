package com.codcoz.servlet.alerta;

import com.codcoz.dao.AlertaDAO;
import com.codcoz.dao.EmpresaDAO;
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
        // Captura os dados do formulário
        Alerta alerta = new Alerta(
                Integer.parseInt(request.getParameter("idEmpresa")),
                Integer.parseInt(request.getParameter("idProduto")),
                Date.valueOf(request.getParameter("dataCriacao")),
                request.getParameter("status"),
                request.getParameter("tipoAlerta")
        );

        // Chama o DAO
        AlertaDAO dao = new AlertaDAO();
        String mensagem;

        if (dao.create(alerta)) {
            mensagem = "Alerta criado com sucesso.";
        } else {
            mensagem = "A criação falhou: erro interno. Entre em contato via contato.codcoz@gmail.com";
        }

        // Define atributos para a JSP
        request.setAttribute("mensagem", mensagem);
        List<Alerta> lista = dao.read();
        request.setAttribute("listaAlertas", lista);

        // Encaminha para a página de listagem
        RequestDispatcher dispatcher = request.getRequestDispatcher("/alertaJSP/readAlerta.jsp");
        dispatcher.forward(request, response);
    }
}