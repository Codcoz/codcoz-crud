// Define o pacote da servlet responsável pela exclusão de endereços
        package com.codcoz.servlet.endereco;

// Importa classes necessárias para acesso a dados e manipulação de requisições
import com.codcoz.dao.EnderecoDAO;
import com.codcoz.model.Endereco;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

// Define a servlet e mapeia sua URL
@WebServlet(name = "ServletDeleteEndereco", value = "/ServletDeleteEndereco")
public class ServletDeleteEndereco extends HttpServlet {

    // Método que trata requisições GET para excluir um endereço
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtém o ID do endereço a ser excluído
        int id = Integer.parseInt(request.getParameter("id"));

        // Busca o endereço pelo ID
        EnderecoDAO enderecoDAO = new EnderecoDAO();
        Endereco endereco = enderecoDAO.buscarPorId(id);

        // Gera um resumo textual do endereço para exibir na mensagem
        String resumo;
        if (endereco == null) {
            resumo = "endereço não encontrado (ID: " + id + ")";
        } else {
            resumo = String.format("(%s) %s, rua %s, nº %s — %s",
                    endereco.getCep(),
                    endereco.getCidade(),
                    endereco.getRua(),
                    endereco.getNumero(),
                    endereco.getEstado());
        }

        // Executa a exclusão e armazena o status retornado
        int status = enderecoDAO.delete(id);

        // Define a mensagem com base no status da exclusão
        String mensagem;
        switch (status) {
            case 1:
                mensagem = "A exclusão do endereço " + resumo + " foi realizada com sucesso.";
                break;
            case 0:
                mensagem = "A exclusão do endereço " + resumo + " falhou: o endereço está associado a outra tabela.";
                break;
            case -1:
                mensagem = "A exclusão do endereço " + resumo + " falhou: erro interno.";
                break;
            default:
                mensagem = "A exclusão do endereço " + resumo + " falhou: erro desconhecido.";
                break;
        }

        // Adiciona a mensagem à requisição
        request.setAttribute("mensagem", mensagem);

        // Atualiza a lista de endereços para exibição
        List<Endereco> lista = enderecoDAO.read();
        request.setAttribute("listaEnderecos", lista);

        // Encaminha para a página JSP que exibe os endereços
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/enderecoJSP/readEndereco.jsp");
        dispatcher.forward(request, response);
    }
}