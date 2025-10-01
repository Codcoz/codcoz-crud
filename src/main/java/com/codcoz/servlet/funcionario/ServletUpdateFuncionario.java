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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Funcionario funcionario = new Funcionario(
                Integer.parseInt(request.getParameter("id")),
                Integer.parseInt(request.getParameter("idEmpresa")),
                Integer.parseInt(request.getParameter("idFuncao")),
                request.getParameter("nome"),
                request.getParameter("sobrenome"),
                request.getParameter("cpf")
        );

        FuncionarioDAO dao = new FuncionarioDAO();
        dao.update(funcionario);
        List<Funcionario> lista = dao.read();

        request.setAttribute("listaFuncionarios", lista);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/funcionarioJSP/readFuncionario.jsp");
        dispatcher.forward(request, response);
    }
}
