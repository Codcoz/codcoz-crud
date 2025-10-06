package com.codcoz.servlet.produto;

import com.codcoz.dao.ProdutoDAO;
import com.codcoz.model.Produto;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ServletCreateProduto", value = "/ServletCreateProduto")
public class ServletCreateProduto extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Produto produto = new Produto(
                Integer.parseInt(request.getParameter("idEmpresa")),
                request.getParameter("unidadeMedida"),
                Double.parseDouble(request.getParameter("estoqueMinimo")),
                request.getParameter("nome"),
                request.getParameter("categoria"),
                Integer.parseInt(request.getParameter("quantidade"))
        );

        ProdutoDAO dao = new ProdutoDAO();
        String mensagem;
        if (dao.create(produto)) {
            mensagem = "A criação de " + produto.getNome() + " foi realizada com sucesso";
        } else {
            mensagem = "A criação falhou: erro interno. Entre em contato em contato.codcoz@gmail.com";
        }

        request.setAttribute("mensagem", mensagem);
        dao.create(produto);
        List<Produto> lista = dao.read();

        request.setAttribute("listaProdutos", lista);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/produtoJSP/readProduto.jsp");
        dispatcher.forward(request, response);
    }
}