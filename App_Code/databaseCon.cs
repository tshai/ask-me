using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for databaseCon
/// </summary>
public class databaseCon
{
	public databaseCon()
	{
		//
		// TODO: Add constructor logic here
		//
	}

	public static SqlConnection create_sql_con()
	{
		SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["askme"].ConnectionString);
		con.Open();
		return con;
	}
	public static string scalerSql(string sqlQuery)
	{
		using (SqlConnection con = create_sql_con())
		{
			SqlCommand cmd = new SqlCommand(sqlQuery, con);
			return cmd.ExecuteScalar().ToString();
		}
	}

	public static string ExecuteNonQuerySql(string sqlQuery)
	{
		using (SqlConnection con = create_sql_con())
		{
			SqlCommand cmd = new SqlCommand(sqlQuery, con);
			return cmd.ExecuteNonQuery().ToString();
		}
	}
}