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

        // Lê parâmetros
        String idStr       = request.getParameter("id");
        String rua         = request.getParameter("rua");
        String complemento = request.getParameter("complemento");
        String cidade      = request.getParameter("cidade");
        String estado      = request.getParameter("estado");
        String cep         = request.getParameter("cep");
        String numero      = request.getParameter("numero");

        boolean temErro = false;
        Integer id = null;

        // Validação do ID
        try {
            id = Integer.valueOf(idStr);
            if (id <= 0) throw new NumberFormatException();
        } catch (Exception e) {
            request.setAttribute("erroId", "ID inválido.");
            temErro = true;
        }

        // Validação dos campos obrigatórios
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
            request.setAttribute("idValue", idStr);
            request.setAttribute("ruaValue", rua);
            request.setAttribute("complementoValue", complemento);
            request.setAttribute("cidadeValue", cidade);
            request.setAttribute("estadoValue", estado);
            request.setAttribute("cepValue", cep);
            request.setAttribute("numeroValue", numero);

            RequestDispatcher dispatcher = request.getRequestDispatcher("/enderecoJSP/updateEndereco.jsp");
            dispatcher.forward(request, response);
            return;
        }

        // Normaliza o CEP
        String cepNormalizado = cep.replaceAll("\\D", "");

        // Cria o objeto Endereco
        Endereco endereco = new Endereco(
                id,
                rua,
                complemento,
                cidade,
                estado,
                cepNormalizado,
                numero
        );

        // Chama o DAO
        EnderecoDAO dao = new EnderecoDAO();
        int status = dao.update(endereco);

        // Monta o resumo
        String resumo = String.format("(%s) %s, rua %s, nº %s — %s",
                endereco.getCep(),
                endereco.getCidade(),
                endereco.getRua(),
                endereco.getNumero(),
                endereco.getEstado());

        // Define a mensagem
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

        // Redireciona para a listagem
        List<Endereco> lista = dao.read();
        request.setAttribute("listaEnderecos", lista);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/enderecoJSP/readEndereco.jsp");
        dispatcher.forward(request, response);
    }
}
