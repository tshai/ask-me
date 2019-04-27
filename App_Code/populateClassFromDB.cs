using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Entities;
/// <summary>
/// Summary description for populateClassFromDB
/// </summary>
public class populateClassFromDB
{
    public populateClassFromDB()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public static Users getUsers(int UserID)
    {
        using (var db = new Entities.Entities())
        {
            return (from a in db.Users
                    where a.ID == UserID
                    select a).FirstOrDefault();
        }
    }

    public static OnlineUsers getOnlineUsers(int SupplierID)
    {
        using (var db = new Entities.Entities())
        {
            return (from a in db.OnlineUsers
                    where a.SupplierID == SupplierID
                    select a).FirstOrDefault();
        }
    }
    //public static Templates populateTemplate(int ID)
    //{
    //    using (var db = new Entities())
    //    {
    //        return (from a in db.Templates
    //                where a.ID == ID
    //                select a).FirstOrDefault();
    //    }
    //}
    public static CountryList populateCountryList(int ID)
    {
        return (from a in cacheDB.GetCountryList()
                where a.ID == ID
                select a).FirstOrDefault();
    }
    public static string GetSiteMessagesByKey(string key)
    {
        using (var db = new Entities.Entities())
        {
            int LanguageID = int.Parse(HttpContext.Current.Session["LanguageID"].ToString());
            var siteMessageID = (from a in db.SiteMessages
                                 where a.Message == key
                                 select a.ID).First();
            var siteMessageToLang = (from a in db.SiteMessagesToLanguages
                                     where a.SiteMessageID == siteMessageID & a.LanguageID == LanguageID
                                     select a).FirstOrDefault();
            if (siteMessageToLang != null)
                return siteMessageToLang.Message;
            else
                // Class1.chooseLang(M.messageEN, M.messageBG, M.messageHE, M.messageRO);
                return "";
        }
    }


    public static string GetSiteMessages(int ID)
    {
        using (var db = new Entities.Entities())
        {
            // int domainListID = int.Parse(HttpContext.Current.Session["DomainsListID"].ToString());
            // var firstOrDefault = cacheDB.GetDomainsList().FirstOrDefault(a => a.ID == int.Parse(HttpContext.Current.Session["DomainsListID"].ToString()));
            // if (firstOrDefault != null)
            // {
            // int LanguageID = firstOrDefault.LanguageID;
            int LanguageID = int.Parse(HttpContext.Current.Session["LanguageID"].ToString());
            var siteMessageToLang = (from a in db.SiteMessagesToLanguages
                                     where a.SiteMessageID == ID & a.LanguageID == LanguageID
                                     select a).FirstOrDefault();
            if (siteMessageToLang != null)
                return siteMessageToLang.Message;
            else
                // Class1.chooseLang(M.messageEN, M.messageBG, M.messageHE, M.messageRO);
                return "";
        }
    }
    public static DomainsList PopulateDomainsList()
    {
        var currentDomain = HttpContext.Current.Request.Url.ToString();//.Substring(23, 5).ToLower();
        DomainsList DomainsList_ = new DomainsList();
        using (var db = new Entities.Entities())
        {
            DomainsList_ = (from a in cacheDB.GetDomainsList()
                                //where a.DomainName.ToLower() == currentDomain
                            where a.ID == 28
                            select a).FirstOrDefault();
        }
        return DomainsList_;
    }
    public static void addWindowsServiceLogs(int SupplierID, int UserID, string RndNumber, string eventDesc, int isError)
    {
        databaseCon.ExecuteNonQuerySql("INSERT INTO windowsServiceLogs(SupplierID, UserID, eventDesc, RndNumber, isError) VALUES (" + SupplierID + " ," + UserID + ",'" + eventDesc + "','" + RndNumber + "'," + isError + ")");
    }
}