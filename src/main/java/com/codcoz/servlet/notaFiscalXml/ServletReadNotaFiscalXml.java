package com.codcoz.servlet.notaFiscalXml;

import com.codcoz.dao.NotaFiscalXmlDAO;
import com.codcoz.model.NotaFiscalXml;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ServletReadNotaFiscalXml", value = "/ServletReadNotaFiscalXml")
public class ServletReadNotaFiscalXml extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        NotaFiscalXmlDAO dao = new NotaFiscalXmlDAO();
        List<NotaFiscalXml> lista = dao.read();

        request.setAttribute("listaNotas", lista);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/notaFiscalXmlJSP/readNotaFiscalXml.jsp");
        dispatcher.forward(request, response);

    }
}

