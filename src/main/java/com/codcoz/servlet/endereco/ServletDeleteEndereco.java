package com.codcoz.servlet.endereco;

import com.codcoz.dao.EnderecoDAO;
import com.codcoz.model.Endereco;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ServletDeleteEndereco", value = "/ServletDeleteEndereco")
public class ServletDeleteEndereco extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        EnderecoDAO enderecoDAO = new EnderecoDAO();
        Endereco endereco = enderecoDAO.buscarPorId(id);

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

        int status = enderecoDAO.delete(id);

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

        request.setAttribute("mensagem", mensagem);

        List<Endereco> lista = enderecoDAO.read();
        request.setAttribute("listaEnderecos", lista);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/enderecoJSP/readEndereco.jsp");
        dispatcher.forward(request, response);
    }
}
