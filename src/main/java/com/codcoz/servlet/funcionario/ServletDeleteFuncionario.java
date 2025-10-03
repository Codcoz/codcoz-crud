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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        FuncionarioDAO dao = new FuncionarioDAO();
        dao.delete(id);
        List<Funcionario> lista = dao.read();

        request.setAttribute("listaFuncionarios", lista);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/funcionarioJSP/readFuncionario.jsp");
        dispatcher.forward(request, response);
    }
}
