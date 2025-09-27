package com.codcoz.servlet.itemNotaFiscalXml;

import com.codcoz.dao.ItemNotaFiscalDAO;
import com.codcoz.model.ItemNotaFiscal;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "ServletUpdateItemNotaFiscal", value = "/ServletUpdateItemNotaFiscal")
public class ServletUpdateItemNotaFiscal extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Integer id = Integer.valueOf(request.getParameter("id"));
            Integer idNotaFiscalXml = Integer.valueOf(request.getParameter("idNotaFiscalXml"));
            Integer idEmpresa = Integer.valueOf(request.getParameter("idEmpresa"));
            Double quantidade = Double.valueOf(request.getParameter("quantidade"));
            Double preco = Double.valueOf(request.getParameter("preco"));


            ItemNotaFiscal item = new ItemNotaFiscal(id, idNotaFiscalXml, idEmpresa, quantidade, preco);

            ItemNotaFiscalDAO dao = new ItemNotaFiscalDAO();
            dao.update(item);

            // Atualiza lista
            RequestDispatcher dispatcher = request.getRequestDispatcher("/itemNotaFiscal/readItemNotaFiscal.jsp");
            dispatcher.forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("erro", "Erro ao converter valores numéricos: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("erro.jsp");
            dispatcher.forward(request, response);
        }
    }
}
