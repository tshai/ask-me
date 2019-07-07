<%@ Page Language="VB" MasterPageFile="~/masters/main.master" Inherits="caltureCustomer" %>

<script runat="server">

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        Dim head As HtmlHead = Page.Header
        Dim metaDescription As New HtmlMeta()
        metaDescription.Name = "description"
        metaDescription.Content = "שאלות כלליות עזרה ותשובות"
        head.Controls.Add(metaDescription)
        Page.Title = populateClassFromDB.GetSiteMessagesByKey("explOfTheServiceTitle")
    End Sub


</script>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        .content {
    min-height: 4000px;
}
        .formBody {
            float: initial !important;
            margin: auto;
            width: 100%;
        }

        .formRow {
            background-color: initial;
            border: initial;
            border-bottom: 1px solid #e8e8e8;
        }

        .mainDiv {
         display:flex;
        }

        h2 {
            margin-top: 100px;
            border-bottom: 4px solid #51be80;
        }

        .formRow h4, .formRow h4 p strong {
            color: #007131;
            font-size: 16px;
            font-weight: normal;
        }
           .ul14 {
            margin:15px;
        }
        .ul14 li{
            color:#333;
            font-size:14px;
        }
    </style>

    <div class="mainDiv">


        <div class="centerDiv">
            <div style="margin-right: 10px">
                <h2><%=populateClassFromDB.GetSiteMessagesByKey("explOfTheService")%></h2>
                <div class="formBody">
                    <div class="formRow">
                        <h4><%=populateClassFromDB.GetSiteMessagesByKey("whatIsTheService")%></h4>
                        <p><%=populateClassFromDB.GetSiteMessagesByKey("whatIsTheServiceDescription")%></p>
                    </div>
                    <div class="formRow">
                        <h4><%=populateClassFromDB.GetSiteMessagesByKey("downloadSoftware")%></h4>
                        <p>
                            <%=populateClassFromDB.GetSiteMessagesByKey("downloadSoftwareDescription")%>
                        </p>
                    </div>

                    <div class="formRow">
                        <h4><%=populateClassFromDB.GetSiteMessagesByKey("whoIsTheServiceFor")%></h4>
                        <p><%=populateClassFromDB.GetSiteMessagesByKey("whoIsTheServiceForDescription")%></p>
                    </div>


                    <div class="formRow">
                        <h4><%=populateClassFromDB.GetSiteMessagesByKey("serviceBenefits")%></h4>
                        <p><%=populateClassFromDB.GetSiteMessagesByKey("serviceBenefitsDescription")%></p>
                    </div>


                    <div class="formRow">
                        <h4><%=populateClassFromDB.GetSiteMessagesByKey("howItWorks")%></h4>
                        <p><%=populateClassFromDB.GetSiteMessagesByKey("howItWorksDescription")%> </p>
                    </div>


                    <div class="formRow">
                        <h4><%=populateClassFromDB.GetSiteMessagesByKey("canIUseMoreCompanies")%></h4>
                        <p><%=populateClassFromDB.GetSiteMessagesByKey("canIUseMoreCompaniesDescription")%> </p>
                    </div>

                    <div class="formRow">
                        <h4><%=populateClassFromDB.GetSiteMessagesByKey("howToUseRecordedInterviews")%></h4>
                        <p><%=populateClassFromDB.GetSiteMessagesByKey("howToUseRecordedInterviewsDescription")%> </p>
                    </div>

                    <div class="formRow">
                        <h4><%=populateClassFromDB.GetSiteMessagesByKey("receivedRecordedInterviewFAQ")%></h4>
                        <p><%=populateClassFromDB.GetSiteMessagesByKey("receivedRecordedInterviewFAQDescription")%> </p>
                    </div>

                    <div class="formRow">
                        <h4><%=populateClassFromDB.GetSiteMessagesByKey("recordLiveInterviewFAQ")%></h4>
                        <p><%=populateClassFromDB.GetSiteMessagesByKey("recordLiveInterviewFAQDescription")%> </p>
                    </div>

                    <div class="formRow">
                        <h4><%=populateClassFromDB.GetSiteMessagesByKey("forgotPasswordFAQ")%></h4>
                        <p><%=populateClassFromDB.GetSiteMessagesByKey("forgotPasswordFAQDescription")%> </p>
                    </div>

                    <div class="formRow">
                        <h4><%=populateClassFromDB.GetSiteMessagesByKey("sameEmailFAQ")%></h4>
                        <p><%=populateClassFromDB.GetSiteMessagesByKey("sameEmailFAQDescription")%> </p>
                    </div>

                    <div class="formRow">
                        <h4><%=populateClassFromDB.GetSiteMessagesByKey("differenceInInterviewsFAQ")%></h4>
                        <p><%=populateClassFromDB.GetSiteMessagesByKey("differenceInInterviewsFAQDescription")%> </p>
                    </div>

                    <div class="formRow">
                        <h4><%=populateClassFromDB.GetSiteMessagesByKey("testFAQ")%></h4>
                        <p><%=populateClassFromDB.GetSiteMessagesByKey("testFAQDescription")%> </p>
                    </div>




                </div>

            </div>
        </div>
    </div>
    <div class="mainDiv">
        <div class="centerDiv">
            <div style="margin-right: 10px">
                <h2><%=populateClassFromDB.GetSiteMessagesByKey("facCand")%></h2>
                <div class="formBody">
                    <div class="formRow">
                        <h4><%=populateClassFromDB.GetSiteMessagesByKey("whatIsTheLiveInterview")%></h4>
                        <p><%=populateClassFromDB.GetSiteMessagesByKey("whatIsTheLiveInterviewDescription")%></p>
                    </div>
                    <div class="formRow">
                        <h4><%=populateClassFromDB.GetSiteMessagesByKey("howToDoInterview")%></h4>
                        <p>
                            <%=populateClassFromDB.GetSiteMessagesByKey("howToDoInterviewDescription")%>
                        </p>
                    </div>

                    <div class="formRow">
                        <h4><%=populateClassFromDB.GetSiteMessagesByKey("whereInterviewGo")%></h4>
                        <p><%=populateClassFromDB.GetSiteMessagesByKey("whereInterviewGoDescription")%></p>
                    </div>


                    <div class="formRow">
                        <h4><%=populateClassFromDB.GetSiteMessagesByKey("accountNeed")%></h4>
                        <p><%=populateClassFromDB.GetSiteMessagesByKey("accountNeedDescription")%></p>
                    </div>


                    <div class="formRow">
                        <h4><%=populateClassFromDB.GetSiteMessagesByKey("recordAgain")%></h4>
                        <p><%=populateClassFromDB.GetSiteMessagesByKey("recordAgainDescription")%> </p>
                    </div>

                    <div class="formRow">
                        <h4><%=populateClassFromDB.GetSiteMessagesByKey("doIhaveToPay")%></h4>
                        <p><%=populateClassFromDB.GetSiteMessagesByKey("doIhaveToPayDescription")%> </p>
                    </div>

                    <div class="formRow">
                        <h4><%=populateClassFromDB.GetSiteMessagesByKey("videoTroubleshooting")%></h4>
                        <p><%=populateClassFromDB.GetSiteMessagesByKey("videoTroubleshootingDescription")%> </p>
                    </div>

                    <div class="formRow">
                        <h4><%=populateClassFromDB.GetSiteMessagesByKey("audioTroubleshooting")%></h4>
                        <p><%=populateClassFromDB.GetSiteMessagesByKey("audioTroubleshootingDescription")%> </p>
                    </div>

                    <div class="formRow">
                        <h4><%=populateClassFromDB.GetSiteMessagesByKey("whatNext")%></h4>
                        <p><%=populateClassFromDB.GetSiteMessagesByKey("whatNextDescription")%> </p>
                    </div>






                </div>
              
            </div>
        </div>
    </div>
    <script>




</script>
</asp:Content>
