<%@ Page Language="VB" MasterPageFile="~/masters/main.master" Inherits="caltureCustomer" %>

<script runat="server">

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        Dim head As HtmlHead = Page.Header
        Dim metaDescription As New HtmlMeta()
        metaDescription.Name = populateClassFromDB.GetSiteMessagesByKey("description")
        metaDescription.Content = "שאלות כלליות עזרה ותשובות"
        head.Controls.Add(metaDescription)
        Page.Title = populateClassFromDB.GetSiteMessagesByKey("PricingTableTitle")
        If Session("domainName") <> "en-US" Then
            'featureLink.HRef = "#"
            ' featureLink1.HRef = "#"
            'featureLink2.HRef = "#"
            'featureLink3.HRef = "#"
            'featureLink4.HRef = "#"
        End If

    End Sub

    Protected Function showPrice(priceShow As Integer)
        Using db = New Entities.Entities()
            Dim domainName As String = Session("domainName")
            Dim LanguageID = (From a In db.DomainsList Where a.DomainName = domainName Select a).FirstOrDefault().LanguageID
            Dim planTitle_ = (From a In db.SiteMessagesToLanguages Where a.SiteMessageID = priceShow And a.LanguageID = LanguageID Select a).FirstOrDefault()
            Return planTitle_.Message
        End Using
    End Function

    Protected Function showPlan(planTitle As Integer)
        Using db = New Entities.Entities()
            Dim domainName As String = Session("domainName")
            Dim LanguageID = (From a In db.DomainsList Where a.DomainName = domainName Select a).FirstOrDefault().LanguageID
            Dim planTitle_ = (From a In db.SiteMessagesToLanguages Where a.SiteMessageID = planTitle And a.LanguageID = LanguageID Select a).FirstOrDefault()
            Return planTitle_.Message
        End Using
    End Function

    Protected Function showQuantity(planID As Integer, planPropertyID As Integer)
        Using db = New Entities.Entities()
            Dim plan_ = (From a In db.Planes Where a.ID = planID Select a).FirstOrDefault()
            Dim planTOProperties_ = (From a In db.PlanToPlanproperties Where a.palnID = planID And a.planPropertiesID = planPropertyID Select a).FirstOrDefault()
            If planTOProperties_.quantity = 0 Then
                Return populateClassFromDB.GetSiteMessagesByKey("unlimited")
            End If
            If planPropertyID = 6 Then
                If planTOProperties_.quantity < 1024 Then
                    Return planTOProperties_.quantity & " MB"
                Else
                    Return planTOProperties_.quantity / 1024 & " GB"
                End If
            Else
                Return planTOProperties_.quantity
            End If
        End Using
    End Function
</script>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
	<style>
		.formBody {
			float: initial !important;
			margin: auto;
		}
		/*.content {
    min-height:1500px;
}*/
	</style>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">

	<div class="centerDiv">
		<div style="margin-right: 10px">

			<h2 style="text-align: center"><%=populateClassFromDB.GetSiteMessagesByKey("PricingTable")%></h2>
			<p style="text-align: center; color: black"><%=populateClassFromDB.GetSiteMessagesByKey("WeWorkWith")%></p>

			<asp:ListView ID="ListViewWorkRecord" runat="server" DataSourceID="SqlDataSource1">
				<LayoutTemplate>
					<div>
						<div id="itemPlaceholder" runat="server">
						</div>
					</div>
				</LayoutTemplate>
				<ItemTemplate>
					<div class="columns">
						<ul class="price">
							<li class="header"><%#showPlan(Eval("planTitle"))%></li>
							<li class="grey"><%#showPrice(Eval("priceShow"))%></li>
							<li><%#showQuantity(Eval("ID"), 1) %> <%=populateClassFromDB.GetSiteMessagesByKey("BasicIncludeFree") %></li>
							<li><%#showQuantity(Eval("ID"), 4) %> <%=populateClassFromDB.GetSiteMessagesByKey("freeUsers") %></li>
							<li><%#showQuantity(Eval("ID"), 6) %> <%=populateClassFromDB.GetSiteMessagesByKey("freeStorage") %></li>
							<li><%#showQuantity(Eval("ID"), 7) %> <%=populateClassFromDB.GetSiteMessagesByKey("freePositions") %></li>
							<li><%=populateClassFromDB.GetSiteMessagesByKey("candidateListPackages") %></li>
							<li><%=populateClassFromDB.GetSiteMessagesByKey("AddBrand")%></li>
							<%--<li class="grey"><a href="../companies/companySignUp.aspx" class="button"><%=populateClassFromDB.GetSiteMessagesByKey("choose")%></a></li>--%>
						</ul>
					</div>
				</ItemTemplate>
			</asp:ListView>
			<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:AskMe %>"
				SelectCommand="select * from Planes"></asp:SqlDataSource>

			<%--<div class="columns">
				<ul class="price">

					<li class="header"><%=populateClassFromDB.GetSiteMessagesByKey("Free")%></li>
					<li class="grey"><%=populateClassFromDB.GetSiteMessagesByKey("FreePrice")%></li>
					<li><%=populateClassFromDB.GetSiteMessagesByKey("BasicIncludeFree")%></li>
					<li><%=populateClassFromDB.GetSiteMessagesByKey("freeUsers")%></li>
					<li><%=populateClassFromDB.GetSiteMessagesByKey("freeStorage")%></li>
					<li><%=populateClassFromDB.GetSiteMessagesByKey("freePositions")%></li>
					<li><%=populateClassFromDB.GetSiteMessagesByKey("candidateListPackages")%></li>
					<li><%=populateClassFromDB.GetSiteMessagesByKey("AddBrand")%></li>
					<li class="grey"><a href="../companies/companySignUp.aspx" class="button"><%=populateClassFromDB.GetSiteMessagesByKey("choose")%></a></li>
				</ul>
			</div>
			<div class="columns">
				<ul class="price">
					<li class="header"><%=populateClassFromDB.GetSiteMessagesByKey("Basic")%></li>
					<li class="grey"><%=populateClassFromDB.GetSiteMessagesByKey("BasicPrice")%></li>
					<li><%=populateClassFromDB.GetSiteMessagesByKey("BasicInclude")%></li>
					<li><%=populateClassFromDB.GetSiteMessagesByKey("basicUsers")%></li>
					<li><%=populateClassFromDB.GetSiteMessagesByKey("basicStorage")%></li>
					<li><%=populateClassFromDB.GetSiteMessagesByKey("Positions")%></li>
					<li><%=populateClassFromDB.GetSiteMessagesByKey("candidateListPackages")%></li>
					<li><%=populateClassFromDB.GetSiteMessagesByKey("AddBrand")%></li>
					<li class="grey"><a href="../companies/companySignUp.aspx" class="button"><%=populateClassFromDB.GetSiteMessagesByKey("choose")%></a></li>
				</ul>
			</div>

			<div class="columns">
				<ul class="price">
					<li class="header"><%=populateClassFromDB.GetSiteMessagesByKey("Pro")%></li>
					<li class="grey"><%=populateClassFromDB.GetSiteMessagesByKey("ProPrice")%></li>
					<li><%=populateClassFromDB.GetSiteMessagesByKey("ProInclude")%></li>
					<li><%=populateClassFromDB.GetSiteMessagesByKey("proUsers")%></li>
					<li><%=populateClassFromDB.GetSiteMessagesByKey("proStorage")%></li>
					<li><%=populateClassFromDB.GetSiteMessagesByKey("Positions")%></li>
					<li><%=populateClassFromDB.GetSiteMessagesByKey("candidateListPackages")%></li>
					<li><%=populateClassFromDB.GetSiteMessagesByKey("AddBrand")%></li>
					<li class="grey"><a href="../companies/companySignUp.aspx" class="button"><%=populateClassFromDB.GetSiteMessagesByKey("choose")%></a></li>
				</ul>
			</div>

			<div class="columns">
				<ul class="price">
					<li class="header"><%=populateClassFromDB.GetSiteMessagesByKey("Premium")%></li>
					<li class="grey"><%=populateClassFromDB.GetSiteMessagesByKey("PremiumPrice")%></li>
					<li><%=populateClassFromDB.GetSiteMessagesByKey("PremiumInclude")%></li>
					<li><%=populateClassFromDB.GetSiteMessagesByKey("premiumUsers")%></li>
					<li><%=populateClassFromDB.GetSiteMessagesByKey("premiumStorage")%></li>
					<li><%=populateClassFromDB.GetSiteMessagesByKey("Positions")%></li>
					<li><%=populateClassFromDB.GetSiteMessagesByKey("candidateListPackages")%></li>
					<li><%=populateClassFromDB.GetSiteMessagesByKey("AddBrand")%></li>
					<li class="grey"><a href="../companies/companySignUp.aspx" class="button"><%=populateClassFromDB.GetSiteMessagesByKey("choose")%></a></li>
				</ul>
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
	<style>
		* {
			box-sizing: border-box;
		}

		.columns {
			float: left;
			width: 25%;
			padding: 8px;
		}

		.price {
			list-style-type: none;
			border: 1px solid #eee;
			margin: 0;
			padding: 0;
			-webkit-transition: 0.3s;
			transition: 0.3s;
			width: 100%;
		}

			.price:hover {
				box-shadow: 0 8px 12px 0 rgba(0,0,0,0.2)
			}

			.price .header {
				background-color: #0a5f6d;
				color: white;
				font-size: 25px;
			}

			.price li {
				border-bottom: 1px solid #eee;
				padding: 20px;
				background-color: #888;
				text-align: center;
			}

			.price .grey {
				background-color: #5b5b5b;
				font-size: 20px;
			}

		.button {
			background-color: #4CAF50;
			border: none;
			color: white;
			padding: 10px 25px;
			text-align: center;
			text-decoration: none;
			font-size: 18px;
		}

		@media only screen and (max-width: 600px) {
			.columns {
				width: 100%;
			}
		}
	</style>
</asp:Content>
