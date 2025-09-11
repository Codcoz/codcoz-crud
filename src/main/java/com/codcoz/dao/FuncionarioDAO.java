package com.codcoz.dao;

import com.codcoz.model.Funcionario;
import com.codcoz.model.ItemNotaFiscal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FuncionarioDAO {

    public boolean create(Funcionario funcionario) {
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
            return pstmt.executeUpdate()>0;
        } catch (SQLException sqle) {
            sqle.printStackTrace();
            return false;
        }finally {
            conexao.desconectar(conn);
        }
    }
    public List<Funcionario> read(){
        ArrayList<Funcionario> funcionariosList = new ArrayList<>();
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        ResultSet rs;
        try{
            Statement stmt = conn.createStatement();
            rs = stmt.executeQuery("select * from funcionario");
            while (rs.next()){
            Funcionario funcionario = new Funcionario(
                    rs.getInt("id"),
                    rs.getInt("id_empresa"),
                    rs.getInt("id_funcao"),
                    rs.getString("nome"),
                    rs.getString("sobrenome"),
                    rs.getString("data_admissao"),
                    rs.getString("cpf"),
                    rs.getDouble("salario")
            );
                funcionariosList.add(funcionario);
            }
        }catch (SQLException sqle){
            sqle.printStackTrace();
        }finally {
            conexao.desconectar(conn);
        }
        return funcionariosList;
    }
    public int update(Funcionario funcionario){
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
            if(pstmt.executeUpdate()>0){
                System.out.println("update de funcionario com sucesso");
                return 1;
            };
            return 0;
        }catch (SQLException sqle){
            sqle.printStackTrace();
            return -1;
        }finally {
            conexao.desconectar(conn);
        }
    }
    public int delete(int id){
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        try{
            PreparedStatement pstmt = conn.prepareStatement("DELETE FROM funcionario WHERE id = ?");

            pstmt.setInt(1,id);
            if(pstmt.executeUpdate()>0){
                System.out.println("delete de funcionario com sucesso");
                return 1;
            };
            return 0;
        }catch (SQLException sqle){
            sqle.printStackTrace();
            return -1;
        }finally {
            conexao.desconectar(conn);
        }
    }
}
