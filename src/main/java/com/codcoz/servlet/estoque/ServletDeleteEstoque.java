package com.codcoz.servlet.estoque;

import com.codcoz.dao.EstoqueDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;
import com.codcoz.model.Estoque;

@WebServlet(name = "ServletDeleteEstoque", value = "/ServletDeleteEstoque")
public class ServletDeleteEstoque extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        EstoqueDAO dao = new EstoqueDAO();
        dao.delete(id);
        List<Estoque> lista = dao.read();

        request.setAttribute("listaEstoques", lista);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/estoqueJSP/readEstoque.jsp");
        dispatcher.forward(request, response);
    }
}