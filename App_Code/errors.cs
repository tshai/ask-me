using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for errors
/// </summary>
public class errors
{
	public errors()
	{
		//
		// TODO: Add constructor logic here
		//
	}



	public static void addErrorString(string desc)
	{
		string connection = ConfigurationManager.ConnectionStrings["errorReports"].ConnectionString;
		string website = HttpContext.Current.Request.Url.ToString().Replace("http://", string.Empty);
		using (SqlConnection con = new SqlConnection(connection))
		{
			con.Open();
			SqlCommand cmd = new SqlCommand("insertError", con);
			cmd.CommandType = CommandType.StoredProcedure;
			cmd.Parameters.Add("shortName", SqlDbType.VarChar).Value = checkErrorLenght(desc);
			cmd.Parameters.Add("longName", SqlDbType.NVarChar).Value = "";
			cmd.Parameters.Add("userIP", SqlDbType.NVarChar).Value = HttpContext.Current.Request.UserHostAddress;
			cmd.Parameters.Add("website", SqlDbType.NVarChar).Value = HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority) + HttpContext.Current.Request.ApplicationPath; // website.Remove(website.IndexOf("/"))
			cmd.Parameters.Add("webpage", SqlDbType.NVarChar).Value = HttpContext.Current.Request.Url.ToString().Split('?')[0];
			try
			{
				cmd.ExecuteNonQuery();
				HttpContext.Current.Server.ClearError();
			}
			catch
			{
				HttpContext.Current.Server.ClearError();
				HttpContext.Current.Response.Redirect("/?eferf");
			}
		}
	}

	public static string checkErrorLenght(string errorString)
	{
		if (errorString.Length > 4000)
		{
			return errorString.Substring(0, 4000);
		}
		return errorString;
	}

	public static void insertErrors(Exception ex)
	{
		using (SqlConnection con = create_sql_conError())
		{
			SqlCommand cmd = new SqlCommand("insertError", con);
			cmd.CommandType = CommandType.StoredProcedure;
			cmd.Parameters.Add("shortName", SqlDbType.NVarChar).Value = ex.Message;
			cmd.Parameters.Add("longName", SqlDbType.NVarChar).Value = ex.StackTrace + HttpContext.Current.Request.ServerVariables["all_http"] + HttpContext.Current.Request.ServerVariables["HTTP_REFERER"];
			cmd.Parameters.Add("userIP", SqlDbType.NVarChar).Value = userClass.extractUserIp();
			cmd.Parameters.Add("website", SqlDbType.NVarChar).Value = "performers.newcam.biz";
			cmd.Parameters.Add("webpage", SqlDbType.NVarChar).Value = HttpContext.Current.Request.Url.ToString();

			// Try
			cmd.ExecuteNonQuery();
			HttpContext.Current.Server.ClearError();
		}
	}

	public static SqlConnection create_sql_conError()
	{
		SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["errorReports"].ConnectionString);
		con.Open();
		return con;
	}

}