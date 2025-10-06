package com.codcoz.dao;

import com.codcoz.model.Produto;
import com.codcoz.conexao.Conexao;

import java.util.ArrayList;
import java.util.List;
import java.sql.*;

public class ProdutoDAO {
    public boolean create(Produto produto) {
        String sql = "INSERT INTO Produto ( id_empresa,unidade_medida,nome,estoque_Minimo,categoria,quantidade ) VALUES (?, ?, ?, ?, ?,?)";
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, produto.getIdEmpresa());
            pstmt.setString(2, produto.getUnidadeMedida());
            pstmt.setString(3, produto.getNome());
            pstmt.setDouble(4, produto.getEstoqueMinimo());
            pstmt.setString(5, produto.getCategoria());
            pstmt.setInt(6, produto.getQuantidade());
            if (pstmt.executeUpdate() > 0) {
                System.out.println("create de item nota fiscal com sucesso");
                return true;
            }
            return false;
        } catch (SQLException sqle) {
            sqle.printStackTrace();
            return false;
        }
        finally {
            conexao.desconectar(conn);
        }
    }
    public List<Produto> read() {
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        ArrayList<Produto> produtoList = new ArrayList<>();
        ResultSet rs;
        try {
            Statement stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT * FROM produto order by id");
            while (rs.next()) {
                Produto produto = new Produto(
                        rs.getInt("id"),
                        rs.getInt("id_empresa"),
                        rs.getString("unidade_medida"),
                        rs.getDouble("estoque_Minimo"),
                        rs.getString("nome"),
                        rs.getString("categoria"),
                        rs.getInt("quantidade")
                );
                produtoList.add(produto);
            }
            System.out.println("read de item nota fiscal com sucesso");
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
        finally {
            conexao.desconectar(conn);
        }
        return produtoList;
    }
    public Produto buscarPorId(int id) {
        Produto produto = null;
        try (Connection conn = new Conexao().conectar();
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM produto WHERE id = ?")) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                produto = new Produto(
                        rs.getInt("id"),
                        rs.getInt("id_empresa"),
                        rs.getString("unidade_medida"),
                        rs.getDouble("estoque_Minimo"),
                        rs.getString("nome"),
                        rs.getString("categoria"),
                        rs.getInt("quantidade")



                        );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return produto;
    }
    public int update(Produto produto){
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        try {
            PreparedStatement pstmt = conn.prepareStatement("UPDATE produto SET id_Empresa = ?, unidade_medida = ?, nome = ?,estoque_Minimo = ?,categoria = ?,quantidade = ? WHERE id = ?");
            pstmt.setInt(1, produto.getIdEmpresa());
            pstmt.setString(2, produto.getUnidadeMedida());
            pstmt.setString(3, produto.getNome());
            pstmt.setDouble(4, produto.getEstoqueMinimo());
            pstmt.setString(5, produto.getCategoria());
            pstmt.setInt(6, produto.getQuantidade());
            pstmt.setInt(7, produto.getId());
            if (pstmt.executeUpdate() > 0) {
                return 1; // sucesso
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
            return 0; // erro interno
        } finally {
            conexao.desconectar(conn);
        }
        return -1; // erro desconhecido
    }

    public int delete(int id){
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        try{
            PreparedStatement pstmt = conn.prepareStatement("DELETE FROM produto WHERE id= ?");
            pstmt.setInt(1,id);
            if (pstmt.executeUpdate() > 0) {
                return 1; // sucesso
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
            if (sqle.getMessage().contains("still referenced")){
                return 0; // está vinculado a outra tabela
            }
            return -1; // erro interno
        } finally {
            conexao.desconectar(conn);
        }
        return -2; // falha genérica
    }
}
