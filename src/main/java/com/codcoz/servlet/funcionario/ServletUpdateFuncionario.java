package com.codcoz.servlet.funcionario;

import com.codcoz.dao.FuncionarioDAO;
import com.codcoz.model.Funcionario;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ServletUpdateFuncionario", value = "/ServletUpdateFuncionario")
public class ServletUpdateFuncionario extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Não utilizado
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Cria o objeto Funcionario com os dados do formulário, incluindo o ID
        Funcionario funcionario = new Funcionario(
                Integer.parseInt(request.getParameter("id")),
                Integer.parseInt(request.getParameter("idEmpresa")),
                Integer.parseInt(request.getParameter("idFuncao")),
                request.getParameter("nome"),
                request.getParameter("sobrenome"),
                request.getParameter("dataAdmissao"),
                request.getParameter("cpf"),
                Double.parseDouble(request.getParameter("salario"))
        );

        // Chama o DAO para fazer o update
        FuncionarioDAO funcionarioDAO = new FuncionarioDAO();
        funcionarioDAO.update(funcionario);

        // Busca a lista atualizada
        List<Funcionario> lista = funcionarioDAO.read();

        // Define a lista como atributo da request
        request.setAttribute("listaFuncionarios", lista);

        // Encaminha para a página JSP de listagem
        RequestDispatcher dispatcher = request.getRequestDispatcher("readFuncionario.jsp");
        dispatcher.forward(request, response);
    }
}