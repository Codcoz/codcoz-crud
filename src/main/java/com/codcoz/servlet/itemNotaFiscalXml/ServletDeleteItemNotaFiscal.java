package com.codcoz.servlet.itemNotaFiscalXml;

import com.codcoz.dao.ItemNotaFiscalDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ServletDeleteItemNotaFiscal", urlPatterns = "/ServletDeleteItemNotaFiscal")
public class ServletDeleteItemNotaFiscal extends HttpServlet {
    private static final String READ_JSP = "/itemNotaFiscalJSP/readItemNotaFiscal.jsp";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Integer id = Integer.valueOf(request.getParameter("id"));
        ItemNotaFiscalDAO dao = new ItemNotaFiscalDAO();
        dao.delete(id);

        // Recarrega lista e encaminha
        List<?> lista = dao.read();
        request.setAttribute("listaItensNotaFiscal", lista);
        RequestDispatcher dispatcher = request.getRequestDispatcher(READ_JSP);
        dispatcher.forward(request, response);
    }
}
