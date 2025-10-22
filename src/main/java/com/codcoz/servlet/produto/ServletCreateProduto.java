// Define o pacote da servlet responsável por criar um novo produto
package com.codcoz.servlet.produto;

// Importa classes para acesso a dados e manipulação de requisições
import com.codcoz.dao.ProdutoDAO;
import com.codcoz.model.Produto;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

// Define a servlet e mapeia sua URL
@WebServlet(name = "ServletCreateProduto", value = "/ServletCreateProduto")
public class ServletCreateProduto extends HttpServlet {

    // Método que trata requisições POST para criar um produto
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Cria o objeto Produto com os dados recebidos do formulário
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

        // Executa a criação via DAO
        ProdutoDAO dao = new ProdutoDAO();
        String mensagem;
        if (dao.create(produto)) {
            mensagem = "A criação de " + produto.getNome() + " foi realizada com sucesso";
        } else {
            mensagem = "A criação falhou: erro interno. Entre em contato em contato.codcoz@gmail.com";
        }

        // Adiciona a mensagem e a lista atualizada de produtos à requisição
        request.setAttribute("mensagem", mensagem);
        List<Produto> lista = dao.read();

        request.setAttribute("listaProdutos", lista);

        // Encaminha para a página JSP que exibe os produtos
        RequestDispatcher dispatcher = request.getRequestDispatcher("/produtoJSP/readProduto.jsp");
        dispatcher.forward(request, response);
    }
}