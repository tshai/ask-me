using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.UI;

/// <summary>
/// Summary description for caltureCustomer
/// </summary>
public class caltureCustomer:Page
{
    public caltureCustomer()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    protected void Page_PreInit(object sender, System.EventArgs e)
    {

       
        if (HttpContext.Current.Session["UserID"] != null)
        {
            MasterPageFile = "~/masters/controlPanelWhite.master";
            Theme = "controlPanelWhite";
        }
        else
        {
            MasterPageFile = "~/masters/Main.master";
            Theme = "main";
        }

       


        var domainList_ = populateClassFromDB.PopulateDomainsList();

        Tools.InitializeCulture(domainList_);
        Thread.CurrentThread.CurrentUICulture = new CultureInfo(Session["CurrentCulture"].ToString());
        Thread.CurrentThread.CurrentCulture = new CultureInfo(Session["CurrentCulture"].ToString());
    }
}