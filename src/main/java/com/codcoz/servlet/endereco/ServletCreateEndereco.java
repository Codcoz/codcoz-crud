package com.codcoz.servlet.endereco;

import com.codcoz.dao.EnderecoDAO;
import com.codcoz.model.Endereco;
import io.github.cdimascio.dotenv.Dotenv;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ServletCreateEndereco", value = "/ServletCreateEndereco")
public class ServletCreateEndereco extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String cep = request.getParameter("cep");

        // Regex para CEP no formato 00000-000 ou 00000000
        if (cep == null || !cep.matches("^\\d{5}-?\\d{3}$")) {
            request.setAttribute("erroCep", "CEP inválido. Use o formato 00000-000 ou 00000000.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/enderecoJSP/createEndereco.jsp");
            dispatcher.forward(request, response);
            return;
        }

        Endereco endereco = new Endereco(
                request.getParameter("rua"),
                request.getParameter("complemento"),
                request.getParameter("cidade"),
                request.getParameter("estado"),cep,
                request.getParameter("numero")
        );
        // Chama o DAO
        EnderecoDAO dao = new EnderecoDAO();
        dao.create(endereco);
        List<Endereco> lista = dao.read();

        // Define a lista como atributo da request
        request.setAttribute("listaEnderecos", lista);

        // Encaminha para a página JSP mantendo os dados
        RequestDispatcher dispatcher = request.getRequestDispatcher("/enderecoJSP/readEndereco.jsp");
        dispatcher.forward(request, response);
    }
}
