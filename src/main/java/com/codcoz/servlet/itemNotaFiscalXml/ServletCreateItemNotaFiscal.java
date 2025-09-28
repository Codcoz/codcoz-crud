package com.codcoz.servlet.itemNotaFiscalXml;

import com.codcoz.dao.ItemNotaFiscalDAO;
import com.codcoz.model.ItemNotaFiscal;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ServletCreateItemNotaFiscal", urlPatterns = "/ServletCreateItemNotaFiscal")
public class ServletCreateItemNotaFiscal extends HttpServlet {
    private static final String READ_JSP = "/itemNotaFiscalJSP/readItemNotaFiscal.jsp";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<ItemNotaFiscal> lista = new ItemNotaFiscalDAO().read();
        request.setAttribute("listaItensNotaFiscal", lista);
        RequestDispatcher dispatcher = request.getRequestDispatcher(READ_JSP);
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Integer idNotaFiscalXml = Integer.valueOf(request.getParameter("idNotaFiscalXml"));
        Integer idEmpresa        = Integer.valueOf(request.getParameter("idEmpresa"));
        Double quantidade        = Double.valueOf(request.getParameter("quantidade"));
        Double preco             = Double.valueOf(request.getParameter("preco"));

        ItemNotaFiscal item = new ItemNotaFiscal(idNotaFiscalXml, idEmpresa, quantidade, preco);
        ItemNotaFiscalDAO dao = new ItemNotaFiscalDAO();
        dao.create(item);

        // Recarrega lista e encaminha
        List<ItemNotaFiscal> lista = dao.read();
        request.setAttribute("listaItensNotaFiscal", lista);
        RequestDispatcher dispatcher = request.getRequestDispatcher(READ_JSP);
        dispatcher.forward(request, response);
    }
}
