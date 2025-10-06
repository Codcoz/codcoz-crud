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
                Integer.parseInt(request.getParameter("idEstoque")),
                Integer.parseInt(request.getParameter("idNotaFiscal")),
                Integer.parseInt(request.getParameter("idEmpresa")),
                request.getParameter("unidadeMedida"),
                Double.parseDouble(request.getParameter("estoqueMinimo")),
                request.getParameter("nome"),
                request.getParameter("categoria"),
                Integer.parseInt(request.getParameter("quantidade"))
        );

        ProdutoDAO dao = new ProdutoDAO();
        dao.create(produto);
        List<Produto> lista = dao.read();

        request.setAttribute("listaProdutos", lista);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/produtoJSP/readProduto.jsp");
        dispatcher.forward(request, response);
    }
}