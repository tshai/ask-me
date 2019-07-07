<%@ Page Title="" Language="C#" MasterPageFile="~/masters/mainMaster.master" EnableViewState="false" Inherits="MainCulture" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        Button1.Text = populateClassFromDB.GetSiteMessagesByKey("login");
        RequiredFieldValidator1.ErrorMessage = populateClassFromDB.GetSiteMessagesByKey("Phone");
        RequiredFieldValidator2.ErrorMessage = populateClassFromDB.GetSiteMessagesByKey("Password");
    }

    protected void Button1_Click(object sender, System.EventArgs e)
    {
        var phoneNumber = string.Join("", phone.Text.Where(c => char.IsDigit(c)).ToArray());
        var pass = password.Text.Trim();

        using (var db = new Entities())
        {
            var isUser = from a in db.Users where a.Phone == phoneNumber && a.Password == pass && a.IsSupplier == 0 select a;
            if (isUser.Any())
            {
                Session["UserID"] = isUser.FirstOrDefault().ID;
                Response.Redirect("/nifgashot/performersList.aspx");
            }
            else
            {
                Response.Redirect("/nifgashot/login.aspx?message=626");
            }
        }
    }

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="https://rawgit.com/RobinHerbots/jquery.inputmask/3.x/dist/jquery.inputmask.bundle.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="flotTo">
        <div class="register">
            <h2><%=populateClassFromDB.GetSiteMessagesByKey("login") %></h2>
            <div class="rowForm">
                <label for="<%=phone.ClientID  %>"><%=populateClassFromDB.GetSiteMessagesByKey("phone")%>:</label>
                <asp:TextBox ID="phone" runat="server" TextMode="phone"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic"
                    ForeColor="yellow" SetFocusOnError="true" Text="" ControlToValidate="phone" />
            </div>

            <div class="rowForm">
                <label for="<%=password.ClientID  %>"><%=populateClassFromDB.GetSiteMessagesByKey("Password")%>:</label>
                <asp:TextBox ID="password" runat="server" TextMode="Password" MaxLength="8"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic"
                    ForeColor="yellow" SetFocusOnError="true" Text="" ControlToValidate="password" />
            </div>
            <div class="rowForm checkBox">
                <asp:CheckBox ID="rememberLoginDetails" runat="server" />
                <asp:Label ID="Label5" runat="server" AssociatedControlID="password"><%=populateClassFromDB.GetSiteMessagesByKey("rememberMe")%></asp:Label>
            </div>
            <div class="rowForm">
                <asp:Button ID="Button1" runat="server" CssClass="dr5" OnClick="Button1_Click" />
            </div>
        </div>
    </div>
    <script>
        $('#ContentPlaceHolder1_phone').inputmask("+(999) 999 99 99 99");
    </script>
</asp:Content>


