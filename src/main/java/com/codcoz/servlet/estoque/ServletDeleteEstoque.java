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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
// Coleta o parâmetro do ID enviado na requisição e converte para inteiro
        int id = Integer.parseInt(request.getParameter("id"));

// Instancia o DAO responsável pelas operações de estoque
        EstoqueDAO dao = new EstoqueDAO();
        String mensagem;

// Executa a exclusão do estoque com o ID informado e define a mensagem de retorno
        if (dao.delete(id) > 0) {
            // Caso a exclusão seja bem-sucedida, define mensagem de sucesso
            mensagem = "O estoque com ID " + id + " foi excluído com sucesso.";
        } else {
            // Caso contrário, define mensagem de erro com instrução de contato
            mensagem = "A exclusão do estoque falhou: erro interno. Entre em contato em contato.codcoz@gmail.com";
        }

// Adiciona a mensagem como atributo da requisição para exibição na JSP
        request.setAttribute("mensagem", mensagem);

// Atualiza a lista de estoques após a exclusão
        List<Estoque> lista = dao.read();
        request.setAttribute("listaEstoques", lista);

// Encaminha a requisição para a página JSP que exibe a lista de estoques
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/estoqueJSP/readEstoque.jsp");
        dispatcher.forward(request, response);
    }
}
