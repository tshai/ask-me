using Entities;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;

/// <summary>
/// Summary description for antiFraud
/// </summary>
public class antiFraud
{
    public antiFraud()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public static int PassesLuhnTest(string cardNumber)
    {
        // Clean the card number- remove dashes and spaces
        cardNumber = cardNumber.Replace("-", "").Replace(" ", "");

        // Convert card number into digits array
        int[] digits = new int[cardNumber.Length - 1 + 1];
        int len = 0;
        while (len < cardNumber.Length)
        {
            digits[len] = Int32.Parse(cardNumber.Substring(len, 1));
            len += 1;
        }

        // Luhn Algorithm
        // Adapted from code availabe on Wikipedia at
        // http://en.wikipedia.org/wiki/Luhn_algorithm
        int sum = 0;
        bool alt = false;
        int i = digits.Length - 1;
        while (i >= 0)
        {
            int curDigit = digits[i];
            if (alt)
            {
                curDigit *= 2;
                if (curDigit > 9)
                    curDigit -= 9;
            }
            sum += curDigit;
            alt = !alt;
            i -= 1;
        }

        // If Mod 10 equals 0, the number is good and this will return true
        if ((sum % 10 == 0) == true)
            return 0;
        else
            return 1;
    }

    public static void LogFroadAttempt(string last_digits, string id_number, string CCNumber, string expMonth, string expYear, string cvv, int userID, string errorDesc, int ccID)
    {
        using (var con = databaseCon.create_sql_con())
        {
            SqlCommand cmd = new SqlCommand("INSERT INTO AntiFraudLog ([DateIn],[UserID],[Reason],[CCNumber],[ExpMonth],[ExpYear],[Cvv],[Active],[IdNumber],[LastDigits],[Treatment],[IpAddress],[Country],[Priority],[CCCountry],[CcDetailsID])VALUES(@DateIn, @UserID, @Reason, @CCNumber, @ExpMonth, @ExpYear, @Cvv, @Active, @IdNumber, @LastDigits, @Treatment, @IpAddress, @Country, @Priority, @CCCountry, @CcDetailsID)", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@DateIn", SqlDbType.DateTime).Value = DateTime.Now;
            cmd.Parameters.Add("@UserID", SqlDbType.Int).Value = userID;
            cmd.Parameters.Add("@ExpMonth", SqlDbType.VarChar, 2).Value = expMonth;
            cmd.Parameters.Add("@ExpYear", SqlDbType.VarChar, 2).Value = expYear;
            cmd.Parameters.Add("@Cvv", SqlDbType.VarChar, 4).Value = cvv;
            cmd.Parameters.Add("@LastDigits", SqlDbType.VarChar, 4).Value = last_digits;
            cmd.Parameters.Add("@IdNumber", SqlDbType.VarChar, 12).Value = id_number;
            cmd.Parameters.Add("@qType", SqlDbType.Int).Value = 10;
            cmd.Parameters.Add("@Reason", SqlDbType.VarChar, 50).Value = errorDesc;
            cmd.Parameters.Add("@IpAddress", SqlDbType.VarChar, 15).Value = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
            cmd.Parameters.Add("@Country", SqlDbType.VarChar, 50).Value = "none";
            cmd.Parameters.Add("@CCNumber", SqlDbType.VarChar, 50).Value = CCNumber;
            cmd.Parameters.Add("@Active", SqlDbType.Int).Value = 1;
            cmd.Parameters.Add("@Treatment", SqlDbType.NVarChar).Value = "";
            cmd.Parameters.Add("@Priority", SqlDbType.Int).Value = 1;
            cmd.Parameters.Add("@CCCountry", SqlDbType.Int).Value = "";
            cmd.Parameters.Add("@CcDetailsID", SqlDbType.Int).Value = ccID;
            cmd.ExecuteNonQuery();
        }
    }

    public static int checkEmail(string email)
    {
        string pattern;
        pattern = @"^([0-9a-zA-Z]([-\.\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9})$";

        if (Regex.IsMatch(email, pattern))
            return 1;
        else
            return 0;
    }

    public static string getTransactionId(string tempAnswer)
    {
        var transID = "";
        var arrayOfParams = tempAnswer.Split('&');
        var myStringDictionary = new StringDictionary();
        foreach (string i in arrayOfParams)
        {
            var couple = i.Split('=');
            if (couple[0] == "transid")
            {
                transID = couple[1];

            }
        }
        return transID;
    }

    public static string getCCAnswer(string tempAnswer)
    {
        int x = tempAnswer.ToString().IndexOf("status=");
        int y = tempAnswer.ToString().IndexOf("errormessage");
        return tempAnswer.Substring(x + 7, (y - 1) - (x + 7));
    }

    public static string get3dURl(string tempAnswer)
    {
        var url = "";
        var arrayOfParams = tempAnswer.Split('&');
        var myStringDictionary = new StringDictionary();
        foreach (string i in arrayOfParams)
        {
            var couple = i.Split('=');
            if (couple[0] == "url_3ds")
            {
                url = couple[1];

            }
        }
        return url;
    }

    public static void cc_faild(string card_expire_year, string card_expire_month, string cardnumber, string cvv2, string id_number, string last_digits, int userID, string error)
    {
        var logCCFaild = new LogCcFaild
        {
            CardNumber = cardnumber,
            Cvv = cvv2,
            DateIn = DateTime.Now,
            ErrorNum = error,
            IdNumber = decimal.Parse(id_number),
            IpAddress = userClass.extractUserIp(),
            LastDigits = last_digits,
            MonthDate = card_expire_month,
            Status = 0,
            UserID = userID,
            YearDate = card_expire_year
        };
        using (var db = new Entities.Entities())
        {
            db.LogCcFaild.Add(logCCFaild);
            db.SaveChanges();
        }
    }
}