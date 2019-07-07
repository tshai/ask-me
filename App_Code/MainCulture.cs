using System.Globalization;
using System.Threading;
using System.Web;
using System.Web.UI;

public class MainCulture : Page
{
    protected override void InitializeCulture()
    {
        HttpContext.Current.Session["Language"] = "HE";
        base.InitializeCulture();
        Thread.CurrentThread.CurrentCulture = new CultureInfo("he-IL");
        Thread.CurrentThread.CurrentUICulture = new CultureInfo("he-IL");
    }

    protected void Page_PreInit(object sender, System.EventArgs e)
    {
        HttpContext.Current.Session["Language"] = "HE";
        var domainList_ = populateClassFromDB.PopulateDomainsList();
        Tools.InitializeCulture(domainList_);
        if (Session["UserID"] == null)
        {
            Theme = "nifgashot";
        }
        else
        {
            Theme = "nifgashotInside";
        }
        //if (string.IsNullOrEmpty(Session["UserNum"].ToString()) | string.IsNullOrEmpty(Session["login"].ToString()))
        //{
        //    if (string.IsNullOrEmpty(Session["Language"].ToString()) == true)
        //        Session["Language"] = "HE";
        //    if (Session["Language"].ToString() == "HE")
        //        Theme = "nifgashot";
        //}
        //else
        //{
        //    if (string.IsNullOrEmpty(Session["Language"].ToString()) == true)
        //        Session["Language"] = "HE";
        //    if (Session["Language"].ToString() == "HE")
        //        Theme = "login";
        //    if (string.IsNullOrEmpty(Session["UserNum"].ToString()) | string.IsNullOrEmpty(Session["login"].ToString()))
        //        Response.Redirect("/users/login.aspx");
        //}
    }
}
