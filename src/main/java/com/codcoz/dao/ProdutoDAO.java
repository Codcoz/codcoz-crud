package com.codcoz.dao;

import com.codcoz.model.Produto;
import com.codcoz.conexao.Conexao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProdutoDAO {

    public boolean create(Produto produto) {
        String sql = "INSERT INTO Produto (id_estoque, id_nota_fiscal, id_empresa, unidade_medida, nome, estoque_minimo, categoria, quantidade) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, produto.getIdEstoque());
            pstmt.setInt(2, produto.getIdNotaFiscal());
            pstmt.setInt(3, produto.getIdEmpresa());
            pstmt.setString(4, produto.getUnidadeMedida());
            pstmt.setString(5, produto.getNome());
            pstmt.setDouble(6, produto.getEstoqueMinimo());
            pstmt.setString(7, produto.getCategoria());
            pstmt.setInt(8, produto.getQuantidade());
            if (pstmt.executeUpdate() > 0) {
                System.out.println("Produto criado com sucesso");
                return true;
            }
            return false;
        } catch (SQLException sqle) {
            sqle.printStackTrace();
            return false;
        } finally {
            conexao.desconectar(conn);
        }
    }

    public List<Produto> read() {
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        ArrayList<Produto> produtoList = new ArrayList<>();
        ResultSet rs;
        String sql = "SELECT p.id, p.id_estoque, p.id_nota_fiscal, e.id AS id_empresa, p.unidade_medida, p.nome, p.estoque_minimo, p.categoria, p.quantidade FROM produto p LEFT JOIN nota_fiscal_xml nf ON p.id_nota_fiscal = nf.id LEFT JOIN empresa e ON nf.id_empresa = e.id ORDER BY p.id";
        try {
            Statement stmt = conn.createStatement();
            rs = stmt.executeQuery(sql);
            while (rs.next()) {
                Produto produto = new Produto(
                        rs.getInt("id"),
                        rs.getInt("id_estoque"),
                        rs.getInt("id_nota_fiscal"),
                        rs.getInt("id_empresa"),
                        rs.getString("unidade_medida"),
                        rs.getDouble("estoque_minimo"),
                        rs.getString("nome"),
                        rs.getString("categoria"),
                        rs.getInt("quantidade")
                );
                produtoList.add(produto);
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            conexao.desconectar(conn);
        }
        return produtoList;
    }

    public Produto buscarPorId(int id) {
        Produto produto = null;
        String sql = "SELECT p.id, p.id_estoque, p.id_nota_fiscal, e.id AS id_empresa, p.unidade_medida, p.nome, p.estoque_minimo, p.categoria, p.quantidade FROM produto p LEFT JOIN nota_fiscal_xml nf ON p.id_nota_fiscal = nf.id LEFT JOIN empresa e ON nf.id_empresa = e.id WHERE p.id = ?";
        try (Connection conn = new Conexao().conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                produto = new Produto(
                        rs.getInt("id"),
                        rs.getInt("id_estoque"),
                        rs.getInt("id_nota_fiscal"),
                        rs.getInt("id_empresa"),
                        rs.getString("unidade_medida"),
                        rs.getDouble("estoque_minimo"),
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
    public List<Produto> buscarPorEmpresa(int idEmpresa) {
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        ArrayList<Produto> produtoList = new ArrayList<>();
        ResultSet rs;
        String sql = "SELECT p.id, p.id_estoque, p.id_nota_fiscal, e.id AS id_empresa, p.unidade_medida, p.nome, p.estoque_minimo, p.categoria, p.quantidade " +
                "FROM produto p " +
                "LEFT JOIN nota_fiscal_xml nf ON p.id_nota_fiscal = nf.id " +
                "LEFT JOIN empresa e ON nf.id_empresa = e.id " +
                "WHERE e.id = ? " +
                "ORDER BY p.id";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, idEmpresa);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Produto produto = new Produto(
                        rs.getInt("id"),
                        rs.getInt("id_estoque"),
                        rs.getInt("id_nota_fiscal"),
                        rs.getInt("id_empresa"),
                        rs.getString("unidade_medida"),
                        rs.getDouble("estoque_minimo"),
                        rs.getString("nome"),
                        rs.getString("categoria"),
                        rs.getInt("quantidade")
                );
                produtoList.add(produto);
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            conexao.desconectar(conn);
        }
        return produtoList;
    }
    public int update(Produto produto) {
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        try {
            PreparedStatement pstmt = conn.prepareStatement("UPDATE produto SET id_estoque = ?, id_nota_fiscal = ?, id_empresa = ?, unidade_medida = ?, nome = ?, estoque_minimo = ?, categoria = ?, quantidade = ? WHERE id = ?");
            pstmt.setInt(1, produto.getIdEstoque());
            pstmt.setInt(2, produto.getIdNotaFiscal());
            pstmt.setInt(3, produto.getIdEmpresa());
            pstmt.setString(4, produto.getUnidadeMedida());
            pstmt.setString(5, produto.getNome());
            pstmt.setDouble(6, produto.getEstoqueMinimo());
            pstmt.setString(7, produto.getCategoria());
            pstmt.setInt(8, produto.getQuantidade());
            pstmt.setInt(9, produto.getId());
            if (pstmt.executeUpdate() > 0) {
                System.out.println("Produto atualizado com sucesso");
                return 1;
            }
            return 0;
        } catch (SQLException sqle) {
            sqle.printStackTrace();
            return -1;
        } finally {
            conexao.desconectar(conn);
        }
    }

    public int delete(int id) {
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        try {
            PreparedStatement pstmt = conn.prepareStatement("DELETE FROM produto WHERE id = ?");
            pstmt.setInt(1, id);
            if (pstmt.executeUpdate() > 0) {
                System.out.println("Produto deletado com sucesso");
                return 1;
            }
            return 0;
        } catch (SQLException sqle) {
            sqle.printStackTrace();
            if (sqle.getMessage().contains("still referenced")) {
                return 0; // está vinculado a outra tabela
            }
            return -1;
        } finally {
            conexao.desconectar(conn);
        }
    }
}