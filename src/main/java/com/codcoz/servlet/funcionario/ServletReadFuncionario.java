package com.codcoz.servlet.funcionario;

import com.codcoz.dao.FuncionarioDAO;
import com.codcoz.model.Funcionario;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ServletReadFuncionario", value = "/ServletReadFuncionario")
public class ServletReadFuncionario extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Chama o DAO para buscar a lista de funcionários
        FuncionarioDAO funcionarioDAO = new FuncionarioDAO();
        List<Funcionario> lista = funcionarioDAO.read();

        // Define a lista como atributo da request
        request.setAttribute("listaFuncionarios", lista);

        // Encaminha para a página JSP para exibição
        RequestDispatcher dispatcher = request.getRequestDispatcher("readFuncionario.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Pode redirecionar para o doGet se necessário
        doGet(request, response);
    }
}