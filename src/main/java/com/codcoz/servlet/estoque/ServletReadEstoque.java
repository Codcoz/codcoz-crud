package com.codcoz.servlet.estoque;

import com.codcoz.dao.EstoqueDAO;
import com.codcoz.model.Estoque;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ServletReadEstoque", value = "/ServletReadEstoque")
public class ServletReadEstoque extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        EstoqueDAO dao = new EstoqueDAO();
        List<Estoque> lista = dao.read();

        request.setAttribute("listaEstoques", lista);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/estoqueJSP/readEstoque.jsp");
        dispatcher.forward(request, response);
    }
}