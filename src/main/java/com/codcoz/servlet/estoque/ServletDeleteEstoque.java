package com.codcoz.servlet.estoque;

import com.codcoz.dao.EstoqueDAO;
import com.codcoz.model.Estoque;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ServletDeleteEstoque", value = "/ServletDeleteEstoque")
public class ServletDeleteEstoque extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Coleta o parâmetro do ID
        int id = Integer.parseInt(request.getParameter("id"));

        // Executa a exclusão via DAO e define a mensagem com base no resultado
        EstoqueDAO dao = new EstoqueDAO();
        String mensagem;

        if (dao.delete(id) > 0) {
            mensagem = "O estoque com ID " + id + " foi excluído com sucesso.";
        } else {
            mensagem = "A exclusão do estoque falhou: erro interno. Entre em contato em contato.codcoz@gmail.com";
        }

        request.setAttribute("mensagem", mensagem);

        // Atualiza a lista de estoques para exibir na JSP
        List<Estoque> lista = dao.read();
        request.setAttribute("listaEstoques", lista);

        // Encaminha para a página JSP mantendo os dados
        RequestDispatcher dispatcher = request.getRequestDispatcher("/estoqueJSP/readEstoque.jsp");
        dispatcher.forward(request, response);
    }
}
