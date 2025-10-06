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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String cep = request.getParameter("cep");

        // Normaliza CEP para apenas dígitos (remove traços, espaços e outros caracteres)
        String cepNormalizado = cep != null ? cep.replaceAll("\\D", "") : "";

        // Regex para CEP com exatamente 8 dígitos (após normalização)
        if (cepNormalizado == null || !cepNormalizado.matches("^\\d{8}$")) {
            request.setAttribute("erroCep", "CEP inválido. Use o formato 00000-000 ou 00000000.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/enderecoJSP/createEndereco.jsp");
            dispatcher.forward(request, response);
            return;
        }

        Endereco endereco = new Endereco(
                request.getParameter("rua"),
                request.getParameter("complemento"),
                request.getParameter("cidade"),
                request.getParameter("estado"),
                cepNormalizado, // usa o CEP normalizado
                request.getParameter("numero")
        );

        // Chama o DAO
        EnderecoDAO dao = new EnderecoDAO();

        // Cria um resumo para mensagens de sucesso/erro
        String resumo = String.format("(%s) %s, rua %s, nº %s — %s",
                endereco.getCep(),
                endereco.getCidade(),
                endereco.getRua(),
                endereco.getNumero(),
                endereco.getEstado());

        String mensagem;
        if (dao.create(endereco)) {
            mensagem = "A criação do endereço " + resumo + " foi realizada com sucesso.";
        } else {
            mensagem = "A criação do endereço " + resumo + " falhou: erro interno. Entre em contato em contato.codcoz@gmail.com.";
        }

        request.setAttribute("mensagem", mensagem);

        // Atualiza lista de endereços e envia para JSP
        List<Endereco> lista = dao.read();
        request.setAttribute("listaEnderecos", lista);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/enderecoJSP/readEndereco.jsp");
        dispatcher.forward(request, response);
    }
}
