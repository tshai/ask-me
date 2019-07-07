using System;

using System.Globalization;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.UI;
/// <summary>
/// Summary description for CaltureCompanyLogin
/// </summary>
public class CaltureCompanyLogin : Page
{
    public CaltureCompanyLogin()
    {
    }

    protected void Page_PreInit(object sender, System.EventArgs e)
    {
        Theme = "controlPanelWhite";
        var domainList_ = populateClassFromDB.PopulateDomainsList();
        Tools.InitializeCulture(domainList_);
        Thread.CurrentThread.CurrentUICulture = new CultureInfo(HttpContext.Current.Session["CurrentCulture"].ToString());
        Thread.CurrentThread.CurrentCulture = new CultureInfo(HttpContext.Current.Session["CurrentCulture"].ToString());
        if (HttpContext.Current.Session["UserID"] == null)
        {
            HttpContext.Current.Response.Redirect("/companies/companyLogin.aspx", true);
        }
    }
}