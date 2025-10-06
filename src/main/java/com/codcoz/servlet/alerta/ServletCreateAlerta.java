package com.codcoz.servlet.alerta;

import com.codcoz.dao.AlertaDAO;
import com.codcoz.model.Alerta;
import com.codcoz.model.Empresa;
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
        String mensagem;
        if (dao.create(alerta)) {
            mensagem = "A criação de " + alerta.getId() + " foi realizada com sucesso";
        } else {
            mensagem = "A criação falhou: erro interno. Entre em contato em contato.codcoz@gmail.com";
        }

        request.setAttribute("mensagem", mensagem);

        // Atualiza a lista de empresas para exibir na JSP
        List<Alerta> lista = dao.read();
        request.setAttribute("listaAlertas", lista);

        // Encaminha para a página JSP mantendo os dados
        RequestDispatcher dispatcher = request.getRequestDispatcher("/alertaJSP/readAlerta.jsp");
        dispatcher.forward(request, response);
    }
    }
