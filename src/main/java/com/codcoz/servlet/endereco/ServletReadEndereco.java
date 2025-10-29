package com.codcoz.servlet.endereco;

import com.codcoz.dao.EnderecoDAO;
import com.codcoz.model.Endereco;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ServletReadEndereco", value = "/ServletReadEndereco")
public class ServletReadEndereco extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Chama o DAO
        EnderecoDAO enderecoDAO = new EnderecoDAO();
        List<Endereco> lista = enderecoDAO.read();

        // Define a lista como atributo da request
        request.setAttribute("listaEnderecos", lista);
        // Verifica se há uma view específica solicitada
        String view = request.getParameter("view");
        String destino;

        if ("create".equals(view)) {
            destino = "/WEB-INF/enderecoJSP/createEndereco.jsp";
        } else if ("update".equals(view)) {
            destino = "/WEB-INF/enderecoJSP/updateEndereco.jsp";
        } else {
            destino = "/WEB-INF/enderecoJSP/readEndereco.jsp";
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher(destino);
        dispatcher.forward(request, response);
    }
}