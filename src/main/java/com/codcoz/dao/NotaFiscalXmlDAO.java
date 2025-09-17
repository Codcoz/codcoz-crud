package com.codcoz.dao;
import com.codcoz.conexao.Conexao;
import com.codcoz.model.NotaFiscalXml;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NotaFiscalXmlDAO {

    public boolean create(NotaFiscalXml notaFiscalXml) {
        String sql = "INSERT INTO nota_fiscal_xml (id_empresa, data_emissao, xml_string, numero_nota) VALUES ( ?, ?, ?, ?)";
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();

        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);

            pstmt.setInt(1, notaFiscalXml.getIdEmpresa());
            pstmt.setString(2, notaFiscalXml.getDataEmissao());
            pstmt.setString(3, notaFiscalXml.getXmlString());
            pstmt.setString(4, notaFiscalXml.getNumeroNota());
            if (pstmt.executeUpdate() > 0) {
                return true;
            }
            return false;
        } catch (SQLException sqle) {
            sqle.printStackTrace();
            return false;
        }
        finally {
            conexao.desconectar(conn);
        }
    }
    public List<NotaFiscalXml> read() {
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        ArrayList<NotaFiscalXml> listnotaFiscalXml = new ArrayList<>();
        ResultSet rs;
        try {
            Statement stmt = conn.createStatement();
            rs= stmt.executeQuery("SELECT * FROM nota_fiscal_xml");
            while (rs.next()) {
                NotaFiscalXml notaFiscalXml = new NotaFiscalXml(
                        rs.getInt("id"),
                        rs.getInt("id_empresa"),
                        rs.getString("data_emissao"),
                        rs.getString("xml_string"),
                        rs.getString("numero_nota")
                );
                listnotaFiscalXml.add(notaFiscalXml);
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
        conexao.desconectar(conn);
        return listnotaFiscalXml;
    }
    public int update(NotaFiscalXml notaFiscalXML) {
        String sql = "UPDATE nota_fiscal_xml " +
                "SET id_empresa = ?, data_emissao = ?, xml_string = ?, numero_nota = ?" +
                "WHERE id = ?";

        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, notaFiscalXML.getIdEmpresa());
            pstmt.setString(2, notaFiscalXML.getDataEmissao());
            pstmt.setString(3, notaFiscalXML.getXmlString());
            pstmt.setString(4, notaFiscalXML.getNumeroNota());
            pstmt.setInt(5, notaFiscalXML.getId());
            if (pstmt.executeUpdate() > 0) {
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

    public int delete(int id){
        Conexao conexao = new Conexao();
        Connection conn = conexao.conectar();
        try{
            PreparedStatement pstmt = conn.prepareStatement("DELETE FROM nota_fiscal_xml WHERE id= ?");
            pstmt.setInt(1,id);
            if (pstmt.executeUpdate() > 0) {
                return 1;
            }
            return 0;
        }catch (SQLException sqle){
            sqle.printStackTrace();
            return -1;
        }
        finally {
            conexao.desconectar(conn);
        }
    }
}


