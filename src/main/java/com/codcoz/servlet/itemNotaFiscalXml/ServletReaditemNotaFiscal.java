package com.codcoz.servlet.itemNotaFiscalXml;



import com.codcoz.dao.ItemNotaFiscalDAO;
import com.codcoz.model.ItemNotaFiscal;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;



@WebServlet(name = "ServletReadItemNotaFiscal", value = "/ServletReadItemNotaFiscal")
public class ServletReaditemNotaFiscal extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Chama o DAO
        ItemNotaFiscalDAO itemNotaFiscalDAO = new ItemNotaFiscalDAO();
        List<ItemNotaFiscal> lista = itemNotaFiscalDAO.read();

        // Define a lista como atributo da request
        request.setAttribute("listaItensNotaFiscal", lista);

        // Encaminha para a página JSP mantendo os dados
<<<<<<< HEAD
        RequestDispatcher dispatcher = request.getRequestDispatcher("/itemNotaFiscalJSP/readItemNotaFiscal.jsp");
=======
        RequestDispatcher dispatcher = request.getRequestDispatcher("/itemNotaFiscal/readItemNotaFiscal.jsp");
>>>>>>> b0f8cb5cc2905eeb18a7e0ceb7a15fb342d0a0af
        dispatcher.forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}



