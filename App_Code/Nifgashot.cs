using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Nifgashot
/// </summary>
public class Nifgashot
{
    public Nifgashot()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public static string MaxLen(string text, int len)
    {
        if (text.Length > len)
            return text.Substring(0, len);
        else
            return text;
    }

    public static string NewPic(string intext, string pic_size)
    {
        string result = "";
        if (string.IsNullOrEmpty(intext))
        {
            result = "<img src='/media/K5YdA2f.jpeg'>";
            return result;
        }
        if (intext != "0")
            result = "<img src='/media/" + pic_size + "/" + intext + "' border='0'>";
        else if (intext == "0" | string.IsNullOrEmpty(intext) == true)
            result = "<img src='/media/K5YdA2f.jpeg'>";
        else
            result = "<img src='/media/K5YdA2f.jpeg'>";
        return result;
    }

    public static int sumUserBalance(int UserNum) // create 04/01/2010
    {
        using (var con = databaseCon.create_sql_con())
        {
            SqlCommand cmd = new SqlCommand("sumUserBalance", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@UserID", UserNum);
            return int.Parse(cmd.ExecuteScalar().ToString());
        }
    }

}