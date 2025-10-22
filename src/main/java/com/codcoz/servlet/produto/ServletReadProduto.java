// Define o pacote da servlet responsável por listar produtos
package com.codcoz.servlet.produto;

// Importa classes para acesso a dados e manipulação de requisições
import com.codcoz.dao.ProdutoDAO;
import com.codcoz.model.Produto;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import jakarta.ws.rs.core.Request;
import jakarta.ws.rs.core.Response;

import java.io.IOException;
import java.util.List;

// Define a servlet e mapeia sua URL
@WebServlet(name = "ServletReadProduto", value = "/ServletReadProduto")
public class ServletReadProduto extends HttpServlet {

    // Método que trata requisições GET para listar os produtos
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Recupera a lista de produtos do banco de dados
        ProdutoDAO dao = new ProdutoDAO();
        List<Produto> lista;
        String idBuscarPorEmpresa = request.getParameter("buscarPorEmpresa");
        if (idBuscarPorEmpresa!=null){
             lista = dao.buscarPorEmpresa(Integer.parseInt(idBuscarPorEmpresa));
        }else {
             lista = dao.read();
        }
        // Adiciona a lista como atributo da requisição
        request.setAttribute("listaProdutos", lista);

        // Encaminha a requisição para a página JSP que exibirá os dados
        RequestDispatcher dispatcher = request.getRequestDispatcher("/produtoJSP/readProduto.jsp");
        dispatcher.forward(request, response);
    }
}
