package com.codcoz.servlet.itemNotaFiscalXml;



import com.codcoz.dao.ItemNotaFiscalDAO;
import com.codcoz.model.ItemNotaFiscal;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;



@WebServlet(name = "ServletReadItemNotaFiscal", value = "/ServletReadItemNotaFiscal")
public class ServletReaditemNotaFiscalXml extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Chama o DAO
        ItemNotaFiscalDAO itemNotaFiscalDAO = new ItemNotaFiscalDAO();
        List<ItemNotaFiscal> lista = itemNotaFiscalDAO.read();

        // Define a lista como atributo da request
        request.setAttribute("listaItensNotaFiscal", lista);

        // Encaminha para a página JSP mantendo os dados
        RequestDispatcher dispatcher = request.getRequestDispatcher("readItemNotaFiscal.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}



