package com.codcoz.dao;

import com.codcoz.conexao.Conexao;
import com.codcoz.model.Funcionario;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FuncionarioDAO {

    public boolean create(Funcionario funcionario) {
        String sql = "INSERT INTO funcionario (id_empresa, funcao, nome, sobrenome, cpf, email) VALUES (?, ?, ?, ?, ?, ?)";
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);

            pstmt.setInt(1, funcionario.getIdEmpresa());
            pstmt.setString(2, funcionario.getFuncao());
            pstmt.setString(3, funcionario.getNome());
            pstmt.setString(4, funcionario.getSobrenome());
            pstmt.setString(5, funcionario.getCpf());
            pstmt.setString(6, funcionario.getEmail());
            return pstmt.executeUpdate() > 0;
        } catch (SQLException sqle) {
            sqle.printStackTrace();
            return false;
        } finally {
            conexao.desconectar(conn);
        }
    }

    public List<Funcionario> read() {
        ArrayList<Funcionario> funcionariosList = new ArrayList<>();
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        ResultSet rs;
        try {
            Statement stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT * FROM funcionario");
            while (rs.next()) {
                Funcionario funcionario = new Funcionario(
                        rs.getInt("id"),
                        rs.getInt("id_empresa"),
                        rs.getString("funcao"),
                        rs.getString("nome"),
                        rs.getString("sobrenome"),
                        rs.getString("cpf"),
                        rs.getString("email")
                );
                funcionariosList.add(funcionario);
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            conexao.desconectar(conn);
        }
        return funcionariosList;
    }

    public int update(Funcionario funcionario) {
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        String sql = "UPDATE funcionario SET id_empresa = ?, funcao = ?, nome = ?, sobrenome = ?, cpf = ?, email = ? WHERE id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, funcionario.getIdEmpresa());
            pstmt.setString(2, funcionario.getFuncao());
            pstmt.setString(3, funcionario.getNome());
            pstmt.setString(4, funcionario.getSobrenome());
            pstmt.setString(5, funcionario.getCpf());
            pstmt.setString(6, funcionario.getEmail());
            pstmt.setInt(7, funcionario.getId());

            int updated = pstmt.executeUpdate();
            if (updated > 0) {
                System.out.println("update de funcionario com sucesso");
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
            PreparedStatement pstmt = conn.prepareStatement("DELETE FROM funcionario WHERE id = ?");
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

    public Funcionario buscarPorId(int id) {
        Funcionario funcionario = null;
        String sql = "SELECT * FROM funcionario WHERE id = ?";

        try (Connection conn = new Conexao().conectar();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                funcionario = new Funcionario(
                        rs.getInt("id"),
                        rs.getInt("id_empresa"),
                        rs.getString("funcao"),
                        rs.getString("nome"),
                        rs.getString("sobrenome"),
                        rs.getString("cpf"),
                        rs.getString("email")
                );
            }
        } catch (SQLException e) {
            System.err.println("Erro ao buscar funcionário por ID: " + e.getMessage());
            e.printStackTrace();
        }

        return funcionario;
    }
}
