using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for MainFunct
/// </summary>
public class MainFunct
{
    public MainFunct()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    //public static Guid InsertUserToCamera(int CustomerID, int SupplierID)
    //{
    //    using (var con = databaseCon.create_sql_con())
    //    {
    //        SqlCommand cmd = new SqlCommand("insertUserToCameraEntity", con);
    //        cmd.CommandType = CommandType.StoredProcedure;
    //        cmd.Parameters.Add("@CustomerID", SqlDbType.Int).Value = CustomerID;
    //        cmd.Parameters.Add("@SupplierID", SqlDbType.Int).Value = SupplierID;
    //        return Guid.Parse(cmd.ExecuteScalar().ToString());
    //    }
    //}
    public static void SaveUserComputer(int CustomerID, int SupplierID, Guid fatal)
    {
        using (var con = databaseCon.create_sql_con())
        {
            SqlCommand cmd = new SqlCommand("INSERT INTO userComputer (CustomerID,os,fatal,SupplierID,ip,userAgent,domain,browser) VALUES(@CustomerID,@os,@fatal,@SupplierID,@ip,@userAgent,@domain,@browser)", con);
            cmd.Parameters.Add("@CustomerID", SqlDbType.Int).Value = CustomerID;
            cmd.Parameters.Add("@SupplierID", SqlDbType.Int).Value = SupplierID;
            cmd.Parameters.Add("@os", SqlDbType.VarChar, 50).Value = HttpContext.Current.Request.Browser.Platform;
            cmd.Parameters.Add("@ip", SqlDbType.VarChar, 15).Value = userClass.extractUserIp();
            cmd.Parameters.Add("@browser", SqlDbType.VarChar, 100).Value = HttpContext.Current.Request.Browser.Type + "-" + HttpContext.Current.Request.Browser.Version;
            cmd.Parameters.Add("@userAgent", SqlDbType.VarChar, 500).Value = HttpContext.Current.Request.UserAgent ?? "blocked";
            cmd.Parameters.Add("@domain", SqlDbType.VarChar, 100).Value = HttpContext.Current.Request.ServerVariables["SERVER_NAME"];
            cmd.Parameters.Add("@fatal", SqlDbType.UniqueIdentifier).Value = fatal;
            cmd.ExecuteNonQuery();
        }
    }

}