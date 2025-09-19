package com.codcoz.servlet.endereco;

import com.codcoz.dao.EnderecoDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "ServletDeleteEndereco", value = "/ServletDeleteEndereco")
public class ServletDeleteEndereco extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        EnderecoDAO enderecoDAO = new EnderecoDAO();
        enderecoDAO.delete(id);
        response.sendRedirect("http://localhost:8080/codcoz_crud_war_exploded/");
    }
}
