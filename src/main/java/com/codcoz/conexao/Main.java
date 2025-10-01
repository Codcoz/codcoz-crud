package com.codcoz.conexao;

import io.github.cdimascio.dotenv.Dotenv;
import java.sql.*;

import java.sql.Statement;

public class Main {
    public static void main(String[] args) {

        // Carrega o .env (procura automaticamente na raiz do projeto)
        Dotenv dotenv = Dotenv.configure().ignoreIfMissing().load();


        // Itera sobre todas as variáveis
        dotenv.entries().forEach(entry -> {
            System.out.println(entry.getKey() + " = " + entry.getValue());
        });
    }
}