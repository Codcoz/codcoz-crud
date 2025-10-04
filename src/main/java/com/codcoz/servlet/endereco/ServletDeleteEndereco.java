package com.codcoz.servlet.endereco;

import com.codcoz.dao.EnderecoDAO;
import com.codcoz.model.Endereco;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

@WebServlet(name = "ServletDeleteEndereco", value = "/ServletDeleteEndereco")
public class ServletDeleteEndereco extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtém o ID do endereço a ser excluído
        int id = Integer.parseInt(request.getParameter("id"));

        // Instancia o DAO e executa a exclusão
        EnderecoDAO enderecoDAO = new EnderecoDAO();
        int status = enderecoDAO.delete(id);

        // Busca os dados do endereço para montar a mensagem
        Endereco endereco = enderecoDAO.buscarPorId(id);
        String resumo = String.format("(%s) %s, rua %s, nº %s — %s",
                endereco.getCep(),
                endereco.getCidade(),
                endereco.getRua(),
                endereco.getNumero(),
                endereco.getEstado());

        // Define a mensagem com base no status da exclusão
        String mensagem;
        switch (status) {
            case 1:
                mensagem = "A exclusão do endereço " + resumo + " foi realizada com sucesso.";
                break;
            case 0:
                mensagem = "A exclusão do endereço " + resumo + " falhou: o endereço está associado a outra tabela. Apague os campos relacionados primeiro.";
                break;
            case -1:
                mensagem = "A exclusão do endereço " + resumo + " falhou: erro interno. Entre em contato pelo e-mail contato.codcoz@gmail.com.";
                break;
            default:
                mensagem = "A exclusão do endereço " + resumo + " falhou: erro desconhecido. Entre em contato pelo e-mail contato.codcoz@gmail.com.";
                break;
        }

        request.setAttribute("mensagem", mensagem);

        // Define a lista como atributo da request
        List<Endereco> lista = enderecoDAO.read();
        request.setAttribute("listaEnderecos", lista);

        // Encaminha para a página JSP mantendo os dados
        RequestDispatcher dispatcher = request.getRequestDispatcher("/enderecoJSP/readEndereco.jsp");
        dispatcher.forward(request, response);
    }
}