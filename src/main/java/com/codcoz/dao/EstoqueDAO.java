package com.codcoz.dao;

import com.codcoz.model.Estoque;
import com.codcoz.conexao.Conexao;
import com.codcoz.model.NotaFiscalXml;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EstoqueDAO {

    public boolean create(Estoque estoque) {
        String sql = "INSERT INTO Estoque (id_empresa, tipo_estoque, capacidade) VALUES (?, ?, ?)";
        try (Connection conn = new Conexao().conectar();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, estoque.getIdEmpresa());
            pstmt.setString(2, estoque.getTipoEstoque());
            pstmt.setInt(3, estoque.getCapacidade());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Estoque> read() {
        List<Estoque> lista = new ArrayList<>();
        try (Connection conn = new Conexao().conectar();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT * FROM Estoque ORDER BY id")) {
            while (rs.next()) {
                lista.add(new Estoque(
                        rs.getInt("id"),
                        rs.getInt("id_empresa"),
                        rs.getString("tipo_estoque"),
                        rs.getInt("capacidade")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }
    public List<Estoque> buscarPorEmpresa(int idEmpresa) {
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        ArrayList<Estoque> listestoque = new ArrayList<>();
        ResultSet rs;
        String sql = "SELECT * FROM estoque WHERE id_empresa = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1,idEmpresa);
            rs= pstmt.executeQuery();
            while (rs.next()) {
                Estoque estoque = new Estoque(
                        rs.getInt("id"),
                        rs.getInt("id_empresa"),
                        rs.getString("tipo_estoque"),
                        rs.getInt("capacidade")
                );
                listestoque.add(estoque);
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
        conexao.desconectar(conn);
        return listestoque;
    }

    public Estoque buscarPorId(int id) {
        Estoque estoque = null;
        try (Connection conn = new Conexao().conectar();
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM Estoque WHERE id = ?")) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                estoque = new Estoque(
                        rs.getInt("id"),
                        rs.getInt("id_empresa"),
                        rs.getString("tipo_estoque"),
                        rs.getInt("capacidade")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return estoque;
    }

    public int update(Estoque estoque) {
        try (Connection conn = new Conexao().conectar();
             PreparedStatement pstmt = conn.prepareStatement("UPDATE Estoque SET id_empresa = ?, tipo_estoque = ?, capacidade = ? WHERE id = ?")) {
            pstmt.setInt(1, estoque.getIdEmpresa());
            pstmt.setString(2, estoque.getTipoEstoque());
            pstmt.setInt(3, estoque.getCapacidade());
            pstmt.setInt(4, estoque.getId());
            return pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }
    }

    public int delete(int id) {
        try (Connection conn = new Conexao().conectar();
             PreparedStatement pstmt = conn.prepareStatement("DELETE FROM Estoque WHERE id = ?")) {
            pstmt.setInt(1, id);
            return pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }
    }
}