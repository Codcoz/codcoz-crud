package com.codcoz.servlet.notaFiscalXml;

import com.codcoz.dao.NotaFiscalXmlDAO;
import com.codcoz.model.NotaFiscalXml;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ServletCreateNotaFiscalXml", value = "/ServletCreateNotaFiscalXml")
public class ServletCreateNotaFiscalXml extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        NotaFiscalXml nota = new NotaFiscalXml(
                Integer.parseInt(request.getParameter("idEmpresa")),
                request.getParameter("dataEmissao"),
                request.getParameter("xmlString"),
                request.getParameter("numeroNota")
        );

        NotaFiscalXmlDAO dao = new NotaFiscalXmlDAO();
        dao.create(nota);

        List<NotaFiscalXml> lista = dao.read();
        request.setAttribute("listaNotas", lista);

<<<<<<< HEAD
        RequestDispatcher dispatcher = request.getRequestDispatcher("/notaFiscalXmlJSP/readNotaFiscalXml.jsp");
=======
        RequestDispatcher dispatcher = request.getRequestDispatcher("/NotaFiscalxml/readNotaFiscalXml.jsp");
>>>>>>> b0f8cb5cc2905eeb18a7e0ceb7a15fb342d0a0af
        dispatcher.forward(request, response);
    }
}

