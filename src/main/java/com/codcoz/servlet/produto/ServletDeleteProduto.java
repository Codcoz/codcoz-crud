package com.codcoz.servlet.produto;

import com.codcoz.dao.EmpresaDAO;
import com.codcoz.dao.ProdutoDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;
import com.codcoz.model.Produto;

@WebServlet(name = "ServletDeleteProduto", value = "/ServletDeleteProduto")
public class ServletDeleteProduto extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtém o ID da empresa a ser excluída
        int id = Integer.parseInt(request.getParameter("id"));

        ProdutoDAO dao = new ProdutoDAO();
        // Busca o nome da empresa para montar a mensagem
        String produto = dao.buscarPorId(id).getNome();

        // Executa a exclusão via DAO e recebe o status da operação
        int status = dao.delete(id);
        String mensagem;
        switch (status) {
            case 1:
                mensagem = "A exclusão de " + produto + " foi realizada com sucesso.";
                break;
            case 0:
                mensagem = "A exclusão falhou: a empresa " + produto + " está associada a outra tabela. Apague os campos relacionados primeiro.";
                break;
            case -1:
                mensagem = "A exclusão de " + produto + " falhou: erro interno. Entre em contato pelo e-mail contato.codcoz@gmail.com.";
                break;
            default:
                mensagem = "A exclusão de " + produto + " falhou: erro desconhecido. Entre em contato pelo e-mail contato.codcoz@gmail.com.";
                break;
        }

        request.setAttribute("mensagem", mensagem);
        List<Produto> lista = dao.read();

        request.setAttribute("listaProdutos", lista);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/produtoJSP/readProduto.jsp");
        dispatcher.forward(request, response);
    }
}