package com.codcoz.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexao {
    public Connection conectar() {
        Connection conn = null;
        try {
            Class.forName("org.postgresql.Driver");
            String url = System.getenv("DB_URL");
            String user = System.getenv("DB_USER");
            String pwd = System.getenv("DB_PWD");
            conn = DriverManager.getConnection(
                    url,
                    user,
                    pwd
            );
        } catch (ClassNotFoundException cnfe) {
            cnfe.printStackTrace();
        } catch (SQLException e) {
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