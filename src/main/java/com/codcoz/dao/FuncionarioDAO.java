package com.codcoz.dao;

import com.codcoz.conexao.Conexao;
import com.codcoz.model.Funcionario;
import com.codcoz.model.NotaFiscalXml;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FuncionarioDAO {

    public int create(Funcionario funcionario) {
        String sql = "INSERT INTO funcionario (id_empresa, funcao, nome, sobrenome, cpf, email, status) VALUES (?, ?, ?, ?, ?, ?, ?)";
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
            pstmt.setString(7, funcionario.getStatus());
            // Retorna true se ao menos uma linha foi inserida
            if (pstmt.executeUpdate() > 0) {
                System.out.println("Funcionarado Criado");
                return 1; // sucesso
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
            if (sqle.getMessage().contains("funcionario_cpf_key")) {
                return 0; // ja existe
            }
            if (sqle.getMessage().contains("funcionario_email_key")) {
                return -1; // ja existe
            }
        } finally {
            conexao.desconectar(conn);
        }
        return -2; // erro desconhecido
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
                        rs.getString("email"),
                        rs.getString("status")
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
        String sql = "UPDATE funcionario SET id_empresa = ?, funcao = ?, nome = ?, sobrenome = ?, cpf = ?, email = ?, status = ? WHERE id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, funcionario.getIdEmpresa());
            pstmt.setString(2, funcionario.getFuncao());
            pstmt.setString(3, funcionario.getNome());
            pstmt.setString(4, funcionario.getSobrenome());
            pstmt.setString(5, funcionario.getCpf());
            pstmt.setString(6, funcionario.getEmail());
            pstmt.setString(7, funcionario.getStatus());
            pstmt.setInt(8, funcionario.getId());
            int updated = pstmt.executeUpdate();
            if (updated > 0) return 1;
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
            if (pstmt.executeUpdate() > 0) return 1;
        } catch (SQLException sqle) {
            sqle.printStackTrace();
            return 0;
        } finally {
            conexao.desconectar(conn);
        }
        return -1;
    }
    public List<Funcionario> buscarPorEmpresa(int idEmpresa) {
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        ArrayList<Funcionario> listFuncionario = new ArrayList<>();
        ResultSet rs;
        String sql = "SELECT * FROM funcionario WHERE id_empresa = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1,idEmpresa);
            System.out.println(pstmt);
            rs= pstmt.executeQuery();
            while (rs.next()) {
                Funcionario funcionario = new Funcionario(
                        rs.getInt("id"),
                        rs.getInt("id_empresa"),
                        rs.getString("funcao"),
                        rs.getString("nome"),
                        rs.getString("sobrenome"),
                        rs.getString("cpf"),
                        rs.getString("email"),
                        rs.getString("status")
                );
                listFuncionario.add(funcionario);
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
        conexao.desconectar(conn);
        return listFuncionario;
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
                        rs.getString("email"),
                        rs.getString("status")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return funcionario;
    }
}
