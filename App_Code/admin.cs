using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

/// <summary>
/// Summary description for admin
/// </summary>
public class admin
{
    public admin()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public static void popUp(Page p1, string message)
    {
        Label model = (Label)admin.FindControlRecursive(p1, "modelMessage");
        model.Text = message;
        StringBuilder cstext2 = new StringBuilder();
        cstext2.Append("$(document).ready(function() {");
        cstext2.Append("$('#myModal').modal('show')");
        cstext2.Append("});");
        p1.ClientScript.RegisterStartupScript(p1.GetType(), "PopupScript", cstext2.ToString(), true);
    }
    public static Control FindControlRecursive(Control Root, string Id)
    {
        if (Root.ID == Id)
            return Root;

        foreach (Control Ctl in Root.Controls)
        {
            Control FoundCtl = FindControlRecursive(Ctl, Id);
            if (FoundCtl != null)
                return FoundCtl;
        }

        return null/* TODO Change to default(_) if this is not a reference type */;
    }
    public static void MessageInMasterPage(string message, string type, Page page1)
    {
        Panel successPanel = (Panel)FindControlRecursive(page1, "successPanel");
        Label LabelSuccessMessage = (Label)FindControlRecursive(page1, "LabelSuccessMessage");
        Panel errPanel = (Panel)FindControlRecursive(page1, "errPanel");
        Label LabelErrMessage = (Label)FindControlRecursive(page1, "LabelErrMessage");
        if (type == "success")
        {
            successPanel.Visible = true;
            errPanel.Visible = false;
            LabelSuccessMessage.Text = message;
        }
        if (type == "error")
        {
            successPanel.Visible = false;
            errPanel.Visible = true;
            LabelErrMessage.Text = message;
        }
    }
}