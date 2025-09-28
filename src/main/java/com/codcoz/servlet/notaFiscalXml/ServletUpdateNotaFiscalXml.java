// src/main/java/com/codcoz/servlet/notaFiscalXml/ServletUpdateNotaFiscalXml.java
package com.codcoz.servlet.notaFiscalXml;

import com.codcoz.dao.NotaFiscalXmlDAO;
import com.codcoz.model.NotaFiscalXml;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ServletUpdateNotaFiscalXml", urlPatterns = "/ServletUpdateNotaFiscalXml")
public class ServletUpdateNotaFiscalXml extends HttpServlet {
    private static final String READ_JSP  = "/notaFiscalXmlJSP/readNotaFiscalXml.jsp";
    private static final String ERROR_JSP = "/erro.jsp";

    /**
     * Atualiza a nota fiscal e retorna para a listagem.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            NotaFiscalXml nota = new NotaFiscalXml(
                    Integer.parseInt(request.getParameter("id")),
                    Integer.parseInt(request.getParameter("idEmpresa")),
                    request.getParameter("dataEmissao"),
                    request.getParameter("xmlString"),
                    request.getParameter("numeroNota")
            );

            NotaFiscalXmlDAO dao = new NotaFiscalXmlDAO();
            dao.update(nota);

            List<NotaFiscalXml> lista = dao.read();
            request.setAttribute("listaNotas", lista);
            RequestDispatcher dispatcher = request.getRequestDispatcher(READ_JSP);
            dispatcher.forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("erro", "Erro de conversão numérica: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher(ERROR_JSP);
            dispatcher.forward(request, response);
        }
    }
}
