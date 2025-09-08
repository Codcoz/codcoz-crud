package com.codcoz.dao;
import com.codcoz.model.NotaFiscalXml;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class NotaFiscalXmlDAO {

    public void create(NotaFiscalXml notaFiscalXML) {
        String sql = "INSERT INTO nota_fiscal_xml (id_empresa, data_emissao, numero_nota, xml_string) VALUES ( ?, ?, ?, ?)";
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();

        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);

            pstmt.setInt(1, notaFiscalXML.getIdEmpresa());
            pstmt.setString(2, notaFiscalXML.getDataEmissao());
            pstmt.setString(3, notaFiscalXML.getNumeroNota());
            pstmt.setString(4, notaFiscalXML.getXmlString());
            pstmt.executeUpdate();
            System.out.println("NotaFiscalXML inserida com sucesso!");
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
        conexao.desconectar(conn);
    }
    public ResultSet read() {
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        ResultSet rset = null;
        try {
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM nota_fiscal_xml");
            rset = stmt.executeQuery("SELECT * FROM nota_fiscal_xml");
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
        conexao.desconectar(conn);
        return rset;

    }


    public void delete(int id) {
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();

        try {

            PreparedStatement pstmt = conn.prepareStatement("DELETE FROM Nota_Fiscal_XML WHERE id = ?");

            pstmt.setInt(1, id);
            pstmt.execute();
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
        conexao.desconectar(conn);


    }
    public void update(NotaFiscalXml notaFiscalXML) {
        String sql = "UPDATE nota_fiscal_xml " +
                "SET id_empresa = ?, data_emissao = ?, numero_nota = ?, xml_string = ? " +
                "WHERE id = ?";

        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();


        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);



            pstmt.setInt(1, notaFiscalXML.getIdEmpresa());
            pstmt.setString(2, notaFiscalXML.getDataEmissao());
            pstmt.setString(3, notaFiscalXML.getNumeroNota());
            pstmt.setString(4, notaFiscalXML.getXmlString());
            pstmt.setInt(5, notaFiscalXML.getId());
            int linhasAfetadas = pstmt.executeUpdate();

            if (linhasAfetadas > 0) {
                System.out.println("NotaFiscalXML atualizada com sucesso!");
            } else {
                System.out.println("Nenhum registro encontrado com o ID informado.");
            }



        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } conexao.desconectar(conn);
    }



}