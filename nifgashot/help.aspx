<%@ Page Language="C#" MasterPageFile="/masters/mainMaster.master" Inherits="MainCulture" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        HtmlHead head = Page.Header;
        HtmlMeta metaDescription = new HtmlMeta();
        metaDescription.Name = "description";
        metaDescription.Content = populateClassFromDB.GetSiteMessagesByKey("FAQ");
        head.Controls.Add(metaDescription);
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
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="flotTo" style="margin-right: 10px">
        <h2>
            <%= populateClassFromDB.GetSiteMessagesByKey("FAQ")%></h2>
        <div class="formBody">
            <div class="formRow">
                <h4>
                    <%= populateClassFromDB.GetSiteMessagesByKey("isLiveShow")%></h4>
                <p>
                    <%= populateClassFromDB.GetSiteMessagesByKey("ShowLiveAndNotRecorded")%>
                </p>
            </div>
            <div class="formRow">
                <h4>
                    <%= populateClassFromDB.GetSiteMessagesByKey("AloneOrWithOthers")%></h4>
                <p>
                    <%= populateClassFromDB.GetSiteMessagesByKey("OneOnOneChat")%>
                </p>
            </div>
            <%--  <div class="formRow">
                <h4>
                    <%=Resources.Resources.WhatAboutRestOfCredits %></h4>
                <p>
                    <%=Resources.Resources.CreditDontWaste %></p>
            </div>--%>
            <div class="formRow">
                <h4>
                    <%=populateClassFromDB.GetSiteMessagesByKey("AreGirlsIsraeli") %></h4>
                <p>
                    <%=populateClassFromDB.GetSiteMessagesByKey("MostGirlsIsraeli") %>
                </p>
            </div>
            <div class="formRow">
                <h4>
                    <%=populateClassFromDB.GetSiteMessagesByKey("HowToChat") %></h4>
                <p>
                    <%=populateClassFromDB.GetSiteMessagesByKey("YouCanSeeAndHear") %>
                </p>
            </div>
            <div class="formRow">
                <h4>
                    <%= populateClassFromDB.GetSiteMessagesByKey("CanSheSeeMe")%></h4>
                <p>
                    <%= populateClassFromDB.GetSiteMessagesByKey("YouCanActivateYourCam")%>
                </p>
            </div>
            <div class="formRow">
                <h4>
                    <%= populateClassFromDB.GetSiteMessagesByKey("WhatHoursGirlsWork")%></h4>
                <p>
                    <%= populateClassFromDB.GetSiteMessagesByKey("SiteWork247")%>
                </p>
            </div>
            <%--  <div class="formRow">
                <h4>
                    <%= Resources.Resources.BroadcastQuality%></h4>
                <p>
                    <%= Resources.Resources.BroadcastQualityAccordingToCam%></p>
            </div>--%>
            <div class="formRow">
                <h4>
                    <%=populateClassFromDB.GetSiteMessagesByKey("doGirlsMeet") %></h4>
                <p>
                    <%= populateClassFromDB.GetSiteMessagesByKey("forbidenToMeet") %>
                </p>
            </div>

            <div class="formRow">
                <h4>
                    <%= populateClassFromDB.GetSiteMessagesByKey("GirlDoAnything")%></h4>
                <p>
                    <%= populateClassFromDB.GetSiteMessagesByKey("GirlDoAnythingButIrregular")%>
                </p>
            </div>
            <div class="formRow">
                <h4>
                    <%= populateClassFromDB.GetSiteMessagesByKey("WhereAreTheGirbroadcast")%></h4>
                <p>
                    <%= populateClassFromDB.GetSiteMessagesByKey("EveryGirlAtHerHome")%>
                </p>
            </div>
            <%--<div class="formRow">
                <h4>
                    <%= Resources.Resources.EveryTimeCamOnError%></h4>
                <p>
                    <%= Resources.Resources.WeDontGuarantee%></p>
            </div>--%>
            <div class="formRow">
                <h4>
                    <%= populateClassFromDB.GetSiteMessagesByKey("CanWebSiteWorkOnCellphone")%></h4>
                <p><%=populateClassFromDB.GetSiteMessagesByKey("siteWorkOnMobile") %></p>
            </div>
            <%-- <div class="formRow">
                <h4>
                    <%=Resources.Resources.WhatISBuyByPhone %></h4>
                <p>
                    <%=Resources.Resources.WeGiveTheOpportunity %></p>
            </div>--%>
            <%--<div class="formRow">
                <h4>
                    <%=Resources.Resources.IfIPurchasedMinutes %></h4>
                <p>
                    <%= Resources.Resources.UnlikeACreditCard%></p>
            </div>--%>
            <div class="formRow">
                <h4>
                    <%=populateClassFromDB.GetSiteMessagesByKey("ThereAreReviews")%></h4>
                <p>
                    <%= populateClassFromDB.GetSiteMessagesByKey("TheseReviewsArePosted")%>
                </p>
            </div>
            <div class="formRow">
                <h4>
                    <%= populateClassFromDB.GetSiteMessagesByKey("CanIHearPerformers")%></h4>
                <p>
                    <%= populateClassFromDB.GetSiteMessagesByKey("YouCanCorrespond")%>
                </p>
            </div>
            <%-- <div class="formRow">
                <h4>
                    <%=Resources.Resources.DoesPerformerCanSee%></h4>
                <p>
                    <%= Resources.Resources.WhenYouRegistering%></p>
            </div>--%>
            <%--            <div class="formRow">
                <h4>
                    <%=Resources.Resources.ArePerformersProfessional%></h4>
                <p>
                    <%= Resources.Resources.PerformersRegularPeople%>"</p>
            </div>--%>
            <div class="formRow">
                <h4>
                    <%= populateClassFromDB.GetSiteMessagesByKey("WhatAgePerformers")%></h4>
                <p>
                    <%= populateClassFromDB.GetSiteMessagesByKey("EveryPerformerDifferentAge")%>
                </p>
            </div>
            <%-- <div class="formRow">
                <h4>
                    <%= Resources.Resources.IfICameInAndSuddenly%></h4>
                <p>
                    <%= Resources.Resources.ThisSiteRelativelyNew%></p>
            </div>--%>
            <%--  <div class="formRow">
                <h4>
                    <%= Resources.Resources.IsItSecureUse%></h4>
                <p>
                    <%= Resources.Resources.OurServiceVerySafe%>
                    <br />
                </p>
            </div>--%>
            <%--<div class="formRow">
                <h4>
                    <%= Resources.Resources.IsPersonalInformationConfid%></h4>
                <p>
                    <%= Resources.Resources.YourPersonalDetails%></p>
            </div>--%>
            <%-- <div class="formRow">
                <h4>
                    <%= Resources.Resources.IsSomeoneElseSeeMe%></h4>
                <p>
                    <%= Resources.Resources.NoOneCanSeeYou%>
                </p>
            </div>--%>
            <%-- <div class="formRow">
                <h4>
                    <%= Resources.Resources.DoPerformersShowsFace%></h4>
                <p>
                    <%= Resources.Resources.PerformersShowsFace%>
                </p>
            </div>--%>
            <%-- <div class="formRow">
                <h4>
                    <%= Resources.Resources.ArePerformersThin%></h4>
                <p>
                    <%= Resources.Resources.ThereSlimAndShapely%></p>
            </div>--%>
            <div class="formRow">
                <h4>
                    <%= populateClassFromDB.GetSiteMessagesByKey("CanPerformerToStop")%></h4>
                <p>
                    <%= populateClassFromDB.GetSiteMessagesByKey("IfYouWillCurse")%>
                </p>
            </div>
            <div class="formRow">
                <h4>
                    <%= populateClassFromDB.GetSiteMessagesByKey("WhatHappensIfNotTreatsMe")%></h4>
                <p>
                    <%= populateClassFromDB.GetSiteMessagesByKey("ThePerformersSupposed")%>
                </p>
            </div>
            <%-- <div class="formRow">
                <h4>
                    <%= Resources.Resources.WhatAreScores%></h4>
                <p>
                    <%= Resources.Resources.GradesAreDesigned%></p>
            </div>--%>
            <%-- <div class="formRow">
                <h4>
                    <%= Resources.Resources.IfNotHappy%></h4>
                <p>
                    <%= Resources.Resources.IfYouPurchased%></p>
            </div>--%>
            <%--<div class="formRow">
            <h4>
                <%= Resources.Resources.HowLongCompany%></h4>
            <p>
                <%= Resources.Resources.OurCompanyExists%></p>
        </div>--%>
        </div>
        <div class="sideFormBody">
            <%--  <div class="sideFormRow">
                   <h3>בדיקות מומלצות להפעלת הצ'ט</h3><br />
        <p>מומלץ לבצע את הבדיקות הבאות לפני הפעלת הצ'ט</p><br />
        <a href="mini/index-aspx.html" class="itemBtn" target="_blank">תקינות רשת</a>
        </div>--%>
        </div>
    </div>
</asp:Content>
