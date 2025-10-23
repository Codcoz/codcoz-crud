// Define o pacote da servlet responsável por listar funcionários
package com.codcoz.servlet.funcionario;

// Importa classes para acesso a dados e manipulação de requisições
import com.codcoz.dao.FuncionarioDAO;
import com.codcoz.model.Estoque;
import com.codcoz.model.Funcionario;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

// Define a servlet e mapeia sua URL
@WebServlet(name = "ServletReadFuncionario", value = "/ServletReadFuncionario")
public class ServletReadFuncionario extends HttpServlet {

    // Método que trata requisições GET para listar os funcionários
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Recupera a lista de funcionários do banco de dados
        FuncionarioDAO dao = new FuncionarioDAO();
        List<Funcionario> lista;
        String idBuscarPorEmpresa = request.getParameter("buscarPorEmpresa");
        if (idBuscarPorEmpresa!=null){
            lista = dao.buscarPorEmpresa(Integer.parseInt(idBuscarPorEmpresa));
        }else {
            lista = dao.read();
        }
        // Adiciona a lista como atributo da requisição
        request.setAttribute("listaFuncionarios", lista);

        // Encaminha a requisição para a página JSP que exibirá os dados
        RequestDispatcher dispatcher = request.getRequestDispatcher("/funcionarioJSP/readFuncionario.jsp");
        dispatcher.forward(request, response);
    }
}
