package com.codcoz.servlet.alerta;

import com.codcoz.dao.AlertaDAO;
import com.codcoz.model.Alerta;
import com.codcoz.model.Estoque;
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
        AlertaDAO dao= new AlertaDAO();
        List<Alerta> lista;
        String idBuscarPorEmpresa = request.getParameter("buscarPorEmpresa");
        if (idBuscarPorEmpresa!=null){
            lista = dao.buscarPorEmpresa(Integer.parseInt(idBuscarPorEmpresa));
            request.setAttribute("filtro", idBuscarPorEmpresa );
        }else {
            lista = dao.read();
            request.setAttribute("filtro", null );
        }
        // Define a lista como atributo da request
        request.setAttribute("listaAlertas", lista);

        // Encaminha para a página JSP mantendo os dados
        RequestDispatcher dispatcher = request.getRequestDispatcher("/alertaJSP/readAlerta.jsp");
        dispatcher.forward(request, response);
    }
}
