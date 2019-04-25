using Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for cacheDB
/// </summary>
public class cacheDB
{
    public cacheDB()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public static bool DONTuseCache = true;
    public static List<DomainsList> GetDomainsList()
    {
        if (HttpContext.Current.Cache["DomainsList"] == null || DONTuseCache)
        {
            using (var db = new Entities.Entities())
            {
                var dl = from a in db.DomainsList
                         select a;
                HttpContext.Current.Cache["DomainsList"] = dl.ToList();
            }
        }
        return (List<DomainsList>)HttpContext.Current.Cache["DomainsList"];
    }
    public static List<CountryList> GetCountryList()
    {
        if (HttpContext.Current.Cache["CountryList"] == null || DONTuseCache)
        {
            using (var db = new Entities.Entities())
            {
                // db.CountryList.Load();
                HttpContext.Current.Cache["CountryList"] = db.CountryList.ToList();
            }
        }
        return (List<CountryList>)HttpContext.Current.Cache["CountryList"];
    }
}