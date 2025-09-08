package com.codcoz.dao;

import com.codcoz.model.Produto;
import com.codcoz.dao.Conexao;

import java.sql.*;

public class ProdutoDAO {
    public void create(Produto produto) {
        String sql = "INSERT INTO Produto ( id_empresa,id_ItemNotaFiscal,id_Unidade_Medida,nome,estoque_Minimo,categoria,status) VALUES (?, ?, ?, ?, ?, ?, ?)";
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, produto.getIdEmpresa());
            pstmt.setInt(2, produto.getIdItemNotaFiscal());
            pstmt.setInt(3, produto.getIdUnidadeMedida());
            pstmt.setString(4, produto.getNome());
            pstmt.setDouble(5, produto.getEstoqueMinimo());
            pstmt.setString(6, produto.getCategoria());
            pstmt.setString(7, produto.getStatus());

            pstmt.executeUpdate(); // melhor que execute() em INSERT

            System.out.println("Produto inserido com sucesso!");
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
        conexao.desconectar(conn);
    }
    public ResultSet read(Produto produto) {
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        ResultSet rset=null;
        try {
            Statement stmt = conn.createStatement();
            rset = stmt.executeQuery("SELECT * FROM produto");
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
        conexao.desconectar(conn);
        return rset;
    }
    public void update(Produto produto){
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        try {
            PreparedStatement pstmt = conn.prepareStatement("UPDATE produto SET id_Empresa = ?, id_ItemNotaFiscal = ?, id_Unidade_Medida = ?, nome = ?,estoque_Minimo = ?,categoria = ?, status = ?  WHERE id = ?");
            pstmt.setInt(1, produto.getIdEmpresa());
            pstmt.setInt(2, produto.getIdItemNotaFiscal());
            pstmt.setInt(3, produto.getIdUnidadeMedida());
            pstmt.setString(4, produto.getNome());
            pstmt.setDouble(5, produto.getEstoqueMinimo());
            pstmt.setString(6, produto.getCategoria());
            pstmt.setString(7, produto.getStatus());
            pstmt.setInt(8, produto.getId());
            pstmt.execute();
        }catch (SQLException e){
            e.printStackTrace();
        }
        conexao.desconectar(conn);
    }
    public void delete(int id){
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        try{
            PreparedStatement pstmt = conn.prepareStatement("DELETE FROM produto WHERE id= ?");
            pstmt.setInt(1,id);
            pstmt.execute();
            conexao.desconectar(conn);
        }catch (SQLException sqle){
            sqle.printStackTrace();
        }
        conexao.desconectar(conn);
    }
}
