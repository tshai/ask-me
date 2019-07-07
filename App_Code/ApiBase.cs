using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using Entities;

/// <summary>
/// Summary description for ApiBase
/// </summary>
public class ApiBase : Page
{
    public ApiBase()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public Users user;
    public Guid MainModelGuid;
    protected void Page_PreInit(object sender, System.EventArgs e)
    {



        if (Request["MainModelGuid"] != null)
        {
            using (var db = new Entities.Entities())
            {
                MainModelGuid = Guid.Parse(Request["MainModelGuid"].ToString());
                user = (from a in db.Users where a.MainModelGuid == MainModelGuid select a).FirstOrDefault();
            }
        }
    }
}