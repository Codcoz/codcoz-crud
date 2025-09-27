package com.codcoz.servlet.notaFiscalXml;

import com.codcoz.dao.NotaFiscalXmlDAO;
import com.codcoz.model.NotaFiscalXml;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ServletDeleteNotaFiscalXml", value = "/ServletDeleteNotaFiscalXml")
public class ServletDeleteNotaFiscalXml extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        NotaFiscalXmlDAO dao = new NotaFiscalXmlDAO();
        dao.delete(id);

        List<NotaFiscalXml> lista = dao.read();
        request.setAttribute("listaNotas", lista);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/NotaFiscalxml/readNotaFiscalXml.jsp");
        dispatcher.forward(request, response);
    }
}
