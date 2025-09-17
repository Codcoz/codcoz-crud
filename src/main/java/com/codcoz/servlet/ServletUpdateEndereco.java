package com.codcoz.servlet;

import com.codcoz.dao.EnderecoDAO;
import com.codcoz.model.Endereco;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "ServletUpdateEndereco", value = "/ServletUpdateEndereco")
public class ServletUpdateEndereco extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//          cria o objeto Endereco já com os dados do form
        Endereco endereco = new Endereco(
            Integer.parseInt(request.getParameter("id1")),
            request.getParameter("rua1"),
            request.getParameter("complemento1"),
            request.getParameter("cidade1"),
            request.getParameter("estado1"),
            request.getParameter("cep1"),
            request.getParameter("numero1")
        );

//          chama o DAO para update
        EnderecoDAO enderecoDAO = new EnderecoDAO();
        enderecoDAO.update(endereco);
//          redireciona pra mesma pagina
        response.sendRedirect("http://localhost:8080/codcoz_crud_war_exploded/");
    }
}
