package com.codcoz.servlet.funcionario;

import com.codcoz.dao.FuncionarioDAO;
import com.codcoz.model.Funcionario;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ServletCreateFuncionario", value = "/ServletCreateFuncionario")
public class ServletCreateFuncionario extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Funcionario funcionario = new Funcionario(
                Integer.parseInt(request.getParameter("idEmpresa")),
                Integer.parseInt(request.getParameter("idFuncao")),
                request.getParameter("nome"),
                request.getParameter("sobrenome"),
                request.getParameter("cpf")
        );

        FuncionarioDAO dao = new FuncionarioDAO();
        dao.create(funcionario);
        List<Funcionario> lista = dao.read();

        request.setAttribute("listaFuncionarios", lista);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/funcionarioJSP/readFuncionario.jsp");
        dispatcher.forward(request, response);
    }
}
