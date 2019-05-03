using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for userClass
/// </summary>
public class userClass
{
	public userClass()
	{
		//
		// TODO: Add constructor logic here
		//
	}

	public static string extractUserIp()
	{
		string userIp = "";
		NameValueCollection headers = HttpContext.Current.Request.Headers;
		for (int i = 0; i <= headers.Count - 1; i++)
		{
			string key = headers.GetKey(i);
			string value = headers.Get(i);
			// base.Response.Write(key + " = " + value + "<br/>");
			if (key.Trim() == "Incap-Client-IP")
			{
				userIp = value;
				return userIp;
			}
			else if (key.Trim() == "CF-Connecting-IP")
			{
				userIp = value;
				return userIp;
			}
			else if (key.Trim() == "X-Forwarded-For")
			{
				userIp = value;
				return userIp;
			}
			else
				userIp = HttpContext.Current.Request.ServerVariables["remote_addr"];
		}
		return userIp;
	}

	public static Guid insertUserToCamera(int UserID, int SupplierID)
	{
		using (var con = databaseCon.create_sql_con())
		{
			SqlCommand cmd = new SqlCommand("insertUserToCameraEntity", con);
			cmd.CommandType = CommandType.StoredProcedure;
			cmd.Parameters.Add("@CustomerID", SqlDbType.Int).Value = UserID;
			cmd.Parameters.Add("@SupplierID", SqlDbType.Int).Value = SupplierID;
			return Guid.Parse(cmd.ExecuteScalar().ToString());
		}
	}

	public static void userEndSession(int event1, string endError, int CustomerID, int SupplierID, Guid RndNum)
	{
		using (var con = databaseCon.create_sql_con())
		{
			SqlCommand cmd = new SqlCommand("userEndSession2019", con);
			cmd.CommandType = CommandType.StoredProcedure;
			cmd.Parameters.Add("@UserID", SqlDbType.Int).Value = CustomerID;
			cmd.Parameters.Add("@SupplierID", SqlDbType.Int).Value = SupplierID;
			cmd.Parameters.Add("@girl_RndNumber", SqlDbType.UniqueIdentifier).Value = RndNum;
			cmd.Parameters.Add("@EndError", SqlDbType.VarChar).Value = endError;
			cmd.Parameters.Add("@event", SqlDbType.Int).Value = event1;
			cmd.ExecuteNonQuery();
		}
	}

	public static DateTime get_sql_time()
	{
		return DateTime.Parse(databaseCon.scalerSql("select getdate()"));
	}

}