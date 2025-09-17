package com.codcoz.conexao;

import com.codcoz.dao.EnderecoDAO;
import com.codcoz.model.Empresa;
import com.codcoz.model.Endereco;
import io.github.cdimascio.dotenv.Dotenv;

import java.sql.Connection;

public class Main {
    public static void main(String[] args) {
        Dotenv dotenv = Dotenv.load();
        System.out.println(dotenv.get("DB_URL"));
        System.out.println(dotenv.get("DB_USER"));
        System.out.println(dotenv.get("DB_PWD"));


        EnderecoDAO enderecoDAO = new EnderecoDAO();
//        for (Empresa empresa : empresaDAO.read()) {
//            System.out.printf("id: %d; idEndereco: %d; nome: %s; cnpj: %s;\n", empresa.getId(), empresa.getIdEndereco(), empresa.getNome(), empresa.getCnpj());
//        }
        enderecoDAO.update(new Endereco(1,"rua","1","1","SP","12345678","5"));
    }
}
