// Define o pacote da servlet responsável por listar notas fiscais XML
package com.codcoz.servlet.notaFiscalXml;

// Importa classes para acesso a dados e manipulação de requisições
import com.codcoz.dao.NotaFiscalXmlDAO;
import com.codcoz.dao.ProdutoDAO;
import com.codcoz.model.Empresa;
import com.codcoz.model.NotaFiscalXml;
import com.codcoz.model.Produto;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

// Define a servlet e mapeia sua URL
@WebServlet(name = "ServletReadNotaFiscalXml", value = "/ServletReadNotaFiscalXml")
public class ServletReadNotaFiscalXml extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        NotaFiscalXmlDAO dao = new NotaFiscalXmlDAO();

        List<NotaFiscalXml> lista;
        String idBuscarPorEmpresa = request.getParameter("buscarPorEmpresa");
        if (idBuscarPorEmpresa!=null){
            lista = dao.buscarPorEmpresa(Integer.parseInt(idBuscarPorEmpresa));
            request.setAttribute("filtro", idBuscarPorEmpresa );
        }else {
            lista = dao.read();
            request.setAttribute("filtro", null );
        }
        // Adiciona a lista como atributo da requisição
        request.setAttribute("listaNotas", lista);

        // Encaminha a requisição para a página JSP que exibirá os dados
        RequestDispatcher dispatcher = request.getRequestDispatcher("/notaFiscalXmlJSP/readNotaFiscalXml.jsp");
        dispatcher.forward(request, response);
    }
}