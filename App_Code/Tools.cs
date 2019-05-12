using Entities;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net;
using System.Threading;
using System.Web;
using Twilio;
using Twilio.Http;
using Twilio.Rest.Api.V2010.Account;

/// <summary>
/// Summary description for Tools
/// </summary>
public class Tools
{
    public Tools()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public static int RandomNumber(int min, int max)
    {
        Random random = new Random();
        return random.Next(min, max);
    }
    public static string GetHash(string input)
    {
        byte[] bytes = System.Text.Encoding.ASCII.GetBytes(input);
        var hashed = System.Security.Cryptography.SHA256.Create().ComputeHash(bytes);
        return Convert.ToBase64String(hashed);
    }
    public static string twiloSms(string PhoneNumber, string body1)
    {
        // Find your Account Sid And Token at twilio.com/console
        string accountSid = "AC74811f637555481f520ae752557c96a0";
        string authToken = "1641146cb18443438e32fbe9d35959e1";

        TwilioClient.Init(accountSid, authToken);
        var answer = "";
        try
        {
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls
                                                | SecurityProtocolType.Tls11
                                                | SecurityProtocolType.Tls12
                                                | SecurityProtocolType.Ssl3;
            var message = MessageResource.Create(
            body: body1,
            from: new Twilio.Types.PhoneNumber("+14024036329"),
            //statusCallback: new Uri("https://www.ask-me.app/dd.aspx"),
            to: new Twilio.Types.PhoneNumber("+" + PhoneNumber)
        );

            answer = "2";

            //var from1 = new Twilio.Types.PhoneNumber("+14024036329");
            //var to1 = new Twilio.Types.PhoneNumber("+972502263423");
            //message = MessageResource.Create(body: "test", from: from1, to: to1).ToString() ;
        }
        catch (Exception ex)
        {

            HttpContext.Current.Response.Write(ex.StackTrace + ex.Message + ex.InnerException);
            answer = ex.Message;
        }
        return answer;
        //const string accountSid = "AC74811f637555481f520ae752557c96a0";
        //const string authToken = "your_auth_token";

        //TwilioClient.Init(accountSid, authToken);

        //var message = MessageResource.Create(
        //    body: "Join Earth's mightiest heroes. Like Kevin Bacon.",
        //    from: new Twilio.Types.PhoneNumber("+14024036329"),
        //    to: new Twilio.Types.PhoneNumber("+972502263423")
        //);


        //HttpContext.Current.Response.End();
        //var message = MessageResource.Create(body: body1, from: new Twilio.Types.PhoneNumber("+14024036329"), to: new Twilio.Types.PhoneNumber("+" + PhoneNumber));
        //return message.ToString();
    }

    public static string webRequest(string mystring)
    {
        try
        {
            Uri uri = new Uri(mystring);
            HttpWebRequest request1 = (HttpWebRequest)HttpWebRequest.Create(uri);
            request1.ContentType = "application/x-www-form-urlencoded";
            request1.Method = WebRequestMethods.Http.Get;
            HttpWebResponse response1 = (HttpWebResponse)request1.GetResponse();
            StreamReader reader = new StreamReader(response1.GetResponseStream());
            string ans = reader.ReadToEnd();
            response1.Close();
            return ans;
        }
        catch (Exception ex)
        {
            errors.insertErrors(ex);
            return ex.Message;
        }
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

    public static countryData getCountry()
    {
        var jsonString = webRequest("http://api.ipstack.com/" + Tools.extractUserIp() + "?access_key=c35b25265aab950ed1e5fe46fe76ded3");
        return JsonConvert.DeserializeObject<countryData>(jsonString);
    }

    public static void addWindowsServiceLogs(int SupplierID, int CustomerID, string RndNumber, string eventDesc, int isError)
    {
        databaseCon.ExecuteNonQuerySql("INSERT INTO windowsServiceLogs(SupplierID, CustomerID, eventDesc, RndNumber, isError) VALUES (" + SupplierID + " ," + CustomerID + ",'" + eventDesc + "','" + RndNumber + "'," + isError + ")");
    }
    public static void InitializeCulture(DomainsList domainList_)
    {
        CountryList countryList = populateClassFromDB.populateCountryList(domainList_.MainCountryID);
        if (HttpContext.Current.Session["MainCountryID"] == null)
            //HttpContext.Current.Session["country_code"] = getCountry().CountryCode.ToString().ToLower();
            HttpContext.Current.Session["MainCountryID"] = domainList_.MainCountryID;
        HttpContext.Current.Session["ImageSize"] = domainList_.ImageSize;

        HttpContext.Current.Session["Direction"] = domainList_.Direction;
        HttpContext.Current.Session["TextAlign"] = domainList_.TextAlign;

        if (domainList_.TextAlign == "right")
            HttpContext.Current.Session["oppositeTextAlign"] = "left";
        else
            HttpContext.Current.Session["oppositeTextAlign"] = "right";

        HttpContext.Current.Session["LanguageID"] = domainList_.LanguageID;
        // HttpContext.Current.Session["Language") = domainList_.CountryList.CultureInfo
        // Thread.CurrentThread.CurrentUICulture = New CultureInfo("he-IL")
        // Thread.CurrentThread.CurrentCulture = New CultureInfo("he-IL")
        HttpContext.Current.Session["CurrentCulture"] = countryList.CultureInfo;


        // HttpContext.Current.Session["CurrentCulture") = "en-US"
        // HttpContext.Current.Session["CurrentCulture") = countryList.CultureInfo
        // HttpContext.Current.Session["LanguageID") = domainList_.LanguageID
        // HttpContext.Current.Session["mobileDomainName") = domainList_.mobileDomainName
        // If HttpContext.Current.Request.Url.Host = HttpContext.Current.Session["mobileDomainName").ToString() Then
        // HttpContext.Current.Session["Theme") = domainList_.Templates.themeMobile
        // Else
        //var template_ = populateClassFromDB.populateTemplate(domainList_.templateID);
        //HttpContext.Current.Session["Theme"] = template_.theme;
        //HttpContext.Current.Session["master"]= template_.masterPage;
        // End If
        HttpContext.Current.Session["DomainName"] = domainList_.DomainName;

        HttpContext.Current.Session["countryCode"] = countryList.CountryCode;
        HttpContext.Current.Session["domainsTypeID"] = domainList_.DomainTypeID;
        // HttpContext.Current.Application["categoryLevel"] = dominaList_.categoryLevel;
        HttpContext.Current.Session["logo"] = domainList_.LogoName;
        // HttpContext.Current.Session["shippingCountryID"] = dominaList_.shippingCountryID;
        HttpContext.Current.Session["DomainsListID"] = domainList_.ID;
        HttpContext.Current.Session["FriendlyName"] = domainList_.FriendlyName;
        // HttpContext.Current.Application["Facebook"] = dominaList_.facebookButton;
        HttpContext.Current.Session["FacebookAppID"] = domainList_.FacebookAppID;
        HttpContext.Current.Session["FacebookAppSecret"] = domainList_.FacebookSecret;
        HttpContext.Current.Session["redirect"] = "/";

        Thread.CurrentThread.CurrentUICulture = new CultureInfo(HttpContext.Current.Session["CurrentCulture"].ToString());

        using (Entities.Entities db = new Entities.Entities())
        {
            int countryID = domainList_.MainCountryID;
            CountryList countryList1 = (from a in db.CountryList
                                        where a.ID == countryID
                                        select a).FirstOrDefault();
            if (countryList1 != null)
            {
                HttpContext.Current.Session["timeZoneID"] = countryList1.TimeZoneID;
                HttpContext.Current.Session["currency"] = countryList1.Currencies.CurrencySymbol;
                HttpContext.Current.Session["currencyID"] = countryList1.CurrencyID;
                HttpContext.Current.Session["currencySide"] = countryList1.Currencies.CurrencySide;
            }
            else
                HttpContext.Current.Session["currency"] = "$";
        }
    }

}
public class countryData
{
    public string Ip { get; set; }
    public string CountryCode { get; set; }
    public string TimeZone { get; set; }
    public string ZipCode { get; set; }
    public string RegionCode { get; set; }
    public string RegionName { get; set; }
    public string City { get; set; }
    public string Latitude { get; set; }
    public string MetroCode { get; set; }
    public string CountryName { get; set; }
}
