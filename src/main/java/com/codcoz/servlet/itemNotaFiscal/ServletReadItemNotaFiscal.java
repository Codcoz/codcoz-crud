package com.codcoz.servlet.itemNotaFiscal;

import com.codcoz.dao.ItemNotaFiscalDAO;
import com.codcoz.model.ItemNotaFiscal;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ServletReadItemNotaFiscal", value = "/ServletReadItemNotaFiscal")
public class ServletReadItemNotaFiscal extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ItemNotaFiscalDAO dao = new ItemNotaFiscalDAO();
        List<ItemNotaFiscal> lista = dao.read();

        request.setAttribute("listaItens", lista);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/itemNotaFiscalJSP/readItemNotaFiscal.jsp");
        dispatcher.forward(request, response);
    }
}