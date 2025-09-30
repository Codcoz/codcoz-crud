package com.codcoz.servlet.itemNotaFiscal;

import com.codcoz.dao.ItemNotaFiscalDAO;
import com.codcoz.model.ItemNotaFiscal;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ServletDeleteItemNotaFiscal", value = "/ServletDeleteItemNotaFiscal")
public class ServletDeleteItemNotaFiscal extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        ItemNotaFiscalDAO dao = new ItemNotaFiscalDAO();
        dao.delete(id);
        List<ItemNotaFiscal> lista = dao.read();

        request.setAttribute("listaItens", lista);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/itemNotaFiscalJSP/readItemNotaFiscal.jsp");
        dispatcher.forward(request, response);
    }
}