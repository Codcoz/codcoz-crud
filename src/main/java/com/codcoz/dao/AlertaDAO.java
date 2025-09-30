package com.codcoz.dao;

import com.codcoz.conexao.Conexao;
import com.codcoz.model.Alerta;
import com.codcoz.model.Produto;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AlertaDAO {

    public boolean create(Alerta alerta) {
        String sql = "INSERT INTO alerta (id_empresa, id_produto, data_criacao, status, tipo_alerta) VALUES (?, ?, ?, ?, ?)";
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, alerta.getIdEmpresa());
            pstmt.setInt(2, alerta.getIdProduto());
            pstmt.setString(3, alerta.getDataCriacao()); // ideal: usar java.sql.Date
            pstmt.setString(4, alerta.getStatus());
            pstmt.setString(5, alerta.getTipoAlerta());

            if (pstmt.executeUpdate() > 0) {
                System.out.println("create de alerta com sucesso");
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

    public List<Alerta> read() {
        ArrayList<Alerta> alertaList = new ArrayList<>();
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        ResultSet rs;
        try {
            Statement stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT * FROM alerta");
            while (rs.next()) {
                Alerta alerta = new Alerta(
                        rs.getInt("id"),
                        rs.getInt("id_empresa"),
                        rs.getInt("id_produto"),
                        rs.getString("data_criacao"),
                        rs.getString("status"),
                        rs.getString("tipo_alerta")
                );
                alertaList.add(alerta);
            }
            System.out.println("read de alerta com sucesso");
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
        conexao.desconectar(conn);
        return alertaList;
    }
    public Alerta buscarPorId(int id) {
        Alerta alerta = null;
        try (Connection conn = new Conexao().conectar();
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM alerta WHERE id = ?")) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                alerta = new Alerta(
                        rs.getInt("id"),
                        rs.getInt("id_empresa"),
                        rs.getInt("id_produto"),
                        rs.getString("data_criacao"),
                        rs.getString("status"),
                        rs.getString("tipo_alerta")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return alerta;
    }

    public int update(Alerta alerta) {
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        String sql = "UPDATE alerta SET id_empresa = ?, id_produto = ?, data_criacao = ?, status = ?, tipo_alerta = ? WHERE id = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, alerta.getIdEmpresa());
            pstmt.setInt(2, alerta.getIdProduto());
            pstmt.setString(3, alerta.getDataCriacao());
            pstmt.setString(4, alerta.getStatus());
            pstmt.setString(5, alerta.getTipoAlerta());
            pstmt.setInt(6, alerta.getId());

            if (pstmt.executeUpdate() > 0) {
                System.out.println("update de alerta com sucesso");
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
        String sql = "DELETE FROM alerta WHERE id = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            if (pstmt.executeUpdate() > 0) {
                System.out.println("delete de alerta com sucesso");
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
