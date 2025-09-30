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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        FuncionarioDAO dao = new FuncionarioDAO();
        List<Funcionario> lista = dao.read();

        request.setAttribute("listaFuncionarios", lista);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/funcionarioJSP/readFuncionario.jsp");
        dispatcher.forward(request, response);
    }
}
