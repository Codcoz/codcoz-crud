package com.codcoz.servlet.produto;

import com.codcoz.dao.ProdutoDAO;
import com.codcoz.model.Produto;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "ServletCreateProduto", value = "/ServletCreateProduto")
public class ServletCreateProduto extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Produto produto = new Produto(
                Integer.parseInt(request.getParameter("id_empresas")),
                Integer.parseInt(request.getParameter("id_ItemNotaFiscal")),
                Integer.parseInt(request.getParameter("id_Unidade_Medida")),
                request.getParameter("nome"),
                Double.parseDouble(request.getParameter("estoqueMinimo")),
                request.getParameter("categoria"),
                request.getParameter("status")
        );

        new ProdutoDAO().create(produto);

        response.sendRedirect("http://localhost:8080/codcoz_crud_war_exploded/");
    }
}
