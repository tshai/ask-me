using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for WaitingList
/// </summary>
public class WaitingList
{
    public int UserID;
    public int SupplierID;
    public WaitingList(int UserID,int SupplierID)
    {
        this.UserID = UserID;
        this.SupplierID = SupplierID;
        //
        // TODO: Add constructor logic here
        //
    }

    public int RunClass()
    {
        if(populateClassFromDB.getOnlineUsers(SupplierID).Online == 0)
        {
            return 2;
 
        }
        if(BlackList(UserID, SupplierID) ==1)
        {
            return 3;
        }
        else
        {
            int tempAnswer = BuildWaitingList(UserID, SupplierID);
            if(tempAnswer == 1)
            {
                return 4;
            }
            if (tempAnswer == 2)
            {
                return 5;
            }
          
            //Session("login") = 2
            int temp_redirect = checkIfGirlAvailableTimeChange(UserID, SupplierID);
            if(temp_redirect == 1)
            {
                return 1;
            }
            return 1;
        }

 
    }

    public static int BuildWaitingList(int UserID, int SupplierID)
    {
        using (SqlConnection con = databaseCon.create_sql_con())
        {
            SqlCommand cmd = new SqlCommand("buildWaitingListEntity", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@UserID", UserID);
            // cmd.Parameters.AddWithValue("@q_type", 18)
            cmd.Parameters.AddWithValue("@SupplierID", SupplierID);
            return int.Parse(cmd.ExecuteScalar().ToString());
        }
    }
    public static int checkIfGirlAvailableTimeChange(int UserID, int SupplierID)
    {
        using (SqlConnection con = databaseCon.create_sql_con())
        {
            SqlCommand cmd = new SqlCommand("checkIfGirlAvailableTimeChange", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@UserID", SqlDbType.Int).Value = UserID;
            cmd.Parameters.Add("@SupplierID", SqlDbType.Int).Value = SupplierID;
            return int.Parse(cmd.ExecuteScalar().ToString());
        }
    }
    public static int BlackList(int UserID, int SupplierID)
    {
        using (SqlConnection con = databaseCon.create_sql_con())
        {
            SqlCommand cmd = new SqlCommand("select CustomerID from BlackList where SupplierID=@SupplierID and CustomerID=@CustomerID", con);
            cmd.Parameters.Add("@CustomerID", SqlDbType.Int).Value = UserID;
            cmd.Parameters.Add("@SupplierID", SqlDbType.Int).Value = SupplierID;
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
                return 1;
            else
                return 0;
        }
    }
}