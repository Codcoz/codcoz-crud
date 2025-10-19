package com.codcoz.servlet.funcionario;

import com.codcoz.dao.FuncionarioDAO;
import com.codcoz.model.Funcionario;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ServletCreateFuncionario", value = "/ServletCreateFuncionario")
public class ServletCreateFuncionario extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lê parâmetros do formulário
        String idEmpresaStr = request.getParameter("idEmpresa");
        String funcao       = request.getParameter("funcao");
        String nome         = request.getParameter("nome");
        String sobrenome    = request.getParameter("sobrenome");
        String cpf          = request.getParameter("cpf");
        String email        = request.getParameter("email");
        String status       = request.getParameter("status");

        boolean temErro = false;

        // Validação: idEmpresa numérico e > 0
        Integer idEmpresa = null;
        try {
            idEmpresa = Integer.valueOf(idEmpresaStr);
            if (idEmpresa <= 0) throw new NumberFormatException();
        } catch (Exception e) {
            request.setAttribute("erroIdEmpresa", "ID da empresa inválido.");
            temErro = true;
        }

        // Validações de obrigatoriedade
        if (nome == null || nome.trim().isEmpty()) {
            request.setAttribute("erroNome", "Nome é obrigatório.");
            temErro = true;
        }
        if (sobrenome == null || sobrenome.trim().isEmpty()) {
            request.setAttribute("erroSobrenome", "Sobrenome é obrigatório.");
            temErro = true;
        }
        if (funcao == null || funcao.trim().isEmpty()) {
            request.setAttribute("erroFuncao", "Função é obrigatória.");
            temErro = true;
        }
        if (cpf == null || cpf.trim().isEmpty()) {
            request.setAttribute("erroCpf", "Cpf é obrigatório.");
            temErro = true;
        }
        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("erroEmail", "E-mail é obrigatório.");
            temErro = true;
        }
        if (status == null || status.trim().isEmpty()) {
            request.setAttribute("erroStatus", "Status é obrigatório.");
            temErro = true;
        }

        // Se houve erro, volta ao formulário com os valores preenchidos
        if (temErro) {
            request.setAttribute("idEmpresaValue", idEmpresaStr);
            request.setAttribute("funcaoValue", funcao);
            request.setAttribute("nomeValue", nome);
            request.setAttribute("sobrenomeValue", sobrenome);
            request.setAttribute("cpfValue", cpf);
            request.setAttribute("emailValue", email);
            request.setAttribute("statusValue", status);

            RequestDispatcher dispatcher = request.getRequestDispatcher("/funcionarioJSP/createFuncionario.jsp");
            dispatcher.forward(request, response);
            return;
        }

        // Normaliza CPF para apenas dígitos
        String cpfNormalizado = cpf.replaceAll("\\D", "");

        // Monta o objeto de domínio
        Funcionario funcionario = new Funcionario(
                idEmpresa,
                funcao,
                nome,
                sobrenome,
                cpfNormalizado,
                email,
                status
        );

        // Persiste e monta mensagem de retorno
        FuncionarioDAO dao = new FuncionarioDAO();
        String mensagem = dao.create(funcionario)
                ? "A criação de " + nome + " " + sobrenome + " foi realizada com sucesso."
                : "A criação falhou: erro interno. Entre em contato em contato.codcoz@gmail.com";

        // Prepara retorno para a listagem
        request.setAttribute("mensagem", mensagem);
        List<Funcionario> lista = dao.read();
        request.setAttribute("listaFuncionarios", lista);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/funcionarioJSP/readFuncionario.jsp");
        dispatcher.forward(request, response);
    }
}
