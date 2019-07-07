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

    public static string insertUserToCamera(int UserID, int SupplierID, Guid SupplierToServicePriceGuid)
    {
        int SupplierToServicePriceID;
        using (var db = new Entities.Entities())
        {

            SupplierToServicePriceID = (from a in db.SupplierToServicePrice where a.SupplierToServicePriceGuid == SupplierToServicePriceGuid select a.ID).First();
        }
        using (var con = databaseCon.create_sql_con())
        {
            SqlCommand cmd = new SqlCommand("insertUserToCameraEntity", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@CustomerID", SqlDbType.Int).Value = UserID;
            cmd.Parameters.Add("@SupplierID", SqlDbType.Int).Value = SupplierID;
            cmd.Parameters.Add("@SupplierToServicePriceID", SqlDbType.Int).Value = SupplierToServicePriceID;
            return cmd.ExecuteScalar().ToString();
        }
    }

    public static void userEndSession(int event1, string endError, int CustomerID, Guid RndNum)
    {
        using (var con = databaseCon.create_sql_con())
        {
            SqlCommand cmd = new SqlCommand("userEndSession2019", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@CustomerID", SqlDbType.Int).Value = CustomerID;
            cmd.Parameters.Add("@RndNumber", SqlDbType.UniqueIdentifier).Value = RndNum;
            cmd.Parameters.Add("@EndError", SqlDbType.VarChar).Value = endError;
            cmd.Parameters.Add("@event", SqlDbType.Int).Value = event1;
            cmd.ExecuteNonQuery();
        }
    }
    public static void SupplierEndSession(int event1, string endError, int SupplierID)
    {
        using (var con = databaseCon.create_sql_con())
        {
            SqlCommand cmd = new SqlCommand("SupplierEndSession", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@SupplierID", SqlDbType.Int).Value = SupplierID;
            cmd.Parameters.Add("@EndError", SqlDbType.VarChar).Value = endError;
            cmd.Parameters.Add("@event", SqlDbType.Int).Value = event1;
            cmd.ExecuteNonQuery();
        }
    }

    public static DateTime get_sql_time()
    {
        return DateTime.Parse(databaseCon.scalerSql("select getdate()"));
    }

    public static string compile_credit_card(string credit_card)
    {
        var cc = long.Parse(credit_card);
        var enc_credit_card = (cc - 6985471).ToString();
        char[] charArray = enc_credit_card.ToCharArray();
        Array.Reverse(charArray);
        return new string(charArray);
    }


    public static float getCustomerBalanceInDollar(int CustomerID)
    {
        using (var con = databaseCon.create_sql_con())
        {
            SqlCommand cmd = new SqlCommand("sumUserBalanceInDollar", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@CustomerID", SqlDbType.Int).Value = CustomerID;
            cmd.Parameters.Add("@ReturnValue", SqlDbType.Float).Direction = ParameterDirection.Output;
            //returnParameter.Direction = ParameterDirection.ReturnValue;
            cmd.ExecuteNonQuery();
            return float.Parse(cmd.Parameters["@ReturnValue"].Value.ToString());
        }
    }
    public static float getSumUserTimeCustomerToSupplier(int SupplierID, float SumUserBalance, int SupplierToServicePriceID)
    {
        using (var con = databaseCon.create_sql_con())
        {
            SqlCommand cmd = new SqlCommand("SumUserTimeCustomerToSupplier", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@SupplierID", SqlDbType.Int).Value = SupplierID;
            cmd.Parameters.Add("@SumUserBalance", SqlDbType.Float).Value = SumUserBalance;
            cmd.Parameters.Add("@SupplierToServicePriceID", SqlDbType.Int).Value = SupplierToServicePriceID;
            cmd.Parameters.Add("@ReturnValue", SqlDbType.Float).Direction = ParameterDirection.Output;
            //returnParameter.Direction = ParameterDirection.ReturnValue;
            cmd.ExecuteNonQuery();
            return float.Parse(cmd.Parameters["@ReturnValue"].Value.ToString());
        }
    }
    public static float getCountIfMessageCustomerToSupplier(int UserIDSendMessage, int UserIDGetMessage, float SumUserBalanceInDollar, Guid SupplierToServicePriceGuid)
    {
        using (var con = databaseCon.create_sql_con())
        {
            SqlCommand cmd = new SqlCommand("CountIfMessageCustomerToSupplier", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@UserIDSendMessage", SqlDbType.Int).Value = UserIDSendMessage;//Customer
            cmd.Parameters.Add("@UserIDGetMessage", SqlDbType.Int).Value = UserIDGetMessage;//supplier
            cmd.Parameters.Add("@SupplierToServicePriceGuid", SqlDbType.UniqueIdentifier).Value = SupplierToServicePriceGuid;//supplier
            cmd.Parameters.Add("@sumUserBalanceInDollar", SqlDbType.Float).Value = SumUserBalanceInDollar;
            cmd.Parameters.Add("@ReturnValue", SqlDbType.Float).Direction = ParameterDirection.Output;
            cmd.ExecuteNonQuery();
            return float.Parse(cmd.Parameters["@ReturnValue"].Value.ToString());
        }
    }





    public static string re_compile_credit_card(string credit_card)
    {
        var cc = long.Parse(credit_card);
        var enc_credit_card = (cc + 6985471).ToString();
        char[] charArray = enc_credit_card.ToCharArray();
        Array.Reverse(charArray);
        return new string(charArray);
    }
}