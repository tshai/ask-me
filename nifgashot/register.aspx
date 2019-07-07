<%@ Page Title="" Language="C#" MasterPageFile="~/masters/mainMaster.master" EnableViewState="false" Inherits="MainCulture" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        Button1.Text = populateClassFromDB.GetSiteMessagesByKey("newEmployee");
        RequiredFieldValidator1.ErrorMessage = populateClassFromDB.GetSiteMessagesByKey("Phone");
        // RequiredFieldValidator2.ErrorMessage = populateClassFromDB.GetSiteMessagesByKey("Password");
        RequiredFieldValidator3.ErrorMessage = populateClassFromDB.GetSiteMessagesByKey("countryCode");
    }

    protected void Button1_Click(object sender, System.EventArgs e)
    {
        if (Page.IsValid)
        {
            var phoneNumArr = phone.Text.Where(c => char.IsDigit(c)).ToArray();
            var countryCArr = countryCode.Text.Where(c => char.IsDigit(c)).ToArray();
            //  var pass = password.Text.Trim();
            var phoneNum = string.Join("", phoneNumArr);
            if (phoneNum[0] == '0')
            {
                phoneNum = phoneNum.Remove(0, 1);
            }
            var countryC = string.Join("", countryCArr);
            var FullPhone = countryC + phoneNum;
            //Response.Write(FullPhone);
            //Response.End();
            using (var db = new Entities())
            {
                var q = (from a in db.Users
                         where a.Phone == FullPhone
                         select a);
                Users user = new Users();
                if (q.Any() == false)
                {

                    var generateNumber = countryC + Tools.RandomNumber(100000, 999999);
                    while (SupplierAPI.GenerateNumber(generateNumber, countryC) == "")
                    {
                        generateNumber = countryC + Tools.RandomNumber(100000, 999999);
                    }

                    user.Phone = FullPhone;
                    user.DateIn = DateTime.Now;
                    user.Active = 0;
                    user.Pic1 = "0";
                    user.Name = "Empty";
                    user.ExtraDetails = "";
                    user.YearBirth = 2000;
                    user.Gender = 1;
                    //user.MinSessionLength = 0;
                    //user.PricePerMinute = 0;
                    //user.CurrencyID = 1;
                    user.SmsCode = 111111;
                    user.CountryCode = countryC;
                    user.MainModelGuid = Guid.NewGuid();
                    user.Password = user.SmsCode.ToString();
                    user.GenerateNumber = generateNumber;
                    user.UserChatGuid = Guid.NewGuid();
                    user.IsSupplier = 0;
                    user.IsPublicUser = 0;
                    db.Users.Add(user);
                    db.SaveChanges();
                    Session["UserID"] = user.ID;
                    Response.Redirect("activateAccount.aspx?message=1602");
                }
                else
                {
                    Response.Redirect("register.aspx?message=1");
                }
            }
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="https://rawgit.com/RobinHerbots/jquery.inputmask/3.x/dist/jquery.inputmask.bundle.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script>
        var markTerms = '<%=populateClassFromDB.GetSiteMessagesByKey("agreeToTerms") %>';
    </script>
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
            <div class="rowForm" style="display: -webkit-box;">

                <div>
                    <label for="<%=phone.ClientID  %>"><%=populateClassFromDB.GetSiteMessagesByKey("phone")%>:</label>
                    <asp:TextBox ID="phone" runat="server" type="tel"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic"
                        ForeColor="yellow" SetFocusOnError="true" Text="" ControlToValidate="phone" />
                </div>
                <div>
                    <label for="<%=countryCode.ClientID  %>"><%=populateClassFromDB.GetSiteMessagesByKey("countryCode")%>:</label>
                    <asp:TextBox ID="countryCode" Width="100px" runat="server" type="tel"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Display="Dynamic"
                        ForeColor="yellow" SetFocusOnError="true" Text="" ControlToValidate="countryCode" />
                </div>
            </div>

<%--            <div class="rowForm">
                <label for="<%=password.ClientID  %>"><%=populateClassFromDB.GetSiteMessagesByKey("Password")%>:</label>
                <asp:TextBox ID="password" runat="server" TextMode="Password" MaxLength="8"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" Display="Dynamic"
                    ForeColor="yellow" SetFocusOnError="true" Text="" ControlToValidate="password" />
            </div>--%>

            <div class="rowForm">
                <div>
                    <span><%=populateClassFromDB.GetSiteMessagesByKey("agreeToTerms") %></span>
                    <input type="checkbox" name="CheckBoxPrint" value="check" style="width: 14px; margin-right: 5px; float: right;" />
                </div>
            </div>
            <div class="rowForm">
                <asp:Button ID="Button1" runat="server" CssClass="dr5" OnClick="Button1_Click"
                    OnClientClick="if(!this.form.CheckBoxPrint.checked){alert(markTerms);return false}else{$('.BBB').css('visibility','visible');}" />
            </div>
        </div>
    </div>


    <script language="javascript" type="text/javascript">
        $('#ContentPlaceHolder1_phone').inputmask("999 99 99 99");
        $('#ContentPlaceHolder1_countryCode').inputmask("+999");
    </script>
</asp:Content>

