<%@ Page Language="VB" MasterPageFile="~/masters/main.master" Inherits="caltureCustomer" %>

<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="VB" %>
<script runat="server">


    Dim listCurrentUrl As List(Of KeyValuePair(Of String, String)) =
         New List(Of KeyValuePair(Of String, String)) 'this for sample "action=delete" this 1 value

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs)

        If Page.IsValid = False Then
            Response.Write("errors in details")
            Response.End()
        End If


        Dim passwordHashed As String = Tools.GetHash(password.Text.Trim.ToString())
        Using db = New Entities.Entities()
            Dim q = (From a In db.Users Where a.Phone.ToLower() = Phone.Text.Trim.ToLower() And a.Password.ToLower() = password.Text.Trim.ToString() Select a).FirstOrDefault()
            If IsNothing(q) = True Then
                listCurrentUrl.Add(New KeyValuePair(Of String, String)("message", "22"))
                'Response.Redirect(removeVaraiableFromURL2.Class1.removeDuplicateVaraiableFromUrl(Request.RawUrl, listCurrentUrl, Request.Url.DnsSafeHost))
                Response.Redirect("companyLogin.aspx?message=22")
                'Dim message = populateClassFromDB.GetSiteMessages(22)
                'admin.popUp(Page, message)
            Else
                If q.SmsActivation = 0 Then
                    'Mailing.companyPhoneActivation(q.Phone, "live-interview.com", q.employeeGuid)
                    listCurrentUrl.Add(New KeyValuePair(Of String, String)("message", "4"))
                    Response.Redirect(removeVaraiableFromURL2.Class1.removeDuplicateVaraiableFromUrl(Request.RawUrl, listCurrentUrl, Request.Url.DnsSafeHost))
                    'Dim message = populateClassFromDB.GetSiteMessages(4)
                    'admin.popUp(Page, message)
                    'ElseIf q.Active = 0 Then
                    '    listCurrentUrl.Add(New KeyValuePair(Of String, String)("message", "5"))
                    '    Response.Redirect(removeVaraiableFromURL2.Class1.removeDuplicateVaraiableFromUrl(Request.RawUrl, listCurrentUrl, Request.Url.DnsSafeHost))
                    '    'Dim message = populateClassFromDB.GetSiteMessages(5)
                    '    'admin.popUp(Page, message)
                Else
                    Session("UserID") = q.ID
                    'Session.Remove("CompanyID")
                    'Dim employeeLogin_ As New EmployeeLogins()
                    'employeeLogin_.DateIn = DateTime.Now
                    'employeeLogin_.EmployeeID = q.ID
                    'employeeLogin_.customerID = 0
                    'employeeLogin_.IpAddress = Tools.extractUserIp()
                    'db.EmployeeLogins.Add(employeeLogin_)
                    'db.SaveChanges()
                    'Session("emaployeeManageLevel") = q.manageLevel
                    'Session("CompanyID") = q.CompanyID
                    'If String.IsNullOrEmpty(Request("sGuid")) = False Then
                    '    Response.Redirect("readCorrespondenceHistory.aspx?sGuid=" & Request("sGuid"))
                    'End If
                    Response.Redirect("default.aspx")
                End If

            End If

        End Using



    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        'If Not IsPostBack Then
        'If String.IsNullOrEmpty(Request("employeeGuid")) = False Then
        '    Using db = New Entities()


        '    End Using
        'End If



        Page.Title = populateClassFromDB.GetSiteMessagesByKey("companyLoginTitle")
        'Button1.Text = populateClassFromDB.GetSiteMessagesByKey("Delete")login
        'Phone.Attributes.Add("placeholder", populateClassFromDB.GetSiteMessagesByKey("Phone"))
        password.Attributes.Add("placeholder", populateClassFromDB.GetSiteMessagesByKey("Password"))
        RequiredFieldValidator2.ErrorMessage = populateClassFromDB.GetSiteMessagesByKey("checkForPassword")
        'RequiredFieldValidator1.ErrorMessage = populateClassFromDB.GetSiteMessagesByKey("invalidPhone")
        password.Attributes.Add("Text", populateClassFromDB.GetSiteMessagesByKey("checkForPassword"))
        'RegularExpressionValidator1.ErrorMessage = populateClassFromDB.GetSiteMessagesByKey("invalidPhone")

        Button1.Text = populateClassFromDB.GetSiteMessagesByKey("Enter")
    End Sub
</script>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .span9 span {
            color: #bd0707;
        }
        input{
            color:#333 !important;
        }
    </style>
      <link rel="stylesheet" href="build/css/intlTelInput.css">
  <link rel="stylesheet" href="build/css/demo.css">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="topCompanySignIn">
        <div class="workplace">
            <div class="alert alert-success" id="AddMessage" runat="server" visible="false">
                <h4><%=populateClassFromDB.GetSiteMessagesByKey("SystemMessage") %></h4>
                <%=populateClassFromDB.GetSiteMessagesByKey("wrongDetails") %>
            </div>
            <div class="row-fluid">
                <div class="span6">
                    <div class="head">
                        <div class="isw-ok">
                        </div>
                        <h1><%=populateClassFromDB.GetSiteMessagesByKey("companyLogin")%></h1>
                        <div class="clear">
                        </div>
                    </div>
                    <div class="block-fluid">
                        <div class="row-form" style="display:none">
                            <div id="companySignupLoginDiv">
                                <ul id="companySignupLogin">
                                    <li class="leftSide"><a href="companySignUp.aspx"><%=populateClassFromDB.GetSiteMessagesByKey("companyRegister")%></a></li>
                                    <li class="active rightSide"><%=populateClassFromDB.GetSiteMessagesByKey("companyLogin")%></li>

                                </ul>

                            </div>
                            <div class="clear">
                            </div>
                        </div>
                        <div class="row-form">
                            <%--                        <div class="span3">
                            :</div>--%>
                            <div class="span9">
                                <asp:TextBox type="tel" ID="Phone" runat="server" ></asp:TextBox><span>
<%--                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="Phone"
                                        Display="Dynamic" SetFocusOnError="true" />
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="Phone"
                                        Display="Dynamic" SetFocusOnError="true" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />--%>
                                </span>
                            </div>
                            <div class="clear">
                            </div>
                        </div>
                        <div class="row-form">
                            <%--                        <div class="span3">
                            <%=populateClassFromDB.GetSiteMessagesByKey("Password")%>:</div>--%>
                            <div class="span9">
                                <asp:TextBox ID="password" runat="server" MaxLength="10" TextMode="Password" onkeyup="myFunction(this)"></asp:TextBox>
                                <span>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="password"
                                        Display="Dynamic" SetFocusOnError="true" /></span>
                            </div>
                            <div class="clear">
                            </div>
                        </div>

                        <div class="row-form">
                            <asp:Button class="bigButton" ID="Button1" runat="server" OnClick="Button1_Click" />
                        </div>
                        <div class="row-form">

                            <a href="ForgotPassword.aspx" style="color: #999"><%=populateClassFromDB.GetSiteMessagesByKey("forgotPassword")%></a>
                        </div>
                    </div>
                </div>
            </div>
            <div>
            </div>

        </div>

    </div>
    <div runat="server" id="googleVerfication" visible="false">

         <script>
        window.location.href = 'default.aspx';
    </script>
    </div>
        <script src="build/js/intlTelInput.js"></script>
    <script>
    var input = document.querySelector("#ContentPlaceHolder1_Phone");
    window.intlTelInput(input, {
      // allowDropdown: false,
      // autoHideDialCode: false,
      // autoPlaceholder: "off",
      // dropdownContainer: document.body,
      // excludeCountries: ["us"],
      // formatOnDisplay: false,
      // geoIpLookup: function(callback) {
      //   $.get("http://ipinfo.io", function() {}, "jsonp").always(function(resp) {
      //     var countryCode = (resp && resp.country) ? resp.country : "";
      //     callback(countryCode);
      //   });
      // },
      // hiddenInput: "full_number",
      // initialCountry: "auto",
      // localizedCountries: { 'de': 'Deutschland' },
      // nationalMode: false,
      // onlyCountries: ['us', 'gb', 'ch', 'ca', 'do'],
      // placeholderNumberType: "MOBILE",
      // preferredCountries: ['cn', 'jp'],
      // separateDialCode: true,
      utilsScript: "build/js/utils.js",
    });
  </script>
</asp:Content>
