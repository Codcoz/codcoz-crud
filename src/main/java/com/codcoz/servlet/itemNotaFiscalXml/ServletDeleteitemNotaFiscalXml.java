package com.codcoz.servlet.itemNotaFiscalXml;



import com.codcoz.dao.ItemNotaFiscalDAO;
import com.codcoz.model.ItemNotaFiscal;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

        import java.io.IOException;
import java.util.List;

@WebServlet(name = "ServletDeleteItemNotaFiscal", value = "/ServletDeleteItemNotaFiscal")
public class ServletDeleteitemNotaFiscalXml extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Não utilizado neste servlet
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        ItemNotaFiscalDAO itemNotaFiscalDAO = new ItemNotaFiscalDAO();
        itemNotaFiscalDAO.delete(id);
        List<ItemNotaFiscal> lista = itemNotaFiscalDAO.read();

        // Define a lista como atributo da request
        request.setAttribute("listaItensNotaFiscal", lista);

        // Encaminha para a página JSP mantendo os dados
        RequestDispatcher dispatcher = request.getRequestDispatcher("readItemNotaFiscal.jsp");
        dispatcher.forward(request, response);
    }
}

