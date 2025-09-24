package com.codcoz.servlet.endereco;

import com.codcoz.dao.EnderecoDAO;
import com.codcoz.model.Endereco;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ServletUpdateEndereco", value = "/ServletUpdateEndereco")
public class ServletUpdateEndereco extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//          cria o objeto Endereco já com os dados do form
        Endereco endereco = new Endereco(
            Integer.parseInt(request.getParameter("id")),
            request.getParameter("rua"),
            request.getParameter("complemento"),
            request.getParameter("cidade"),
            request.getParameter("estado"),
            request.getParameter("cep"),
            request.getParameter("numero")
        );

//          chama o DAO para update
        EnderecoDAO enderecoDAO = new EnderecoDAO();
        enderecoDAO.update(endereco);
//          redireciona pra o read
        List<Endereco> lista = enderecoDAO.read();

        // Define a lista como atributo da request
        request.setAttribute("listaEnderecos", lista);

        // Encaminha para a página JSP mantendo os dados
        RequestDispatcher dispatcher = request.getRequestDispatcher("readEndereco.jsp");
        dispatcher.forward(request, response);
    }
}
