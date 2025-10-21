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

        // Coleta os parâmetros do formulário
        String rua         = request.getParameter("rua");
        String complemento = request.getParameter("complemento");
        String cidade      = request.getParameter("cidade");
        String estado      = request.getParameter("estado");
        String cepOriginal = request.getParameter("cep");
        String numero      = request.getParameter("numero");

        // Normaliza o CEP: remove tudo que não for número
        String cep = cepOriginal != null ? cepOriginal.replaceAll("\\D", "") : "";

        // Cria o objeto Endereco
        Endereco endereco = new Endereco(
                rua,
                complemento,
                cidade,
                estado,
                cep,
                numero
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
        RequestDispatcher dispatcher = request.getRequestDispatcher("/enderecoJSP/readEndereco.jsp");
        dispatcher.forward(request, response);
    }
}
