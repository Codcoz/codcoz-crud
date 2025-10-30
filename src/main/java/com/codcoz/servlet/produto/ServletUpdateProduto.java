// Define o pacote da servlet responsável por atualizar dados de produto
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
@WebServlet(name = "ServletUpdateProduto", value = "/ServletUpdateProduto")
public class ServletUpdateProduto extends HttpServlet {

    // Método que trata requisições POST para atualizar um produto
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Cria o objeto Produto com os dados recebidos do formulário
        Produto produto = new Produto(
                Integer.parseInt(request.getParameter("id")),
                Integer.parseInt(request.getParameter("idEstoque")),
                Integer.parseInt(request.getParameter("idNotaFiscal")),
                Integer.parseInt(request.getParameter("idEmpresa")),
                request.getParameter("unidadeMedida"),
                request.getParameter("codigoEan"),
                Double.parseDouble(request.getParameter("estoqueMinimo")),
                request.getParameter("nome"),
                request.getParameter("categoria"),
                Integer.parseInt(request.getParameter("quantidade"))
        );

        // Executa a atualização via DAO
        ProdutoDAO dao = new ProdutoDAO();
        int status = dao.update(produto);

        // Define a mensagem de retorno com base no status da operação
        String mensagem;
        switch (status) {
            case 1:
                mensagem = "A atualização de " + produto.getNome() + " foi realizada com sucesso.";
                break;
            case 0:
                mensagem = "A atualização de " + produto.getNome() + " falhou: esse codigo ean já está vinculado.";
                break;
            case -1:
                mensagem = "A atualização falhou: erro desconhecido. Entre em contato pelo e-mail contato.codcoz@gmail.com.";
                break;
            default:
                mensagem = "A atualização falhou: erro interno. Entre em contato pelo e-mail contato.codcoz@gmail.com.";
        }

        // Adiciona a mensagem e a lista atualizada de produtos à requisição
        request.setAttribute("mensagem", mensagem);
        List<Produto> lista = dao.read();

        request.setAttribute("listaProdutos", lista);

        // Encaminha para a página JSP que exibe os produtos
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/produtoJSP/readProduto.jsp");
        dispatcher.forward(request, response);
    }
}