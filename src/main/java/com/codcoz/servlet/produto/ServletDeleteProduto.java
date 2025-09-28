package com.codcoz.servlet.produto;

import com.codcoz.dao.EnderecoDAO;
import com.codcoz.dao.ProdutoDAO;
import com.codcoz.model.Endereco;
import com.codcoz.model.Produto;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ServletDeleteProduto", value = "/ServletDeleteProduto")
public class ServletDeleteProduto extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        ProdutoDAO produtoDAO = new ProdutoDAO();
        produtoDAO.delete(id);
        List<Produto> lista = produtoDAO.read();

        // Define a lista como atributo da request
        request.setAttribute("listaEnderecos", lista);

        // Encaminha para a página JSP mantendo os dados
        RequestDispatcher dispatcher = request.getRequestDispatcher("readEmpresa.jsp");
        dispatcher.forward(request, response);
    }
}
