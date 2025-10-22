// Define o pacote da servlet responsável por listar notas fiscais XML
package com.codcoz.servlet.notaFiscalXml;

// Importa classes para acesso a dados e manipulação de requisições
import com.codcoz.dao.NotaFiscalXmlDAO;
import com.codcoz.model.NotaFiscalXml;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

// Define a servlet e mapeia sua URL
@WebServlet(name = "ServletReadNotaFiscalXml", value = "/ServletReadNotaFiscalXml")
public class ServletReadNotaFiscalXml extends HttpServlet {

    // Método que trata requisições GET para listar notas fiscais XML
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Recupera a lista de notas fiscais do banco de dados
        NotaFiscalXmlDAO dao = new NotaFiscalXmlDAO();
        List<NotaFiscalXml> lista = dao.read();

        // Adiciona a lista como atributo da requisição
        request.setAttribute("listaNotas", lista);

        // Encaminha a requisição para a página JSP que exibirá os dados
        RequestDispatcher dispatcher = request.getRequestDispatcher("/notaFiscalXmlJSP/readNotaFiscalXml.jsp");
        dispatcher.forward(request, response);
    }
}