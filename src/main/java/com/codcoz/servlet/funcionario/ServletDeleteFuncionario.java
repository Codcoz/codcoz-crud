package com.codcoz.servlet.funcionario;

import com.codcoz.dao.FuncionarioDAO;
import com.codcoz.model.Funcionario;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ServletDeleteFuncionario", value = "/ServletDeleteFuncionario")
public class ServletDeleteFuncionario extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Não utilizado
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtém o ID do funcionário a ser deletado
        int id = Integer.parseInt(request.getParameter("id"));

        // Chama o DAO para deletar
        FuncionarioDAO funcionarioDAO = new FuncionarioDAO();
        funcionarioDAO.delete(id);

        // Busca a lista atualizada
        List<Funcionario> lista = funcionarioDAO.read();

        // Define a lista como atributo da request
        request.setAttribute("listaFuncionarios", lista);

        // Encaminha para a página JSP de listagem
        RequestDispatcher dispatcher = request.getRequestDispatcher("readFuncionario.jsp");
        dispatcher.forward(request, response);
    }
}