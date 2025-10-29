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
            request.setAttribute("filtro", idBuscarPorEmpresa );
        }else {
            lista = dao.read();
            request.setAttribute("filtro", null );
        }
        // Adiciona a lista como atributo da requisição
        request.setAttribute("listaFuncionarios", lista);
// Verifica se há uma view específica solicitada
        String view = request.getParameter("view");
        String destino;

        if ("create".equals(view)) {
            destino = "/WEB-INF/funcionarioJSP/createFuncionario.jsp";
        } else if ("update".equals(view)) {
            destino = "/WEB-INF/funcionarioJSP/updateFuncionario.jsp";
        } else {
            destino = "/WEB-INF/funcionarioJSP/readFuncionario.jsp";
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher(destino);
        dispatcher.forward(request, response);
    }
}
