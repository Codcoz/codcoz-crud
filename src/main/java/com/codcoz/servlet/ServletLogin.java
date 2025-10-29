package com.codcoz.servlet;

import com.codcoz.dao.EnderecoDAO;
import com.codcoz.dao.LoginDAO;
import com.codcoz.model.Usuario;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Optional;

@WebServlet(name = "ServletLogin", value = "/ServletLogin")
    public class ServletLogin extends HttpServlet {
        @Override
        protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            LoginDAO loginDAO = new LoginDAO();
            String mensagemErro = null;
            String redirect = "index.jsp";
            String email = request.getParameter("email");
            Optional<Usuario> usuario = loginDAO.userExists(email);
            if (usuario.isEmpty()){
                mensagemErro = "O email inserido não é de um administrador.";
            } else if (!loginDAO.isPwdCorrect(usuario.get(), request.getParameter("senha"))) {
                mensagemErro = "A senha inserida é incorreta";
            }else {
                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("nomeAdm",usuario.get().getNome());
                request.setAttribute("listaEnderecos", new EnderecoDAO().read());
                redirect = "WEB-INF/enderecoJSP/readEndereco.jsp";
            }
            // Encaminha para a página JSP que exibe os produtos
            request.setAttribute("mensagemErro", mensagemErro);
            RequestDispatcher dispatcher = request.getRequestDispatcher(redirect);
            dispatcher.forward(request, response);
        }

    }
