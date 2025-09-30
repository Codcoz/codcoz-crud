package com.codcoz.servlet.alerta;

import com.codcoz.dao.NotaFiscalXmlDAO;
import com.codcoz.model.NotaFiscalXml;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet(name = "ServletCreateNotaFiscalXml", value = "/ServletCreateNotaFiscalXml")
public class ServletCreateNotaFiscalXml extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        NotaFiscalXml nota = new NotaFiscalXml(
                Integer.parseInt(request.getParameter("idEmpresa")),
                Date.valueOf(request.getParameter("dataEmissao")),
                request.getParameter("xmlString"),
                request.getParameter("numeroNota")
        );

        NotaFiscalXmlDAO dao = new NotaFiscalXmlDAO();
        dao.create(nota);
        List<NotaFiscalXml> lista = dao.read();

        request.setAttribute("listaNotas", lista);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/notaFiscalXmlJSP/readNotaFiscalXml.jsp");
        dispatcher.forward(request, response);
    }
}