package com.codcoz.dao;

import com.codcoz.model.Funcionario;
import com.codcoz.model.ItemNotaFiscal;

import java.sql.*;

public class FuncionarioDAO {

    public void create(Funcionario funcionario) {
        String sql = "INSERT INTO funcionario (id_empresa, id_funcao, nome, sobrenome, data_admissao, cpf, salario, ) VALUES (?, ?, ?, ?, ?, ?, ?)";
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);

            pstmt.setInt(1, funcionario.getIdEmpresa());
            pstmt.setInt(2, funcionario.getIdFuncao());
            pstmt.setString(3, funcionario.getNome());
            pstmt.setString(4, funcionario.getSobrenome());
            pstmt.setString(5, funcionario.getCpf());
            pstmt.setDouble(6, funcionario.getSalario());
            pstmt.setString(7, funcionario.getDataAdmissao());

            pstmt.executeUpdate();
            System.out.println("create de funcionario com sucesso");
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
        conexao.desconectar(conn);
    }
    public ResultSet read(){
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        ResultSet rs = null;
        try{
            Statement stmt = conn.createStatement();
            rs = stmt.executeQuery("select * from funcionario");
        }catch (SQLException sqle){
            sqle.printStackTrace();
        }
        conexao.desconectar(conn);
        return rs;
    }
    public void update(Funcionario funcionario){
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        String sql = "update funcionario set id_empresa = ?, id_funcao = ?, nome = ?, sobrenome = ?, data_admissao where id = ?";
        try{
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1,funcionario.getIdEmpresa());
            pstmt.setInt(2,funcionario.getIdFuncao());
            pstmt.setString(3,funcionario.getNome());
            pstmt.setString(4,funcionario.getSobrenome());
            pstmt.setString(5,funcionario.getDataAdmissao());
            pstmt.setInt(6, funcionario.getId());
            pstmt.executeUpdate();
            System.out.println("update de funcionario com sucesso");
        }catch (SQLException sqle){
            sqle.printStackTrace();
        }
    }
    public void delete(int id){
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        try{
            PreparedStatement pstmt = conn.prepareStatement("DELETE FROM funcionario WHERE id = ?");

            pstmt.setInt(1,id);
            pstmt.executeUpdate();
            System.out.println("delete de funcionario com sucesso");
        }catch (SQLException sqle){
            sqle.printStackTrace();
        }
        conexao.desconectar(conn);
    }
}
