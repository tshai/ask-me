<%@ Page Language="C#" MasterPageFile="/masters/mainMaster.master" Inherits="MainCulture" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Linq" %>

<script runat="server">
    string width = "";
    string buttonStyle = "";
    protected void AsyncFileUpload1_UploadedComplete(object sender, AjaxControlToolkit.AsyncFileUploadEventArgs e)
    {
        if (AsyncFileUpload1.HasFile)
        {
            string tempfile = Guid.NewGuid().ToString();
            string fileExtension = System.IO.Path.GetExtension(e.FileName).ToLower();

            bool fileOK = Tools.ImageExtensionisOK(fileExtension);

            if (fileOK == false)
            {
                Response.End();
                return;
            }
            string strPath = MapPath("/nifgashot/media/tickets/") + tempfile;
            AsyncFileUpload1.SaveAs(strPath);
            Session["arrImages"] = tempfile;
        }
    }


    protected void Send(object sender, EventArgs e)
    {
        var userID = 1;
        if (Session["UserID"] != null)
        {
            userID = int.Parse(Session["UserID"].ToString());
        }
        var domainList_ = populateClassFromDB.PopulateDomainsList();
        SupportNew support = new SupportNew();
        support.Name = Server.HtmlEncode(TextBoxName.Text.Trim());
        support.Phone = TextBoxPhone.Text.Trim();
        support.Email = TextBoxEmail.Text.Trim();
        support.Topic = DropDownListTopic.SelectedValue;
        support.Cmessage = Server.HtmlEncode(TextBoxContent.Text.Trim());
        support.DomainsListID = domainList_.ID;
        support.OrderID = 0;
        support.UserID = userID;
        support.SupplierID = 1;
        support.NewID = 0;
        support.Department = 1;
        support.IsReadCustomer = 1;
        support.IsReadSupport = 0;
        support.IpAddress = userClass.extractUserIp();
        support.DateIn = DateTime.Now;
        support.SGuid = Guid.NewGuid().ToString();
        support.LastUpdate = DateTime.Now;
        support.TicketsStatus = 0;
        support.AdminHide = 0;
        support.EmployeeID = 0;


        using (var db = new Entities())
        {
            db.SupportNew.Add(support);
            db.SaveChanges();
        }

        SupportCorrespondence spC = new SupportCorrespondence
        {
            Cmessage = Server.HtmlEncode(TextBoxContent.Text.Trim()),
            DateIn = DateTime.Now,
            EmployeeID = 0,
            SGuid = Guid.NewGuid().ToString(),
            SupplierID = 1,
            SupportId = support.Id,
            WhoSend = 1
        };
        if (Session["arrImages"] != null)
        {
            spC.HasImages = 1;
            spC.Img = Session["arrImages"].ToString();
        }
        else
        {
            spC.HasImages = 0;
            spC.Img = "";
        }

        using (var db = new Entities())
        {
            db.SupportCorrespondence.Add(spC);
            db.SaveChanges();
        }

        TextBoxName.Text = "";
        TextBoxEmail.Text = "";
        TextBoxPhone.Text = "";
        TextBoxContent.Text = "";
        Response.Redirect("/nifgashot/contact.aspx?message=1644");
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Title = populateClassFromDB.GetSiteMessagesByKey("ContactUs");
        TextBoxName.Attributes.Add("placeholder", populateClassFromDB.GetSiteMessagesByKey("Name"));
        RequiredFieldValidatorFirstName.ErrorMessage = populateClassFromDB.GetSiteMessagesByKey("Name");
        TextBoxEmail.Attributes.Add("placeholder", populateClassFromDB.GetSiteMessagesByKey("EmailOnly"));
        RegularExpressionValidatorEmail.ErrorMessage = populateClassFromDB.GetSiteMessagesByKey("invalidEmail");
        TextBoxPhone.Attributes.Add("placeholder", populateClassFromDB.GetSiteMessagesByKey("Phone"));
        RequiredFieldValidator1.ErrorMessage = populateClassFromDB.GetSiteMessagesByKey("Phone");
        RegularExpressionValidatorPhone1.ErrorMessage = populateClassFromDB.GetSiteMessagesByKey("invalidPhone");
        RequiredFieldValidatorAddress.ErrorMessage = populateClassFromDB.GetSiteMessagesByKey("Message");
        ButtonLogin.Text = populateClassFromDB.GetSiteMessagesByKey("Send");

        if (Session["ticketGuid"] == null)
        {
            Session["ticketGuid"] = Guid.NewGuid().ToString();
        }

        ListItem0.Text = populateClassFromDB.GetSiteMessagesByKey("select");
        ListItem1.Text = populateClassFromDB.GetSiteMessagesByKey("invalidService");
        ListItem2.Text = populateClassFromDB.GetSiteMessagesByKey("technicalProblems");
        ListItem3.Text = populateClassFromDB.GetSiteMessagesByKey("payment");
        ListItem4.Text = populateClassFromDB.GetSiteMessagesByKey("other");
        RequiredFieldValidator9.Text = populateClassFromDB.GetSiteMessagesByKey("chooseTopic");
        Tools.multipleButtonClicks(Page, ButtonLogin);
    }

    protected void Page_PreInit(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
        {
            MasterPageFile = "/masters/mainMaster.master";
            Theme = "nifgashot";
        }
        else
        {
            MasterPageFile = "/masters/insideMain.master";
            Theme = "nifgashot";
        }
        var domainList_ = populateClassFromDB.PopulateDomainsList();
        Tools.InitializeCulture(domainList_);
    }

</script>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        #ctl00_Body_AsyncFileUpload1_ctl04 {
            border: none;
        }

        .orderDataDiv {
            background-color: #717171;
            width: 320px;
            color: white;
            border-radius: 5px;
            margin: 10px 0;
            padding: 10px;
        }

            .orderDataDiv ul li {
                border-bottom: 1px solid white;
            }


            .orderDataDiv label {
                display: inline-block;
            }

        #contectForm {
            margin: auto;
            margin-top: 100px;
        }

        .rowForm select {
            width: 250px;
            height: 50px;
            font-size: 16px;
            padding-left: 20px;
            padding-right: 20px;
            box-sizing: border-box;
            border: 1px solid #c1c1c1;
            border-radius: 5px;
            background-color: #fbfbfb;
        }

        #topCompanySignIn {
            margin-top: 0px !important;
        }

        .fa-star {
            font-size: 6px !important;
            color: red !important;
            margin-left: 5px !important;
        }

        .rowForm label {
            display: flex !important;
        }

        .rowForm textarea {
            width: 250px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script>
        function numbersonly(e) {
            var unicode = e.charCode ? e.charCode : e.keyCode
            if (unicode != 8 && unicode != 13) { //if the key isn't the backspace key (which we should allow)
                if (unicode < 48 || unicode > 57) //if not a number
                    return false; //disable key press
            }
            if (unicode == 13 && passFocus == 'true') {
                CheckPassUser();
            }
        }

        function uploadError(sender, args) {
            document.getElementById('<%=lblStatus.ClientID%>').innerText = args.get_fileName() + "<span style='color:red;'>" + args.get_errorMessage() + "</span>";
        }

        function StartUpload(sender, args) {
            document.getElementById('<%=lblStatus.ClientID%>').innerText = 'העלאת קובץ התחילה';
        }

        function UploadComplete(sender, args) {
            var filename = args.get_fileName();
            var elem = document.createElement("img");
            elem.setAttribute("height", "50");
            elem.setAttribute("width", "50");
            elem.src = "/nifgashot/media/tickets/" + newGuid + "_" + filename;
            document.getElementById("displayImages").appendChild(elem);
            var contentType = args.get_contentType();
            var text = "UploadComplete - Size of " + filename + " is " + args.get_length() + " bytes";
            //if (contentType.length > 0) {
            //    text += " and content type is '" + contentType + "'.";
            //}
            document.getElementById('<%=lblStatus.ClientID%>').innerText = text;
        }
        var newGuid = '<%=Session["ticketGuid"]%>';

    </script>
    <div class="flotTo">
        <div class="form">
            <div class="row">
                <div class="formBody">
                    <div class="rowForm">
                        <label for="<%= TextBoxName.ClientID %>"><%=populateClassFromDB.GetSiteMessagesByKey("FullName")%><i class="fa fa-star"></i></label>

                        <asp:TextBox ID="TextBoxName" runat="server" CssClass="form-control" MaxLength="49"></asp:TextBox>
                        <asp:RequiredFieldValidator CssClass="formValidation" ID="RequiredFieldValidatorFirstName" runat="server"
                            ControlToValidate="TextBoxName" Display="Dynamic" SetFocusOnError="True" />

                    </div>
                    <div class="rowForm">
                        <label for="<%= TextBoxEmail.ClientID %>">
                            <%=populateClassFromDB.GetSiteMessagesByKey("EmailOnly")%><i class="fa fa-star"></i></label>
                        <asp:TextBox ID="TextBoxEmail" runat="server" CssClass="form-control" MaxLength="49"></asp:TextBox>
                        <%--                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorEmail" runat="server" ErrorMessage="<%$ Resources: Resources, Email %>"
                        ControlToValidate="TextBoxEmail" Display="Dynamic" SetFocusOnError="True" CssClass="formValidation" />--%>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidatorEmail" runat="server"
                            Display="Dynamic" ControlToValidate="TextBoxEmail" CssClass="formValidation"
                            ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                    </div>
                    <div class="rowForm">
                        <label for="<%= TextBoxPhone.ClientID %>"><%=populateClassFromDB.GetSiteMessagesByKey("Phone")%><i class="fa fa-star"></i></label>
                        <asp:TextBox ID="TextBoxPhone" runat="server" CssClass="form-control" onkeypress="return numbersonly(event)" MaxLength="12"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBoxPhone"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidatorPhone1" runat="server"
                            ControlToValidate="TextBoxPhone" CssClass="formValidation" SetFocusOnError="true" Display="Dynamic" ValidationExpression="[0-9]{9,15}" />
                    </div>
                    <div class="rowForm">
                        <label for="<%= DropDownListTopic.ClientID %>"><%=populateClassFromDB.GetSiteMessagesByKey("chooseTopic")%><i class="fa fa-star"></i></label>
                        <asp:DropDownList ID="DropDownListTopic" runat="server" CssClass="form-control">
                            <asp:ListItem ID="ListItem0" runat="server" Selected="True" Disabled="true"></asp:ListItem>
                            <asp:ListItem ID="ListItem1" runat="server"></asp:ListItem>
                            <asp:ListItem ID="ListItem2" runat="server"></asp:ListItem>
                            <asp:ListItem ID="ListItem3" runat="server"></asp:ListItem>
                            <asp:ListItem ID="ListItem4" runat="server"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" SetFocusOnError="true" runat="server" ControlToValidate="DropDownListTopic"></asp:RequiredFieldValidator>
                        <div id="orderData" runat="server" class="orderDataDiv" visible="false">
                        </div>
                    </div>
                    <div class="rowForm">
                        <label for="<%= TextBoxContent.ClientID %>"><%=populateClassFromDB.GetSiteMessagesByKey("Message") %><i class="fa fa-star"></i></label>
                        <asp:TextBox ID="TextBoxContent" runat="server" TextMode="MultiLine"
                            Height="200" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator CssClass="formValidation" ID="RequiredFieldValidatorAddress" runat="server"
                            ControlToValidate="TextBoxContent" Display="Dynamic" SetFocusOnError="True" />
                    </div>
                    <div class="rowForm">
                        <ajaxToolkit:AsyncFileUpload ID="AsyncFileUpload1" Width="400px" runat="server"
                            OnClientUploadError="uploadError"
                            OnClientUploadStarted="StartUpload"
                            OnClientUploadComplete="UploadComplete"
                            CompleteBackColor="Lime" UploaderStyle="Modern"
                            ErrorBackColor="Red"
                            ThrobberID="Throbber"
                            OnUploadedComplete="AsyncFileUpload1_UploadedComplete"
                            UploadingBackColor="#66CCFF" />

                        <asp:Label ID="Throbber" runat="server" Style="display: block">
                        </asp:Label>
                        <div id="displayImages" style="width: 200px"></div>

                        <asp:Label ID="lblStatus" runat="server" Style="font-family: Arial; font-size: small;"></asp:Label>

                    </div>
                    <div class="rowForm">
                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="true" />
                        <asp:Button ID="ButtonLogin" runat="server" CssClass="bigButton" OnClick="Send" />
                    </div>
                </div>
                <div class="col-sm-6" style="padding-left: 30px">
                </div>
            </div>
        </div>
    </div>
    <script>
        $("#<%=ButtonLogin.ClientID%>").click(function () {
            if ($("#<%=DropDownListTopic.ClientID%>")[0].selectedIndex == "0") {
                alert("<%=populateClassFromDB.GetSiteMessagesByKey("chooseTopic")%>");
                event.preventDefault();
            }
        });
    </script>
    </div>
</asp:Content>
