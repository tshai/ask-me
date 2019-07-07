<%@ Page Language="VB" MasterPageFile="~/masters/main.master" Inherits="caltureCustomer" %>

<script runat="server">
    'Dim company_ As New Companies()
    Protected Sub Page_Load(sender As Object, e As EventArgs)
        'If String.IsNullOrEmpty(Request("EmployeeToCompanyGuid")) = False Then
        '    Dim EmployeeToCompanyGuid As Guid = Guid.Parse(Request("EmployeeToCompanyGuid"))
        '    Using db = New Entities.Entities()
        '        Dim EmployeeToCompany_ = (From a In db.EmployeeToCompany Where a.EmployeeToCompanyGuid = EmployeeToCompanyGuid Select a).FirstOrDefault()
        '        Dim employee_ As New Employees()
        '        Dim q = From a In db.Employees Where a.phone = EmployeeToCompany_.Employeephone Select a
        '        If q.Count() = 0 Then
        '            phone.Text = EmployeeToCompany_.Employeephone

        '        End If
        '        company_ = populateClassFromDB.getCompanyByID(EmployeeToCompany_.CompanyID)
        '    End Using
        '    phone.ReadOnly = True
        '    requestEmployee.Visible = True
        '    newEmployee.Visible = False
        'End If

        Page.Title = populateClassFromDB.GetSiteMessagesByKey("companyRegisterTitle")
        email.Attributes.Add("placeholder", populateClassFromDB.GetSiteMessagesByKey("EmailOnly"))
        RequiredFieldValidator3.Attributes.Add("Text", populateClassFromDB.GetSiteMessagesByKey("errorEmail"))
        RequiredFieldValidator3.ErrorMessage = populateClassFromDB.GetSiteMessagesByKey("errorEmail")
        RegularExpressionValidator1.Attributes.Add("Text", populateClassFromDB.GetSiteMessagesByKey("errorEmail"))
        RegularExpressionValidator1.ErrorMessage = populateClassFromDB.GetSiteMessagesByKey("errorEmail")
        'password.Attributes.Add("placeholder", populateClassFromDB.GetSiteMessagesByKey("Password"))
        'RequiredFieldValidator2.Attributes.Add("Text", populateClassFromDB.GetSiteMessagesByKey("Password"))
        'RequiredFieldValidator2.ErrorMessage = populateClassFromDB.GetSiteMessagesByKey("checkForPassword")
        'RegularExpressionValidator2.ErrorMessage = populateClassFromDB.GetSiteMessagesByKey("passwordPlaceholder")
        'FullName.Attributes.Add("placeholder", populateClassFromDB.GetSiteMessagesByKey("FullName"))
        'RequiredFieldValidator1.Attributes.Add("Text", populateClassFromDB.GetSiteMessagesByKey("writeFullName"))
        RequiredFieldValidator4.ErrorMessage = populateClassFromDB.GetSiteMessagesByKey("writeFullName")
        Button1.Text = populateClassFromDB.GetSiteMessagesByKey("Registration")
    End Sub



    Protected Sub Button1_Click(sender As Object, e As EventArgs)
        If Page.IsValid = False Then
            Response.Write("errors in details")
            Response.End()
        End If


        Using db = New Entities.Entities()
            TrialRequest TrialRequest_ = New TrialRequest();
            'Dim q = (From a In db.Users Where a.Phone = phone.Text.Trim() Select a).FirstOrDefault()
            'If q Is Nothing Then



            '    'Mailing.companyEmailActivation(email.Text.Trim.ToLower, "live-interview.com", Employees_.employeeGuid)
            '    Dim message = populateClassFromDB.GetSiteMessages(2)
            '    admin.popUp(Page, message)
            'Else
            '    Dim message = populateClassFromDB.GetSiteMessages(1)
            '    admin.popUp(Page, message)
            'End If
        End Using

    End Sub

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script>
        $(document).ready(function () {
            $("#ContentPlaceHolder1_email").keyup(function () {
                $(this).val($(this).val().replace(/\s/g, ""));
            });
            $("#ContentPlaceHolder1_password").keyup(function () {
                $(this).val($(this).val().replace(/\s/g, ""));
            });
        });





    </script>
    <style>
        #explainAboutDemo {
    width: 335px;
    float: left;
    border: 1px solid #dcdcdc;

    color: #333;
    padding:20px;
    box-sizing: border-box;
    font-size: 20px;
    background-color: #f1f1f1;
    flex: 1;
    margin-right:10px;
        }
        #explainAboutDemo ul{
                            list-style-position: outside;
    margin-left: 20px;
    font-size: 16px;
    margin-top: 10px;
    line-height: 135%;
        }

        .form3 {
            float: right;
            width: 360px;
            border: 1px solid #222;
            flex: 1;
        }

        .topFrom2 {
            display: flex;
            width: 700px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="topCompanySignIn">
        <div class="workplace">
            <div class="alert alert-success" id="AddMessage" runat="server" visible="false">
                <h4><%=populateClassFromDB.GetSiteMessagesByKey("SystemMessage") %></h4>
                <%=populateClassFromDB.GetSiteMessagesByKey("wrongDetails") %>
            </div>
            <div class="row-fluid topFrom2">
                <div id="explainAboutDemo">
                    <div class="box">
                        <h3 style="color:#0a5f6d;font-size:28px;">See Ask-me In Action</h3>
                        <p>
                            Interview and assess with the HireVue Hiring Intelligence platform.&nbsp;<br>
                            It has never been easier to get the best talent, faster.&nbsp;
                        </p>
                        <p>How 1.5 Million Candidates Rate HireVue:</p>
                        <ul>
                            <li>70% rated the experience as 9-10 out of 10</li>
                            <li>80% enjoyed the experience and appreciated the opportunity to differentiate themselves</li>
                            <li>85% thought it reflected well on the employer’s brand</li>
                            <li>89% said it respected their time</li>
                        </ul>
                        <h4>Join 700+ Customers That Use HireVue</h4>

                    </div>
                    </div> 
                <div class="span6 form3">
                    <div class="head">
                        <div class="isw-ok">
                        </div>
                        <h2 runat="server" id="newEmployee">Get free trial</h2>
                        <div runat="server" id="requestEmployee" visible="false">
                            <h2><%=populateClassFromDB.GetSiteMessagesByKey("invitationFromACompany")%>D</h2>
                            <h2><%=populateClassFromDB.GetSiteMessagesByKey("serveAsAnInterviewer")%></h2>
                        </div>
                        <div class="clear">
                        </div>
                    </div>
                    <div class="block-fluid">
                        <div class="row-form" style="display: none">
                            <div id="companySignupLoginDiv">
                                <ul id="companySignupLogin">
                                    <li class="active leftSide"><%=populateClassFromDB.GetSiteMessagesByKey("companyRegister")%></li>
                                    <li class="rightSide"><a href="companyLogin.aspx"><%=populateClassFromDB.GetSiteMessagesByKey("companyLogin")%></a></li>
                                </ul>

                            </div>
                            <div class="clear">
                            </div>
                        </div>
                        <div class="row-form">
                            <div class="span9">
                                <asp:TextBox ID="name" placeholder="Name" runat="server" autocomplete="off" onkeyup="myFunction(this)"></asp:TextBox><span>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="name"
                                        Display="Dynamic" CssClass="errValidator" SetFocusOnError="true" />

                                </span>
                            </div>
                        </div>
                        <div class="row-form">
                            <div class="span9">
                                <asp:TextBox ID="email" runat="server" placeholder="Email" autocomplete="off" onkeyup="myFunction(this)"></asp:TextBox><span>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="email"
                                        Display="Dynamic" CssClass="errValidator" SetFocusOnError="true" />
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="email"
                                        Display="Dynamic" CssClass="errValidator" SetFocusOnError="true" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                                </span>
                            </div>
                        </div>
                        <div class="row-form">
                            <div class="span9">
                                <asp:TextBox type="tel" placeholder="Phone" ID="Phone" runat="server"></asp:TextBox><span>
                                </span>
                            </div>
                            <div class="clear">
                            </div>
                        </div>


                        <div class="row-form">
                            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="true" ShowValidationErrors="true" />
                            <asp:Button class="bigButton" ID="Button1" runat="server" OnClick="Button1_Click" />
                            <%--                            <a href="ForgotPassword.aspx"><%=populateClassFromDB.GetSiteMessagesByKey("Delete")forgotPassword%></a>--%>
                        </div>
                        <div style="text-align:center;color:#333;font-size:16px">By submitting your information, you agree to Ask me Terms of Use and representatives may contact you. We value your privacy.</div>

                    </div>
                </div>
            </div>
            <div>
            </div>

        </div>

    </div>
</asp:Content>

