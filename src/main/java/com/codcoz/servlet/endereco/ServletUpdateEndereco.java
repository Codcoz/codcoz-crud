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

        // ==== Leitura dos parâmetros ====
        String idStr        = request.getParameter("id");
        String rua          = request.getParameter("rua");
        String complemento  = request.getParameter("complemento");
        String cidade       = request.getParameter("cidade");
        String estado       = request.getParameter("estado");
        String cep          = request.getParameter("cep");
        String numero       = request.getParameter("numero");

        boolean temErro = false;
        Integer id = null;

        // ==== Validações básicas ====
        try {
            id = Integer.valueOf(idStr);
            if (id <= 0) throw new NumberFormatException();
        } catch (Exception e) {
            request.setAttribute("erroId", "ID inválido.");
            temErro = true;
        }

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
        if (cep == null || cep.trim().isEmpty()) {
            request.setAttribute("erroCep", "Cep e obrigatorio");
        }
        if (numero == null || numero.trim().isEmpty()) {
            request.setAttribute("erroNumero", "Número é obrigatório.");
            temErro = true;
        }
        if (complemento == null || complemento.trim().isEmpty()) {
            request.setAttribute("erroComplemento","Complemento e Obrigatorio");
            temErro = true;
        }

        if (temErro) {
            // Preserva valores para o formulário de update
            request.setAttribute("idValue", idStr);
            request.setAttribute("ruaValue", rua);
            request.setAttribute("complementoValue", complemento);
            request.setAttribute("cidadeValue", cidade);
            request.setAttribute("estadoValue", estado);
            request.setAttribute("cepValue", cep);
            request.setAttribute("numeroValue", numero);

            RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/enderecoJSP/updateEndereco.jsp");
            dispatcher.forward(request, response);
            return;
        }

        // ==== Normalização ====
        String cepNormalizado = cep.replaceAll("\\D", "");

        // ==== Monta objeto ====
        Endereco endereco = new Endereco(
                id,
                rua,
                complemento,
                cidade,
                estado,
                cepNormalizado,
                numero
        );

        try {
            // ==== Executa update ====
            EnderecoDAO dao = new EnderecoDAO();
            int status = dao.update(endereco);

            // ==== Mensagem conforme status ====
            String resumo = String.format("(%s) %s, rua %s, nº %s — %s",
                    endereco.getCep(),
                    endereco.getCidade(),
                    endereco.getRua(),
                    endereco.getNumero(),
                    endereco.getEstado());

            String mensagem;
            switch (status) {
                case 1:
                    mensagem = "A atualização do endereço " + resumo + " foi realizada com sucesso.";
                    break;
                case 0:
                    mensagem = "A atualização do endereço " + resumo + " falhou: erro interno. " +
                            "Entre em contato pelo e-mail contato.codcoz@gmail.com.";
                    break;
                default:
                    mensagem = "A atualização do endereço " + resumo + " falhou: erro desconhecido. " +
                            "Entre em contato pelo e-mail contato.codcoz@gmail.com.";
            }

            request.setAttribute("mensagem", mensagem);

            // ==== Recarrega listagem ====
            List<Endereco> lista = dao.read();
            request.setAttribute("listaEnderecos", lista);

            RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/enderecoJSP/readEndereco.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();

            request.setAttribute("mensagem", "Erro interno ao atualizar o endereço. Tente novamente mais tarde.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/enderecoJSP/updateEndereco.jsp");
            dispatcher.forward(request, response);
        }
    }
}