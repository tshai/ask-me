<%@ Page Title="" Language="C#" MasterPageFile="~/masters/mainMaster.master" EnableViewState="false" Inherits="MainCulture" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        Button1.Text = populateClassFromDB.GetSiteMessagesByKey("newEmployee");
        RequiredFieldValidator2.ErrorMessage = populateClassFromDB.GetSiteMessagesByKey("Password");
    }

    protected void Button1_Click(object sender, System.EventArgs e)
    {
        if (Page.IsValid)
        {
            var userID = int.Parse(Session["UserID"].ToString());
            using (var db = new Entities())
            {
                var q = (from a in db.Users
                         where a.ID == userID
                         select a);
                Users user = new Users();
                if (q.Any())
                {
                    if (q.FirstOrDefault().Password == password.Text.Trim())
                    {
                        Response.Redirect("/nifgashot/nifgashot.aspx?message=1603");
                    }
                    else
                    {
                        Response.Redirect("/nifgashot/activateAccount.aspx?message=626");
                    }
                }
            }
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="flotTo">
        <div id="top_message" runat="server" style="width: 100%; height: 40px; border: solid thin Black; padding: 20px 10px 10px 10px; margin: 20px 0 10px 10px; background-color: #990000;"
            visible="false">
            <asp:HyperLink ID="HyperLink2" runat="server">
                <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
            </asp:HyperLink><br />
            <asp:Label ID="Label4" ForeColor="white" Font-Size="18px" runat="server" Text=""></asp:Label>
        </div>
        <div class="register">
            <h2><%= populateClassFromDB.GetSiteMessagesByKey("newEmployee")%></h2>

            <div class="rowForm">
                <label for="<%=password.ClientID  %>"><%=populateClassFromDB.GetSiteMessagesByKey("Password")%>:</label>
                <asp:TextBox ID="password" runat="server" TextMode="Password" MaxLength="8"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic"
                    ForeColor="yellow" SetFocusOnError="true" Text="" ControlToValidate="password" />
            </div>
            <div class="rowForm">
                <asp:Button ID="Button1" runat="server" CssClass="dr5" OnClick="Button1_Click"
                    OnClientClick="if(!this.form.CheckBoxPrint.checked){alert(markTerms);return false}else{$('.BBB').css('visibility','visible');}" />
            </div>
        </div>
    </div>
</asp:Content>

