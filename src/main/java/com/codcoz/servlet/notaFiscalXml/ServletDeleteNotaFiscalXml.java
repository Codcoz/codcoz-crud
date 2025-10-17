package com.codcoz.servlet.notaFiscalXml;

import com.codcoz.dao.EstoqueDAO;
import com.codcoz.dao.NotaFiscalXmlDAO;
import com.codcoz.model.Endereco;
import com.codcoz.model.Estoque;
import com.codcoz.model.NotaFiscalXml;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ServletDeleteNotaFiscalXml", value = "/ServletDeleteNotaFiscalXml")
public class ServletDeleteNotaFiscalXml extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Coleta o parâmetro do ID
        int id = Integer.parseInt(request.getParameter("id"));

        // Executa a exclusão via DAO e define a mensagem com base no resultado
        NotaFiscalXmlDAO dao = new NotaFiscalXmlDAO();
        NotaFiscalXml nota = dao.buscarPorId(id);

        String resumo;
        if (nota == null) {
            resumo = "endereço não encontrado (ID: " + id + ")";
        } else {
            resumo = nota.getNumeroNota();
        }

        int status = dao.delete(id);

        String mensagem;
        switch (status) {
            case 1:
                mensagem = "A exclusão da nota " + resumo + " foi realizada com sucesso.";
                break;
            case 0:
                mensagem = "A exclusão da nota " + resumo + " falhou: a nota está associado a outra tabela.";
                break;
            case -1:
                mensagem = "A exclusão da nota " + resumo + " falhou: erro interno.";
                break;
            default:
                mensagem = "A exclusão da nota " + resumo + " falhou: erro desconhecido.";
                break;
        }

        request.setAttribute("mensagem", mensagem);

        // Atualiza a lista de notas para exibir na JSP
        List<NotaFiscalXml> lista = dao.read();
        request.setAttribute("listaNotas", lista);

        // Encaminha para a página JSP mantendo os dados
        RequestDispatcher dispatcher = request.getRequestDispatcher("/notaFiscalXmlJSP/readNotaFiscalXml.jsp");
        dispatcher.forward(request, response);
    }
}