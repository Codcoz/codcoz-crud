
package com.codcoz.servlet.notaFiscalXml;

import com.codcoz.dao.NotaFiscalXmlDAO;
import com.codcoz.model.NotaFiscalXml;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ServletReadNotaFiscalXml", urlPatterns = "/ServletReadNotaFiscalXml")
public class ServletReadNotaFiscalXml extends HttpServlet {
    private static final String READ_JSP = "/notaFiscalXmlJSP/readNotaFiscalXml.jsp";

    /**
     * Carrega todas as notas fiscais e exibe a listagem.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<NotaFiscalXml> lista = new NotaFiscalXmlDAO().read();
        request.setAttribute("listaNotas", lista);
        RequestDispatcher dispatcher = request.getRequestDispatcher(READ_JSP);
        dispatcher.forward(request, response);
    }
}
