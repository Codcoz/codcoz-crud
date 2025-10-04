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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Cria o objeto Endereco com os dados do formulário
        Endereco endereco = new Endereco(
                Integer.parseInt(request.getParameter("id")),
                request.getParameter("rua"),
                request.getParameter("complemento"),
                request.getParameter("cidade"),
                request.getParameter("estado"),
                request.getParameter("cep"),
                request.getParameter("numero")
        );

        // Chama o DAO para atualizar
        EnderecoDAO enderecoDAO = new EnderecoDAO();
        int status = enderecoDAO.update(endereco);

        // Monta o resumo do endereço
        String resumo = String.format("(%s) %s, rua %s, nº %s — %s",
                endereco.getCep(),
                endereco.getCidade(),
                endereco.getRua(),
                endereco.getNumero(),
                endereco.getEstado());

        // Define a mensagem com base no status
        String mensagem;
        switch (status) {
            case 1:
                mensagem = "A atualização do endereço " + resumo + " foi realizada com sucesso.";
                break;
            case 0:
                mensagem = "A atualização do endereço " + resumo + " falhou: erro interno. Entre em contato pelo e-mail contato.codcoz@gmail.com.";
                break;
            default:
                mensagem = "A atualização do endereço " + resumo + " falhou: erro desconhecido. Entre em contato pelo e-mail contato.codcoz@gmail.com.";
                break;
        }

        request.setAttribute("mensagem", mensagem);

        // Redireciona para o read
        List<Endereco> lista = enderecoDAO.read();
        request.setAttribute("listaEnderecos", lista);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/enderecoJSP/readEndereco.jsp");
        dispatcher.forward(request, response);
    }
}