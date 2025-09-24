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

@WebServlet(name = "ServletUpdateProduto", value = "/ServletUpdateProduto")
public class ServletUpdateProduto extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //          cria o objeto Endereco já com os dados do form
        Produto produto = new Produto(
                Integer.parseInt(request.getParameter("id")),
                Integer.parseInt(request.getParameter("id_empresa")),
                Integer.parseInt(request.getParameter("id_ItemNotaFiscal")),
                Integer.parseInt(request.getParameter("id_Unidade_Medida")),
                request.getParameter("nome"),
                Double.parseDouble(request.getParameter("estoque_Minimo")),
                request.getParameter("categoria"),
                request.getParameter("status")
        );

//          chama o DAO para update
        ProdutoDAO produtoDAO = new ProdutoDAO();
        produtoDAO.update(produto);
//          redireciona pra o read
        List<Produto> lista = produtoDAO.read();

        // Define a lista como atributo da request
        request.setAttribute("listaProduto", lista);

        // Encaminha para a página JSP mantendo os dados
        RequestDispatcher dispatcher = request.getRequestDispatcher("readProduto.jsp");
        dispatcher.forward(request, response);
    }
    }
