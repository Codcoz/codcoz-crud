package com.codcoz.dao;

import com.codcoz.model.Empresa;
import io.github.cdimascio.dotenv.Dotenv;

import java.sql.Connection;

public class Main {
    public static void main(String[] args) {
        Conexao conexao = new Conexao();
        EmpresaDAO empresaDAO = new EmpresaDAO();
        for (Empresa empresa : empresaDAO.read()) {
            System.out.printf("id: %d; idEndereco: %d; nome: %s; cnpj: %s;\n", empresa.getId(), empresa.getIdEndereco(), empresa.getNome(), empresa.getCnpj());
        }
    }
}
