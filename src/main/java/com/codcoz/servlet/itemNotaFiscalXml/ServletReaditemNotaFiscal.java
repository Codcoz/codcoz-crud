package com.codcoz.servlet.itemNotaFiscalXml;

import com.codcoz.dao.ItemNotaFiscalDAO;
import com.codcoz.model.ItemNotaFiscal;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ServletReadItemNotaFiscal", urlPatterns = "/ServletReadItemNotaFiscal")
public class ServletReadItemNotaFiscal extends HttpServlet {
    private static final String READ_JSP = "/itemNotaFiscalJSP/readItemNotaFiscal.jsp";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<ItemNotaFiscal> lista = new ItemNotaFiscalDAO().read();
        request.setAttribute("listaItensNotaFiscal", lista);
        RequestDispatcher dispatcher = request.getRequestDispatcher(READ_JSP);
        dispatcher.forward(request, response);
    }
}
