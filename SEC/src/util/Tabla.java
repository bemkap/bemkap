package util;

import db.DB;
import java.sql.*;

public class Tabla {
  public static void crear_usuarios(DB db) throws SQLException {
    db.create("usuarios").c_cod("cod_usu").c_varchar("nom_usu", 255).c_varchar("cla_usu", 255).c_tinyint("per_usu").exec(db);
    db.insert("usuarios").ca(db, "cod_usu", "nom_usu", "cla_usu", "per_usu").v_int(1).v_varchar("admin").
            v_varchar("admin").v_tinyint((byte)255).exec(db);
  }
  public static void crear_actividades(DB db) throws SQLException {
    db.create("actividades").c_cod("cod_act").c_varchar("nom_act", 200).exec(db);
  }
  public static void crear_empresas(DB db) throws SQLException {
    db.create("empresas").c_cod("cod_emp").c_bigint("cuit_emp").c_varchar("nom_emp", 255).c_boolean("valid").exec(db);
  }
  public static void crear_cuentas(DB db) throws SQLException {
    db.create("cuentas").c_cod("cod_cue").c_varchar("nom_cue", 64).c_int("pad_cue").c_int("nhi_cue").exec(db);
    String[] cuentas = {"activo", "pasivo", "patrimonio neto", "resultados"};
    for(Integer i = 0; i < 4; i++) db.insert("cuentas").ca(db, "cod_cue", "pad_cue", "nom_cue").v_int(i + 1).
            v_int(0).v_varchar(cuentas[i]).exec(db);
  }
  public static void crear_empcue(DB db) throws SQLException {
    crear_empresas(db);
    crear_cuentas(db);
    db.create("empcue").c_int("cod_emp").c_int("cod_cue").primaries("cod_emp", "cod_cue").
            reference("cod_emp", "empresas").reference("cod_cue", "cuentas").exec(db);
  }
  public static void crear_empact(DB db) throws SQLException {
    crear_empresas(db);
    crear_actividades(db);
    db.create("empact").c_int("cod_emp").c_int("cod_act").primaries("cod_emp", "cod_act").
            reference("cod_emp", "empresas").reference("cod_act", "actividades").exec(db);
  }
  public static void crear_clientes(DB db) throws SQLException {
    db.create("clientes").c_cod("cod_cli").c_bigint("cui_cli").c_varchar("nom_cli", 255).c_boolean("valid").exec(db);
  }
  public static void crear_proveedores(DB db) throws SQLException {
    db.create("proveedores").c_cod("cod_pro").c_bigint("cui_pro").c_varchar("nom_pro", 255).c_boolean("valid").exec(db);
  }
  public static void crear_vc(DB db, Integer emp) throws SQLException {
    crear_empresas(db);
    crear_clientes(db);
    crear_cuentas(db);
    db.create("vc" + emp).c_cod("cod_vc").c_int("cod_emp").c_int("suc_vc").c_int("nco_vc").c_date("fec_vc").
            c_int("let_vc").c_int("cod_cli").c_double("ngr_vc").c_double("grv_vc").c_double("exe_vc").c_double("int_vc").
            c_double("riv_vc").c_double("rib_vc").c_int("cod_cue").c_int("per_vc").reference("cod_emp", "empresas").
            reference("cod_cli", "clientes").reference("cod_cue", "cuentas").exec(db);
  }
  public static void crear_cg(DB db, Integer emp) throws SQLException {
    crear_empresas(db);
    crear_proveedores(db);
    crear_cuentas(db);
    db.create("cg" + emp).c_cod("cod_cg").c_int("cod_emp").c_int("suc_cg").c_int("nco_cg").c_date("fec_cg").
            c_int("let_cg").c_int("cod_pro").c_double("ngr_cg").c_double("grv_cg").c_double("exe_cg").c_double("int_cg").
            c_double("piv_cg").c_double("pib_cg").c_int("cod_cue").c_int("per_cg").c_double("lit_cg").reference("cod_emp", "empresas").
            reference("cod_pro", "proveedores").reference("cod_cue", "cuentas").exec(db);
  }
  public static void crear_alicuotas(DB db) throws SQLException {
    db.create("alicuotas").c_cod("cod_ali").c_double("por_ali").exec(db);
    Double alis[] = {.21, .105, .27, .13};
    for(Integer i = 0; i < 4; i++) db.insert("alicuotas").ca(db, "cod_ali", "por_ali").v_int(i + 1).v_double(alis[i]).exec(db);
  }
  public static void crear_empali(DB db, Integer emp) throws SQLException {
    db.create("empali" + emp).c_int("cod_emp").c_int("cod_com").c_int("cod_ali").c_double("imp_eal").
            reference("cod_emp", "empresas").reference("cod_com", "comprobantes").reference("cod_ali", "alicuotas").exec(db);
  }
  public static void crear_comprobantes(DB db) throws SQLException {
    db.create("comprobantes").c_cod("cod_com").c_int("cos_com").c_varchar("nom_com", 5).c_boolean("ivd_com").exec(db);
    String comps[] = {"FAC", "REC", "NCR", "NDB", "TIC"};
    String letras[] = {" A", " B", " C"};
    Integer cos[] = {1, 6, 11, 4, 9, 15, 3, 8, 13, 2, 7, 12, 81, 82, 83};
    for(Integer i = 0; i < comps.length; i++) for(Integer j = 0; j < letras.length; j++)
      db.insert("comprobantes").ca(db, "cod_com", "nom_com", "cos_com", "ivd_com").v_int(1 + i * letras.length + j).
              v_varchar(comps[i] + letras[j]).v_int(cos[i * letras.length + j]).v_boolean(j == 0).exec(db);
    db.insert("comprobantes").ca(db, "nom_com", "cos_com", "ivd_com").v_varchar("TIC Z").v_int(83).v_boolean(false).exec(db);
  }
}