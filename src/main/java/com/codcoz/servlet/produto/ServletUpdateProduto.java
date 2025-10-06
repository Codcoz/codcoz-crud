package com.codcoz.servlet.produto;

import com.codcoz.dao.ProdutoDAO;
import com.codcoz.model.Produto;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ServletUpdateProduto", value = "/ServletUpdateProduto")
public class ServletUpdateProduto extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Produto produto = new Produto(
                Integer.parseInt(request.getParameter("id")),
                Integer.parseInt(request.getParameter("idEmpresa")),
                request.getParameter("unidadeMedida"),
                Double.parseDouble(request.getParameter("estoqueMinimo")),
                request.getParameter("nome"),
                request.getParameter("categoria"),
                Integer.parseInt(request.getParameter("quantidade"))
        );

        ProdutoDAO dao = new ProdutoDAO();
        int status = dao.update(produto);
        String mensagem;
        switch (status) {
            case 1:
                mensagem = "A atualização de " + produto.getNome() + " foi realizada com sucesso.";
                break;
            case 0:
                mensagem = "A atualização de " + produto.getNome() + " falhou: erro interno. Entre em contato pelo e-mail contato.codcoz@gmail.com";
                break;
            default:
                mensagem = "A atualização de " + produto.getNome() + " falhou: erro desconhecido. Entre em contato pelo e-mail contato.codcoz@gmail.com.";
                break;
        }

        request.setAttribute("mensagem", mensagem);
        List<Produto> lista = dao.read();

        request.setAttribute("listaProdutos", lista);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/produtoJSP/readProduto.jsp");
        dispatcher.forward(request, response);
    }
}