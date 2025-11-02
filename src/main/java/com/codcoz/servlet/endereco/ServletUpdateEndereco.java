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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Normaliza o CEP: remove tudo que não for número
        String cep = request.getParameter("cep").replaceAll("\\D", "");

        // Valida o ID
        Integer id = null;
        try {
            id = Integer.valueOf(request.getParameter("id"));
            if (id <= 0) throw new NumberFormatException();
        } catch (Exception e) {
            request.setAttribute("mensagem", "ID inválido para atualização.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/enderecoJSP/updateEndereco.jsp");
            dispatcher.forward(request, response);
            return;
        }

        // Monta o objeto Endereco
        Endereco endereco = new Endereco(
                id,
                request.getParameter("rua"),
                request.getParameter("complemento"),
                request.getParameter("cidade"),
                request.getParameter("estado"),
                cep,
                request.getParameter("numero")
        );

        // Executa a atualização via DAO e define a mensagem com base no resultado
        EnderecoDAO dao = new EnderecoDAO();
        String mensagem;

        int status = dao.update(endereco);
        if (status == 1) {
            mensagem = "A atualização do endereço foi realizada com sucesso.";
        } else {
            mensagem = "A atualização do endereço falhou: erro interno. Entre em contato em contato.codcoz@gmail.com";
        }

        request.setAttribute("mensagem", mensagem);

        // Atualiza a lista de endereços para exibir na JSP
        List<Endereco> lista = dao.read();
        request.setAttribute("listaEnderecos", lista);

        // Encaminha para a página JSP mantendo os dados
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/enderecoJSP/readEndereco.jsp");
        dispatcher.forward(request, response);
    }
}
