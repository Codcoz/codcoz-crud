// src/main/java/com/codcoz/servlet/notaFiscalXml/ServletCreateNotaFiscalXml.java
package com.codcoz.servlet.notaFiscalXml;

import com.codcoz.dao.NotaFiscalXmlDAO;
import com.codcoz.model.NotaFiscalXml;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ServletCreateNotaFiscalXml", urlPatterns = "/ServletCreateNotaFiscalXml")
public class ServletCreateNotaFiscalXml extends HttpServlet {
    private static final String READ_JSP = "/notaFiscalXmlJSP/readNotaFiscalXml.jsp";

    /**
     * Redireciona via GET para a listagem.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<NotaFiscalXml> lista = new NotaFiscalXmlDAO().read();
        request.setAttribute("listaNotas", lista);
        RequestDispatcher dispatcher = request.getRequestDispatcher(READ_JSP);
        dispatcher.forward(request, response);
    }

    /**
     * Cria uma nova NotaFiscalXml e retorna para a listagem.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Constrói o objeto a partir dos parâmetros transmitidos
        NotaFiscalXml nota = new NotaFiscalXml(
                Integer.parseInt(request.getParameter("idEmpresa")),
                request.getParameter("dataEmissao"),
                request.getParameter("xmlString"),
                request.getParameter("numeroNota")
        );

        NotaFiscalXmlDAO dao = new NotaFiscalXmlDAO();
        dao.create(nota);

        // Recarrega lista e encaminha para o JSP
        List<NotaFiscalXml> lista = dao.read();
        request.setAttribute("listaNotas", lista);
        RequestDispatcher dispatcher = request.getRequestDispatcher(READ_JSP);
        dispatcher.forward(request, response);
    }
}
