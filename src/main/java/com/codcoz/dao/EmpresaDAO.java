package com.codcoz.dao;

import com.codcoz.conexao.Conexao;
import com.codcoz.model.Empresa;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EmpresaDAO {

    // Insere uma nova empresa no banco
    public boolean create(Empresa empresa) {
        String sql = "INSERT INTO empresa (id_endereco, nome, cnpj, email) VALUES (?, ?, ?, ?)";
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, empresa.getIdEndereco());
            pstmt.setString(2, empresa.getNome());
            pstmt.setString(3, empresa.getCnpj());
            pstmt.setString(4, empresa.getEmail());

            // Retorna true se ao menos uma linha foi inserida
            if (pstmt.executeUpdate() > 0) {
                System.out.println("Empresa criada com sucesso!");
                return true;
            }
            return false;
        } catch (SQLException sqle) {
            sqle.printStackTrace();
            return false;
        } finally {
            conexao.desconectar(conn); // garante fechamento da conexão
        }
    }

    // Retorna todas as empresas cadastradas
    public List<Empresa> read() {
        ArrayList<Empresa> empresaList = new ArrayList<>();
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        ResultSet rs;
        try {
            Statement stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT * FROM empresa");

            // Mapeia cada linha do resultado para um objeto Empresa
            while (rs.next()) {
                Empresa empresa = new Empresa(
                        rs.getInt("id"),
                        rs.getInt("id_endereco"),
                        rs.getString("nome"),
                        rs.getString("cnpj"),
                        rs.getString("email")
                );
                empresaList.add(empresa);
            }
            System.out.println("read de empresa com sucesso");
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
        conexao.desconectar(conn);
        return empresaList;
    }

    // Busca uma empresa específica pelo ID
    public Empresa buscarPorId(int id) {
        Empresa empresa = null;
        try (Connection conn = new Conexao().conectar();
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM empresa WHERE id = ?")) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            // Retorna o primeiro resultado encontrado
            if (rs.next()) {
                empresa = new Empresa(
                        rs.getInt("id"),
                        rs.getInt("id_endereco"),
                        rs.getString("nome"),
                        rs.getString("cnpj"),
                        rs.getString("email")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return empresa;
    }

    // Atualiza os dados de uma empresa existente
    public int update(Empresa empresa) {
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        String sql = "UPDATE empresa SET id_endereco = ?, nome = ?, cnpj = ?, email = ? WHERE id = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, empresa.getIdEndereco());
            pstmt.setString(2, empresa.getNome());
            pstmt.setString(3, empresa.getCnpj());
            pstmt.setString(4, empresa.getEmail());
            pstmt.setInt(5, empresa.getId());

            if (pstmt.executeUpdate() > 0) {
                System.out.println("update de empresa com sucesso");
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

    // Exclui uma empresa pelo ID
    public int delete(int id) {
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        try {
            PreparedStatement pstmt = conn.prepareStatement("DELETE FROM empresa WHERE id = ?");
            pstmt.setInt(1, id);

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
}