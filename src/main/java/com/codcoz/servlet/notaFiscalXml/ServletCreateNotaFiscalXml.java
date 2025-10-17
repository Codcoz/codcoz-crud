package com.codcoz.servlet.notaFiscalXml;

import com.codcoz.dao.EstoqueDAO;
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
        // Executa a criação via DAO e define a mensagem com base no resultado
        NotaFiscalXmlDAO dao = new NotaFiscalXmlDAO();
        String mensagem;

        if (dao.create(nota)) {
            mensagem = "O estoque do tipo \"" + nota.getNumeroNota() + "\" foi criado com sucesso.";
        } else {
            mensagem = "A criação do estoque falhou: erro interno. Entre em contato em contato.codcoz@gmail.com";
        }
        request.setAttribute("mensagem",mensagem);
        // Atualiza a lista de nota fiscal xml para exibir na JSP
        List<NotaFiscalXml> lista = dao.read();
        request.setAttribute("listaNotas", lista);

        // Encaminha para a página JSP mantendo os dados
        RequestDispatcher dispatcher = request.getRequestDispatcher("/notaFiscalXmlJSP/readNotaFiscalXml.jsp");
        dispatcher.forward(request, response);
    }
}