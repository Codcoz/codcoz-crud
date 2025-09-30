package com.codcoz.conexao;

import java.sql.*;

import java.sql.Statement;

public class Main {
    public static void main(String[] args) {
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();

        try {
            Statement statement = conn.createStatement();
            statement.execute("ALTER TABLE item_nota_fiscal ADD COLUMN id_empresa INT NOT NULL, ADD CONSTRAINT fk_item_empresa FOREIGN KEY (id_empresa) REFERENCES empresa(id);");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}