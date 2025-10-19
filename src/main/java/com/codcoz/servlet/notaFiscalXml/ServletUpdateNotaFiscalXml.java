package com.codcoz.servlet.notaFiscalXml;

import com.codcoz.dao.EstoqueDAO;
import com.codcoz.dao.NotaFiscalXmlDAO;
import com.codcoz.model.Estoque;
import com.codcoz.model.NotaFiscalXml;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet(name = "ServletUpdateNotaFiscalXml", value = "/ServletUpdateNotaFiscalXml")
public class ServletUpdateNotaFiscalXml extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Cria o objeto Nota
        NotaFiscalXml nota = new NotaFiscalXml(
                Integer.parseInt(request.getParameter("id")),
                Integer.parseInt(request.getParameter("idEmpresa")),
                Date.valueOf(request.getParameter("dataEmissao")),
                request.getParameter("xmlString"),
                request.getParameter("numeroNota")
        );
        // Executa a atualização via DAO e define a mensagem de retorno
        NotaFiscalXmlDAO dao = new NotaFiscalXmlDAO();
        String mensagem;

        if (dao.update(nota) > 0) {
            mensagem = "A nota \"" + nota.getNumeroNota() + "\" foi atualizado com sucesso.";
        } else {
            mensagem = "A atualização da nota \"" + nota.getNumeroNota() + "\" falhou: erro interno. "
                    + "Entre em contato em contato.codcoz@gmail.com";
        }
        request.setAttribute("mensagem", mensagem);

        List<NotaFiscalXml> lista = dao.read();
        request.setAttribute("listaNotas", lista);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/notaFiscalXmlJSP/readNotaFiscalXml.jsp");
        dispatcher.forward(request, response);
    }
}