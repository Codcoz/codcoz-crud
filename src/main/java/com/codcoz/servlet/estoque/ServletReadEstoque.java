// Define o pacote onde esta servlet está localizada
        package com.codcoz.servlet.estoque;

// Importa a classe DAO responsável por acessar os dados de estoque
import com.codcoz.dao.EstoqueDAO;
// Importa o modelo Estoque que representa os dados da entidade
import com.codcoz.model.Estoque;
// Importa as classes necessárias para trabalhar com servlets
import com.codcoz.model.Produto;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

// Importa classes utilitárias para manipulação de exceções e listas
import java.io.IOException;
import java.util.List;

// Define a servlet com nome "ServletReadEstoque" e mapeia sua URL para "/ServletReadEstoque"
@WebServlet(name = "ServletReadEstoque", value = "/ServletReadEstoque")
public class ServletReadEstoque extends HttpServlet {

    // Método que responde a requisições HTTP do tipo GET
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Instancia o DAO para acessar os dados de estoque
        EstoqueDAO dao = new EstoqueDAO();

        List<Estoque> lista;
        String idBuscarPorEmpresa = request.getParameter("buscarPorEmpresa");
        if (idBuscarPorEmpresa!=null){
            lista = dao.buscarPorEmpresa(Integer.parseInt(idBuscarPorEmpresa));
            request.setAttribute("filtro", idBuscarPorEmpresa );
        }else {
            lista = dao.read();
            request.setAttribute("filtro", null );
        }
        // Adiciona a lista como atributo da requisição para ser acessada na JSP
        request.setAttribute("listaEstoques", lista);

        // Encaminha a requisição para a página JSP que exibirá os dados
        RequestDispatcher dispatcher = request.getRequestDispatcher("/estoqueJSP/readEstoque.jsp");
        dispatcher.forward(request, response);
    }
}