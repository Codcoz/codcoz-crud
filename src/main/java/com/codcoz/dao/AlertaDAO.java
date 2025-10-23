package com.codcoz.dao;

import com.codcoz.model.Alerta;
import com.codcoz.conexao.Conexao;
import com.codcoz.model.Empresa;
import com.codcoz.model.Produto;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AlertaDAO {

    public boolean create(Alerta alerta) {
        String sql = "INSERT INTO alerta (id_produto, tipo_alerta, status, data_criacao) VALUES (?, ?, ?, ?)";
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, alerta.getIdProduto());
            pstmt.setString(2, alerta.getTipoAlerta());
            pstmt.setString(3, alerta.getStatus());
            pstmt.setDate(4, alerta.getDataCriacao());

            if (pstmt.executeUpdate() > 0) {
                System.out.println("Empresa criada com sucesso!");
                return true;
            }
            return false;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
     finally {
        conexao.desconectar(conn); // garante fechamento da conexão
    }
    }

    public List<Alerta> read() {
        ArrayList<Alerta> listaAlertas = new ArrayList<>();
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        ResultSet rs;
        try {
            Statement stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT a.id, e.id AS id_empresa, a.id_produto, a.data_criacao, a.status, a.tipo_alerta FROM alerta a JOIN produto p ON a.id_produto = p.id JOIN nota_fiscal_xml nf ON p.id_nota_fiscal = nf.id JOIN empresa e ON nf.id_empresa = e.id ORDER BY a.id");
            // Mapeia cada linha do resultado para um objeto Alerta
            while (rs.next()) {
                Alerta alerta = new Alerta(
                        rs.getInt("id"),
                        rs.getInt("id_empresa"),
                        rs.getInt("id_produto"),
                        rs.getDate("data_criacao"),
                        rs.getString("status"),
                        rs.getString("tipo_alerta")
                );
                listaAlertas.add(alerta);
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
        finally {
        conexao.desconectar(conn);
            }
        return listaAlertas;
        }

    public List<Alerta> buscarPorEmpresa(int idEmpresa) {
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        ArrayList<Alerta> alertaList = new ArrayList<>();
        ResultSet rs;
        String sql = "SELECT a.id, e.id AS id_empresa, a.id_produto, a.data_criacao, a.status, a.tipo_alerta " +
                "FROM alerta a " +
                "JOIN produto p ON a.id_produto = p.id " +
                "JOIN nota_fiscal_xml nf ON p.id_nota_fiscal = nf.id " +
                "JOIN empresa e ON nf.id_empresa = e.id " +
                "WHERE e.id = ? "+
                "ORDER BY a.id";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, idEmpresa);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Alerta alerta = new Alerta(
                        rs.getInt("id"),
                        rs.getInt("id_empresa"),
                        rs.getInt("id_produto"),
                        rs.getDate("data_criacao"),
                        rs.getString("status"),
                        rs.getString("tipo_alerta")
                );
                alertaList.add(alerta);
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            conexao.desconectar(conn);
        }
        return alertaList;
    }
    public Alerta buscarPorId(int id) {
        Alerta alerta = null;
        String sql = "SELECT a.id, e.id AS id_empresa, a.id_produto, a.data_criacao, a.status, a.tipo_alerta " +
                "FROM alerta a " +
                "JOIN produto p ON a.id_produto = p.id " +
                "JOIN nota_fiscal_xml nf ON p.id_nota_fiscal = nf.id " +
                "JOIN empresa e ON nf.id_empresa = e.id " +
                "WHERE a.id = ?";
        try (Connection conn = new Conexao().conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                alerta = new Alerta(
                        rs.getInt("id"),
                        rs.getInt("id_empresa"),
                        rs.getInt("id_produto"),
                        rs.getDate("data_criacao"),
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
        String sql = "UPDATE alerta SET id_produto = ?, tipo_alerta = ?, status = ?, data_criacao = ? WHERE id = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, alerta.getIdProduto());
            pstmt.setString(2, alerta.getTipoAlerta());
            pstmt.setString(3, alerta.getStatus());
            pstmt.setDate(4, alerta.getDataCriacao());
            pstmt.setInt(5, alerta.getId());

            if (pstmt.executeUpdate() > 0) {
                System.out.println("update de alerta com sucesso");
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


    public int delete(int id) {
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        try {
            PreparedStatement pstmt = conn.prepareStatement("DELETE FROM alerta WHERE id = ?");
            pstmt.setInt(1, id);
            if (pstmt.executeUpdate() > 0) {
                System.out.println("Alerta deletado com sucesso");
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