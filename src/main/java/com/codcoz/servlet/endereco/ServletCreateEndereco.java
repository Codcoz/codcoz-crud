package com.codcoz.servlet.endereco;

import com.codcoz.dao.EnderecoDAO;
import com.codcoz.model.Endereco;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ServletCreateEndereco", value = "/ServletCreateEndereco")
public class ServletCreateEndereco extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Normaliza o CEP: remove tudo que não for número Usando REGEX
        String cep = request.getParameter("cep").replaceAll("\\D", "");

        Endereco endereco = new Endereco(
                request.getParameter("rua"),
                request.getParameter("complemento"),
                request.getParameter("cidade"),
                request.getParameter("estado"),
                request.getParameter("cep"),
                request.getParameter("numero")
        );

        // Executa a criação via DAO e define a mensagem com base no resultado
        EnderecoDAO dao = new EnderecoDAO();
        String mensagem;

        if (dao.create(endereco)) {
            mensagem = "A criação do endereço foi realizada com sucesso.";
        } else {
            mensagem = "A criação do endereço falhou: erro interno. Entre em contato em contato.codcoz@gmail.com";
        }

        request.setAttribute("mensagem", mensagem);

        //  Atualiza a lista de endereços para exibir na JSP
        List<Endereco> lista = dao.read();
        request.setAttribute("listaEnderecos", lista);

        //  Encaminha para a página JSP mantendo os dados
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/enderecoJSP/readEndereco.jsp");
        dispatcher.forward(request, response);
    }
}
