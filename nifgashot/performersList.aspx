<%@ Page Language="C#" MasterPageFile="/masters/insideMain.master" EnableViewState="false" Inherits="MainCulture"
    Title="נפגשות הכר אותה בוידאו צ'ט לפני הפגישה" %>

<script runat="server">
    public string site_message, site_message2, new_page;

    protected void Page_Load(object sender, System.EventArgs e)
    {
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.Expires = 0;
        Response.ExpiresAbsolute = DateTime.Now;
        Response.AddHeader("pragma", "no-cache");
        Response.AppendHeader("Cache-Control", "no-store");
        Response.CacheControl = ("no-cache");
    }

    //public static string GirlGettingUsersHD(int Online, int intext, string name, int SupplierID)
    //{
    //    if (Online == 0)
    //        return "";
    //    if (Online == 1)
    //        return "<div class='button1'>הבחורה בשיחה</div>";
    //    return "<div class='button1'><a onclick=\"FreezeScreen('" + System.Resources.Resources.PleaseWait + "...');\"      href='/users/chat/build_waiting_list.aspx?SupplierID=" + SupplierID + "&ver=1' style='color:white' >חייג</a></div>";
    //    if (intext == 0)
    //        return "<div class='button1'><a onclick=\"FreezeScreen('" + System.Resources.Resources.PleaseWait + "...');\" href='/users/chat/build_waiting_list.aspx?SupplierID=" + SupplierID + "&ver=1' style='color:white'>חייג</a></div>";
    //    else if (intext == 1)
    //        return "n";
    //}

    //public static string hd(int intext)
    //{
    //    if (intext == 1)
    //        hd = "<img src='/App_Themes/users/images/HDIcon.png' class='ttRC'  title='" + System.Resources.Resources.GotHDCamera + "' alt='" + System.Resources.Resources.GotHDCamera + "' />";
    //    else
    //        hd = "";
    //}

</script>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script language="javascript" type="text/javascript">
        function OpenmenuWindow3(photo) {
            WindowConfig = 'toolbar=no, location=no, directories=no, menubar=no, scrollbars=yes,'
            WindowConfig += ',screenX=150,screenY=100,width=429,height=333'
            window.open('../../new_waiting_list/' + photo, 'photoWindow', WindowConfig)
        }
        function OpenmenuWindow4(photo) {
            WindowConfig = 'toolbar=no, location=no, directories=no, menubar=no, scrollbars=yes,'
            WindowConfig += ',screenX=150,screenY=100,width=590,height=500'
            window.open('../../new_waiting_list/' + photo, 'photoWindow', WindowConfig)
        }

        console.log("performersList.aspx: " + Date());
    </script>
    <style>
        .l7 {
            width: 100%;
            height: 32px;
            line-height: 32px;
            text-decoration: none;
            color: #333;
        }

        .dr3Gray {
            width: 100% !important;
            border-radius: 0 !important;
            margin-bottom: 5px;
            padding: 0 !important;
            border: 0 !important;
            height: 32px;
            line-height: 32px;
        }




        .dr23 {
            height: 378px !important;
            box-sizing: border-box;
            padding: 0 !important;
        }

        .PPM {
            background-color: yellow;
            display: block;
            font-size: 18px;
            color: #111;
        }
    </style>

    <script language="JavaScript" type="text/javascript">
        function FreezeScreen(msg) {
            $("#ContentPlaceHolder1_waiting_list_table").hide();
            scroll(0, 0);
            var outerPane = document.getElementById('FreezePane');
            var innerPane = document.getElementById('InnerFreezePane');
            if (outerPane) outerPane.className = 'FreezePaneOn';
            if (innerPane) innerPane.innerHTML = msg;

        }
    </script>

    <style type="text/css">
    </style>
    <script>
        function closeMessage() {
            $("#message5").hide();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="header" style="display: none">
        <div id="promotion5" runat="server" visible="false">
            <a href="~/users/getPromotionCode.aspx" runat="server">
                <asp:Label ID="promotionMessage" runat="server" Text="Label"></asp:Label></a>
        </div>
    </div>

    <div align="center" id="FreezePane" class="FreezePaneOff">
        <div id="InnerFreezePane" class="InnerFreezePane">
        </div>
    </div>
    <div class="messages13" style="padding-bottom: 5px">
        <center>
            <asp:Label ID="Label1" runat="server" Style="overflow: visible"></asp:Label>
        </center>
    </div>

<%--    <asp:Panel ID="no_time" runat="server" Visible="false">
        <ul>
            <li style="font-size: 16px; padding-bottom: 15px">
                <%= Resources.Resources.MinimumNecessaryToEnter %></li>
            <li>
                <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl="/users/rebill_card.aspx">
                    <%= Resources.Resources.ClickHereToPurchaseAdditionalTime%>
                </asp:HyperLink></li>
        </ul>
    </asp:Panel>--%>
    <center id="waiting_list_table" runat="server">
        <asp:ListView ID="ListViewGirlsOnline" runat="server" DataSourceID="SqlDataSourceGirlsOnline"
            EnableViewState="false">
            <LayoutTemplate>
                <div id="itemPlaceholder" runat="server">
                </div>
            </LayoutTemplate>
            <ItemTemplate>
                <div class="itemTemplate">
                    <div class="itemTop">
                        <div id="da<%# Container.DataItemIndex%>" class="imgShow" style="display: none">
                            <ul class="ul10">
                                <li><a href="/users/photoGallery.aspx?u=<%#Eval("SupplierID") %>" class="l7">
                                    <%= populateClassFromDB.GetSiteMessagesByKey("reviews") %></a></li>
                                <%--<li class="tip"><a href="/users/girlsTip.aspx?SupplierID=<%#Eval("SupplierID") %>" class="l7">
									<%= Resources.Resources.Tip %></a> </li>--%>
                            </ul>
                        </div>

                        <a href="/users/photoGallery.aspx?u=<%#Eval("SupplierID") %>">
                            <%#Nifgashot.NewPic(Eval("pic1").ToString(), "Suppliers")%>
                        </a>

                    </div>
                    <ul class="ul7">
                        <li>
                            <span class="itemName"><%# Eval("name")%></span>&nbsp;
                        </li>
                        <li style="height: 100px; overflow: hidden; display: block">
                            <div>
                                <%# Nifgashot.MaxLen(Eval("ExtraDetails").ToString(), 100)%>...
                            </div>
                        </li>
                        <li>
                            <div>
                                <%#Eval("City").ToString()%>...
                            </div>
                        </li>
                     <%--   <li>
                            <%#GirlGettingUsersHD(Eval("Online"), Eval("GirlGettingUsers"), Left(Eval("name"), 6), Eval("SupplierID"))%>
                        </li>--%>
                    </ul>


                </div>
            </ItemTemplate>
            <EmptyDataTemplate>
                <div style="padding-top: 40px; display: block;">
                 <%--   <%= Resources.Resources.NoGirlOnline %>--%>
                </div>
            </EmptyDataTemplate>
            <ItemSeparatorTemplate>
            </ItemSeparatorTemplate>
        </asp:ListView>
        <div class="pagingMain">
            <asp:DataPager ID="DataPagerProducts" runat="server" PagedControlID="ListViewGirlsOnline"
                PageSize="36">
                <Fields>
                    <asp:NumericPagerField CurrentPageLabelCssClass="current_page" NextPreviousButtonCssClass="next_button" NumericButtonCssClass="current_page" />
                </Fields>
            </asp:DataPager>
        </div>
        <asp:SqlDataSource ID="SqlDataSourceGirlsOnline" runat="server" SelectCommand="activeGirlsListNew2Entity"
            ConnectionString="<%$ ConnectionStrings:AskMe %>" SelectCommandType="StoredProcedure"></asp:SqlDataSource>

    </center>
    <div id="ctl00_newcamGirlAd" style="display: table; position: absolute; bottom: 0px; left: 0px; z-index: 999"
        runat="server">
    </div>

    <asp:Panel ID="PanelMessage" runat="server" Visible="false">
        <script type="text/javascript">
            alert('<%=site_message%>');
			<%--$(function () {
				$("#dialog").dialog({
					bgiframe: true,
					modal: true,
					close: function (ev, ui) { '<%= new_page%>'; },
					buttons: {
                        '<%= Resources.Resources.approve %>': function () {
							window.location = '<%= new_page%>';
						}
					}
				});
			});--%>
</script>
        <div id="dialog" title="<%= Resources.Resources.SystemMessage %>">
            <p>
                <%=site_message%><br />
                <%=site_message2%><br />
            </p>
        </div>
    </asp:Panel>
    <a href="BehindScreens/in_BehindScreens.aspx?g_num=3130"></a>

</asp:Content>
