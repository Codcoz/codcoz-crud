package com.codcoz.servlet.itemNotaFiscalXml;

import com.codcoz.dao.ItemNotaFiscalDAO;
import com.codcoz.model.ItemNotaFiscal;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ServletUpdateItemNotaFiscal", urlPatterns = "/ServletUpdateItemNotaFiscal")
public class ServletUpdateItemNotaFiscal extends HttpServlet {
    private static final String READ_JSP = "/itemNotaFiscalJSP/readItemNotaFiscal.jsp";
    private static final String ERROR_JSP = "/erro.jsp";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Integer id               = Integer.valueOf(request.getParameter("id"));
            Integer idNotaFiscalXml = Integer.valueOf(request.getParameter("idNotaFiscalXml"));
            Integer idEmpresa        = Integer.valueOf(request.getParameter("idEmpresa"));
            Double quantidade        = Double.valueOf(request.getParameter("quantidade"));
            Double preco             = Double.valueOf(request.getParameter("preco"));

            ItemNotaFiscal item = new ItemNotaFiscal(id, idNotaFiscalXml, idEmpresa, quantidade, preco);
            ItemNotaFiscalDAO dao = new ItemNotaFiscalDAO();
            dao.update(item);

            // Recarrega lista e encaminha
            List<ItemNotaFiscal> lista = dao.read();
            request.setAttribute("listaItensNotaFiscal", lista);
            RequestDispatcher dispatcher = request.getRequestDispatcher(READ_JSP);
            dispatcher.forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("erro", "Erro ao converter valores numéricos: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher(ERROR_JSP);
            dispatcher.forward(request, response);
        }
    }
}
