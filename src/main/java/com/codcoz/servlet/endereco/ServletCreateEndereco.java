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

        // ==== Leitura dos parâmetros ====
        String rua         = request.getParameter("rua");
        String complemento = request.getParameter("complemento");
        String cidade      = request.getParameter("cidade");
        String estado      = request.getParameter("estado");
        String cep         = request.getParameter("cep");
        String numero      = request.getParameter("numero");

        boolean temErro = false;

        // ==== Validações básicas ====
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
        if (complemento == null || complemento.trim().isEmpty()) {
            request.setAttribute("erroComplemento","Complemento e Obrigatorio");
            temErro = true;
        }

        // ==== Validação do CEP ====
        if (cep == null || !cep.matches("^\\d{5}-?\\d{3}$")) {
            request.setAttribute("erroCep", "CEP inválido. Use o formato 00000-000 ou 00000000.");
            temErro = true;
        }

        if (temErro) {
            // Preserva valores para o formulário de criação
            request.setAttribute("ruaValue", rua);
            request.setAttribute("complementoValue", complemento);
            request.setAttribute("cidadeValue", cidade);
            request.setAttribute("estadoValue", estado);
            request.setAttribute("cepValue", cep);
            request.setAttribute("numeroValue", numero);

            // Volta para o formulário de criação
            RequestDispatcher dispatcher = request.getRequestDispatcher("/enderecoJSP/createEndereco.jsp");
            dispatcher.forward(request, response);
            return;
        }

        // ==== Normalização ====
        String cepNormalizado = cep.replaceAll("\\D", "");

        // ==== Criação do objeto ====
        Endereco endereco = new Endereco(
                rua,
                complemento,
                cidade,
                estado,
                cepNormalizado,
                numero
        );

        try {
            // ==== Chama o DAO ====
            EnderecoDAO dao = new EnderecoDAO();
            boolean criado = dao.create(endereco);

            // ==== Monta resumo e mensagem ====
            String resumo = String.format("(%s) %s, rua %s, nº %s — %s",
                    endereco.getCep(),
                    endereco.getCidade(),
                    endereco.getRua(),
                    endereco.getNumero(),
                    endereco.getEstado());

            String mensagem;
            if (criado) {
                mensagem = "A criação do endereço " + resumo + " foi realizada com sucesso.";
            } else {
                mensagem = "A criação do endereço " + resumo + " falhou: erro interno. " +
                        "Entre em contato pelo e-mail contato.codcoz@gmail.com.";
            }

            request.setAttribute("mensagem", mensagem);

            // ==== Recarrega listagem ====
            List<Endereco> lista = dao.read();
            request.setAttribute("listaEnderecos", lista);

            RequestDispatcher dispatcher = request.getRequestDispatcher("/enderecoJSP/readEndereco.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            // ==== Tratamento de erro ====
            e.printStackTrace(); // ou use um Logger em produção

            request.setAttribute("mensagem", "Erro interno ao processar o endereço. Tente novamente mais tarde.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/enderecoJSP/createEndereco.jsp");
            dispatcher.forward(request, response);
        }
    }
}