using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;
/// <summary>
/// Summary description for camCheck
/// </summary>
public class camCheck
{
    public camCheck()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public static void checkStauts(int SupplierID)
    {
        using (SqlConnection con = databaseCon.create_sql_con())
        {
            SqlCommand cmd = new SqlCommand("windowsService", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@SupplierID", SqlDbType.Int).Value = SupplierID;
            cmd.ExecuteNonQuery();
        }
    }



}