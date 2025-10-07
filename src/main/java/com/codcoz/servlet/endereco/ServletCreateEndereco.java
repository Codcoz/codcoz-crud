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

        // Lê parâmetros
        String rua        = request.getParameter("rua");
        String complemento= request.getParameter("complemento");
        String cidade     = request.getParameter("cidade");
        String estado     = request.getParameter("estado");
        String cep        = request.getParameter("cep");
        String numero     = request.getParameter("numero");

        // Flags de erro
        boolean temErro = false;

        // Validação de campos obrigatórios
        if (rua == null || rua.trim().isEmpty()) {
            request.setAttribute("erroRua", "Rua é obrigatória.");
            temErro = true;
        }
        if (cidade == null || cidade.trim().isEmpty()) {
            request.setAttribute("erroCidade", "Cidade é obrigatória.");
            temErro = true;
        }
        if (estado == null || estado.trim().isEmpty()) {
            request.setAttribute("erroEstado", "Estado é obrigatório.");
            temErro = true;
        }
        if (numero == null || numero.trim().isEmpty()) {
            request.setAttribute("erroNumero", "Número é obrigatório.");
            temErro = true;
        }

        // Validação do CEP
        if (cep == null || !cep.matches("^\\d{5}-?\\d{3}$")) {
            request.setAttribute("erroCep", "CEP inválido. Use o formato 00000-000 ou 00000000.");
            temErro = true;
        }

        // Se houve erro, devolve para o formulário preservando os dados
        if (temErro) {
            request.setAttribute("ruaValue", rua);
            request.setAttribute("complementoValue", complemento);
            request.setAttribute("cidadeValue", cidade);
            request.setAttribute("estadoValue", estado);
            request.setAttribute("cepValue", cep);
            request.setAttribute("numeroValue", numero);

            RequestDispatcher dispatcher = request.getRequestDispatcher("/enderecoJSP/createEndereco.jsp");
            dispatcher.forward(request, response);
            return;
        }

        // Normaliza o CEP
        String cepNormalizado = cep.replaceAll("\\D", "");

        // Cria objeto e persiste
        Endereco endereco = new Endereco(
                rua,
                complemento,
                cidade,
                estado,
                cepNormalizado,
                numero
        );

        EnderecoDAO dao = new EnderecoDAO();
        String resumo = String.format("(%s) %s, rua %s, nº %s — %s",
                endereco.getCep(),
                endereco.getCidade(),
                endereco.getRua(),
                endereco.getNumero(),
                endereco.getEstado());

        String mensagem = dao.create(endereco)
                ? "A criação do endereço " + resumo + " foi realizada com sucesso."
                : "A criação do endereço " + resumo + " falhou: erro interno. Entre em contato em contato.codcoz@gmail.com.";

        // Prepara retorno para a listagem
        request.setAttribute("mensagem", mensagem);
        List<Endereco> lista = dao.read();
        request.setAttribute("listaEnderecos", lista);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/enderecoJSP/readEndereco.jsp");
        dispatcher.forward(request, response);
    }
}
