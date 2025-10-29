
// Define o pacote da servlet responsável pela criação de funcionários
        package com.codcoz.servlet.funcionario;

// Importa classes para acesso a dados e manipulação de requisições
import com.codcoz.dao.FuncionarioDAO;
import com.codcoz.model.Funcionario;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

// Define a servlet e mapeia sua URL
@WebServlet(name = "ServletCreateFuncionario", value = "/ServletCreateFuncionario")
public class ServletCreateFuncionario extends HttpServlet {

    // Método que trata requisições POST para criar um novo funcionário
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Remove caracteres não numéricos do CPF
        String cpfNormalizado = request.getParameter("cpf").replaceAll("\\D", "");

        // Cria um objeto Funcionario com os dados recebidos do formulário
        Funcionario funcionario = new Funcionario(
                Integer.parseInt(request.getParameter("idEmpresa")),
                request.getParameter("funcao"),
                request.getParameter("nome"),
                request.getParameter("sobrenome"),
                cpfNormalizado,
                request.getParameter("email"),
                request.getParameter("status")
        );

        // Instancia o DAO e executa a criação do funcionário
        FuncionarioDAO dao = new FuncionarioDAO();
        int status = dao.create(funcionario);

        // Define a mensagem de retorno com base no status da operação
        String mensagem;
        switch (status) {
            case 1:
                mensagem = "A criação de " + funcionario.getNome() + " foi realizada com sucesso.";
                break;
            case 0:
                mensagem = "A criação de " + funcionario.getNome() + " falhou: esse CPF já está vinculado.";
                break;
            case -1:
                mensagem = "A criação de " + funcionario.getNome() + " falhou: esse e-mail já está vinculado.";
                break;
            case -2:
                mensagem = "A criação falhou: erro desconhecido. Entre em contato pelo e-mail contato.codcoz@gmail.com.";
                break;
            default:
                mensagem = "A1 criação falhou: erro interno. Entre em contato pelo e-mail contato.codcoz@gmail.com.";
        }

        // Adiciona a mensagem e a lista atualizada de funcionários à requisição
        request.setAttribute("mensagem", mensagem);
        List<Funcionario> lista = dao.read();
        request.setAttribute("listaFuncionarios", lista);

        // Encaminha para a página JSP que exibe os funcionários
        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/funcionarioJSP/readFuncionario.jsp");
        dispatcher.forward(request, response);
    }
}
