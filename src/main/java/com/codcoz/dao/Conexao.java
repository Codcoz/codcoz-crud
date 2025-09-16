package com.codcoz.dao;


import io.github.cdimascio.dotenv.Dotenv;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexao {
    public Connection conectar() {
        Connection conn = null;
        try {
            Dotenv dotenv = Dotenv.load();
            String url = dotenv.get("DB_URL");
            String user = dotenv.get("DB_USER");
            String pwd  = dotenv.get("DB_PWD");
            conn = DriverManager.getConnection(url, user, pwd);
            System.out.println("Conexão estabelecida com sucesso.");
        } catch (SQLException e) {
            System.out.println("Erro ao conectar ao banco:");
            e.printStackTrace();
        }
        return conn;
    }
    public void desconectar(Connection conn){
        try{
            if(conn!=null && !conn.isClosed()){
                conn.close();
            }
        }catch (SQLException sqle){
            sqle.printStackTrace();
        }
    }
}