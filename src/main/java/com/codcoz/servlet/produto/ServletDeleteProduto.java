package com.codcoz.servlet.produto;

import com.codcoz.dao.ProdutoDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;
import com.codcoz.model.Produto;

@WebServlet(name = "ServletDeleteProduto", value = "/ServletDeleteProduto")
public class ServletDeleteProduto extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        ProdutoDAO dao = new ProdutoDAO();
        dao.delete(id);
        List<Produto> lista = dao.read();

        request.setAttribute("listaProdutos", lista);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/produtoJSP/readProduto.jsp");
        dispatcher.forward(request, response);
    }
}