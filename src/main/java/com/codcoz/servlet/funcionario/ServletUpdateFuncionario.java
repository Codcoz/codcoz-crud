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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Cria o objeto Funcionario com os dados do formulário
        Funcionario funcionario = new Funcionario(
                Integer.parseInt(request.getParameter("id")),
                Integer.parseInt(request.getParameter("idEmpresa")),
                request.getParameter("funcao"),
                request.getParameter("nome"),
                request.getParameter("sobrenome"),
                request.getParameter("cpf")
        );

        // Chama o DAO para atualizar
        FuncionarioDAO dao = new FuncionarioDAO();
        dao.update(funcionario);

        // Recupera lista atualizada
        List<Funcionario> lista = dao.read();
        request.setAttribute("listaFuncionarios", lista);

        // Encaminha para a página JSP
        RequestDispatcher dispatcher = request.getRequestDispatcher("/funcionarioJSP/readFuncionario.jsp");
        dispatcher.forward(request, response);
    }
}
