package com.codcoz.servlet.estoque;

import com.codcoz.dao.EstoqueDAO;
import com.codcoz.model.Estoque;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ServletUpdateEstoque", value = "/ServletUpdateEstoque")
public class ServletUpdateEstoque extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Estoque estoque = new Estoque(
                Integer.parseInt(request.getParameter("id")),
                Integer.parseInt(request.getParameter("idEmpresa")),
                request.getParameter("tipoEstoque"),
                Integer.parseInt(request.getParameter("capacidade"))
        );

        EstoqueDAO dao = new EstoqueDAO();
        dao.update(estoque);
        List<Estoque> lista = dao.read();

        request.setAttribute("listaEstoques", lista);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/estoqueJSP/readEstoque.jsp");
        dispatcher.forward(request, response);
    }
}