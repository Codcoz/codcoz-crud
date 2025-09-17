package com.codcoz.dao;

import com.codcoz.conexao.Conexao;
import com.codcoz.model.ItemNotaFiscal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ItemNotaFiscalDAO {
    public boolean create(ItemNotaFiscal itemNotaFiscal) {
        String sql = "INSERT INTO item_nota_fiscal (id_nota_fiscal_xml, id_empresa, quantidade, preco) VALUES (?, ?, ?, ?)";
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, itemNotaFiscal.getIdNotaFiscalXml());
            pstmt.setInt(2, itemNotaFiscal.getIdEmpresa());
            pstmt.setDouble(3, itemNotaFiscal.getQuantidade());
            pstmt.setDouble(4, itemNotaFiscal.getPreco());
            if (pstmt.executeUpdate() > 0) {
                System.out.println("create de item nota fiscal com sucesso");
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

    public List<ItemNotaFiscal> read() {
        ArrayList<ItemNotaFiscal> itensNotaFiscal = new ArrayList<>();
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        ResultSet rs;
        try {
            Statement stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT * FROM item_nota_fiscal");
            while (rs.next()) {
                ItemNotaFiscal itemNotaFiscal = new ItemNotaFiscal(
                        rs.getInt("id"),
                        rs.getInt("id_nota_fiscal_xml"),
                        rs.getInt("id_empresa"),
                        rs.getDouble("quantidade"),
                        rs.getDouble("preco")
                );
                itensNotaFiscal.add(itemNotaFiscal);
            }
            System.out.println("read de item nota fiscal com sucesso");
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }finally {
            conexao.desconectar(conn);
        }
        return itensNotaFiscal;
    }

    public int update(ItemNotaFiscal itemNotaFiscal) {
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        String sql = "UPDATE item_nota_fiscal SET id_nota_fiscal_xml = ?, id_empresa = ?, quantidade = ?, preco = ? WHERE id = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, itemNotaFiscal.getIdNotaFiscalXml());
            pstmt.setInt(2, itemNotaFiscal.getIdEmpresa());
            pstmt.setDouble(3, itemNotaFiscal.getQuantidade());
            pstmt.setDouble(4, itemNotaFiscal.getPreco());
            pstmt.setInt(5, itemNotaFiscal.getId());
            if (pstmt.executeUpdate() > 0) {
                System.out.println("update de item nota fiscal com sucesso");
                return 1;
            }
            return 0;
        } catch (SQLException sqle) {
            sqle.printStackTrace();
            return -1;
        }finally {
            conexao.desconectar(conn);
        }
    }

    public int delete(int id) {
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        try {
            PreparedStatement pstmt = conn.prepareStatement("DELETE FROM item_nota_fiscal WHERE id = ?");
            pstmt.setInt(1, id);
            if (pstmt.executeUpdate() > 0) {
                System.out.println("delete de item nota fiscal com sucesso");
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
}