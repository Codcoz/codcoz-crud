package com.codcoz.dao;

import com.codcoz.model.Alerta;
import com.codcoz.conexao.Conexao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AlertaDAO {

    public boolean create(Alerta alerta) {
        String sql = "INSERT INTO alerta (id_produto, tipo_alerta, status, data_criacao) VALUES (?, ?, ?, ?)";
        try (Connection conn = new Conexao().conectar();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, alerta.getIdProduto());
            pstmt.setString(2, alerta.getTipoAlerta());
            pstmt.setString(3, alerta.getStatus());
            pstmt.setDate(4, alerta.getDataCriacao());

            return pstmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Alerta> read() {
        List<Alerta> lista = new ArrayList<>();
        String sql = "SELECT a.id, e.id AS id_empresa, a.id_produto, a.data_criacao, a.status, a.tipo_alerta FROM alerta a JOIN produto p ON a.id_produto = p.id JOIN nota_fiscal_xml nf ON p.id_nota_fiscal = nf.id JOIN empresa e ON nf.id_empresa = e.id ORDER BY a.id";

        try (Connection conn = new Conexao().conectar();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Alerta alerta = new Alerta(
                        rs.getInt("id"),
                        rs.getInt("id_empresa"),
                        rs.getInt("id_produto"),
                        rs.getDate("data_criacao"),
                        rs.getString("status"),
                        rs.getString("tipo_alerta")
                );
                lista.add(alerta);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    public Alerta buscarPorId(int id) {
        String sql = "SELECT * FROM alerta WHERE id = ?";
        try (Connection conn = new Conexao().conectar();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                return new Alerta(
                        rs.getInt("id"),
                        rs.getInt("id_produto"),
                        rs.getDate("data_criacao"),
                        rs.getString("status"),
                        rs.getString("tipo_alerta")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public int update(Alerta alerta) {
        String sql = "UPDATE alerta SET id_produto = ?, tipo_alerta = ?, status = ?, data_criacao = ? WHERE id = ?";
        try (Connection conn = new Conexao().conectar();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, alerta.getIdProduto());
            pstmt.setString(2, alerta.getTipoAlerta());
            pstmt.setString(3, alerta.getStatus());
            pstmt.setDate(4, alerta.getDataCriacao());
            pstmt.setInt(5, alerta.getId());

            return pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }
    }

    public int delete(int id) {
        String sql = "DELETE FROM alerta WHERE id = ?";
        try (Connection conn = new Conexao().conectar();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            return pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }
    }
}