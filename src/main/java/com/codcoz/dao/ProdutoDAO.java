package com.codcoz.dao;

import com.codcoz.model.ItemNotaFiscal;
import com.codcoz.model.Produto;
import com.codcoz.dao.Conexao;

import java.util.ArrayList;
import java.util.List;
import java.sql.*;

public class ProdutoDAO {
    public boolean create(Produto produto) {
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
            rs = stmt.executeQuery("SELECT * FROM produto");
            while (rs.next()) {
                Produto produto = new Produto(
                        rs.getInt("id"),
                        rs.getInt("id_empresa"),
                        rs.getInt("id_ItemNotaFiscal"),
                        rs.getInt("id_Unidade_Medida"),
                        rs.getString("nome"),
                        rs.getDouble("estoque_Minimo"),
                        rs.getString("categoria"),
                        rs.getString("status")
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
    public int update(Produto produto){
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
            if (pstmt.executeUpdate() > 0) {
                System.out.println("update de item nota fiscal com sucesso");
                return 1;
            }
            return 0;
        }catch (SQLException e){
            e.printStackTrace();
            return -1;
        }
        finally {
            conexao.desconectar(conn);
        }
    }
    public int delete(int id){
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        try{
            PreparedStatement pstmt = conn.prepareStatement("DELETE FROM produto WHERE id= ?");
            pstmt.setInt(1,id);
            if (pstmt.executeUpdate() > 0) {
                System.out.println("delete de item nota fiscal com sucesso");
                return 1;
            }
            return 0;
        }catch (SQLException sqle){
            sqle.printStackTrace();
            return -1;
        }
        finally {
            conexao.desconectar(conn);
        }
    }
}
