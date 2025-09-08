package com.codcoz.dao;

import com.codcoz.model.Empresa;

import java.sql.*;

public class EmpresaDAO {

    public void create(Empresa empresa) {
        String sql = "INSERT INTO empresa (id_endereco, nome, cnpj) VALUES (?, ?, ?)";
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);

            pstmt.setInt(1, empresa.getIdEndereco() );
            pstmt.setString(2, empresa.getNome());
            pstmt.setString(3, empresa.getCnpj());

            pstmt.executeUpdate();
            System.out.println("create de empresa com sucesso");
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
        conexao.desconectar(conn);
    }
    public ResultSet read() {
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        ResultSet rs = null;
        try {
            Statement stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT * FROM Empresa");
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
        conexao.desconectar(conn);
        return rs;
    }
    public void update(Empresa empresa){
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        String sql = "UPDATE Alerta SET id_endereco = ?, nome = ?, cnpj = ? ";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1,empresa.getIdEndereco());
            pstmt.setString(2,empresa.getNome());
            pstmt.setString(3,empresa.getCnpj());
            pstmt.executeUpdate();
            System.out.println("update de empresa com sucesso");
        }catch (SQLException sqle){
            sqle.printStackTrace();
        }
        conexao.desconectar(conn);
    }
    public void delete(int id){
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        try{
            PreparedStatement pstmt = conn.prepareStatement("DELETE FROM empresa WHERE id = ?");
            pstmt.setInt(1,id);
            pstmt.executeUpdate();
            System.out.println("delete de empresa com sucesso");
        }catch (SQLException sqle){
            sqle.printStackTrace();
        }
        conexao.desconectar(conn);
        }
}