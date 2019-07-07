<%@ Page Language="C#" MasterPageFile="/masters/mainMaster.master" EnableViewState="false" Inherits="MainCulture" Title="נפגשות הכר אותה בוידאו צ'ט לפני הפגישה" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<script runat="server">

    public static string LblOnline = "";

    public static string getDetails(string he, string en)
    {
        if (HttpContext.Current.Session["Language2"] == null)
        {
            return he;
        }
        if (HttpContext.Current.Session["Language2"].ToString() == "EN" | HttpContext.Current.Session["Language2"].ToString() == "ES")
        {
            return en;
        }
        else
        {
            return he;
        }
    }

    public static string hd(int intext)
    {
        if (intext == 1)
            return "<img src='/App_Themes/users/images/HDIcon.png' class='ttRC'  title='" + "HD" + "' alt='" + "HD" + "' />";
        else
            return "";
    }



    public string ShowIfNew(int intext)
    {
        if (intext == 1)
            return "<img src='/App_Themes/users/images/show_if_newOld.gif' border='0' class='ttRC1'  title='" + populateClassFromDB.GetSiteMessagesByKey("NewInSite") + "' alt='new'/>";
        else
            return "";
    }


    protected void repItems_SelectedIndexChanged(object sender, EventArgs e)
    {
        repItems.DataBind();
    }

</script>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .coverDiv {
            height: 600px;
            z-index: 3;
            position: absolute;
            opacity: 0.6;
            background-color: #333;
            width: 100%;
        }

        #slogenMainPage {
            text-align: center;
            border-radius: 10px;
            opacity: 0.95;
            color: #ffffff;
            font-weight: 900;
            font-size: 6em;
            line-height: 1em;
            margin-bottom: 15px;
            text-shadow: 2px 2px 3px rgba(0, 0, 0, 1);
            font-family: 'Open Sans Hebrew';
            position: absolute;
            top: 300px;
            position: absolute;
            left: 50%;
            transform: translate(-50%, -50%);
            z-index: 4;
        }

            #slogenMainPage h3 {
                font-size: 0.8em;
            }

            #slogenMainPage h3, #slogenMainPage h2 {
                color: #ffffff;
            }

            #slogenMainPage h2 {
                font-size: 0.6em;
            }

        h1, h2, h3, h4, h5, h6 {
            font-family: 'Montserrat', sans-serif;
            color: #2d2d2d;
            line-height: 1.3;
            margin: 0px;
        }

        .itemImage img {
            width: 200px !important;
            height: 200px !important;
        }

        .itemTemplate {
            width: 200px !important;
        }

        .ul7, .ul2 {
            width: 100% !important;
        }

        .motivation-container {
            position: relative;
            z-index: 6;
            margin: 48px 0 40px;
            background: #fff;
        }

        @media (min-width: 1721px) {
            .motivation-container .react-limiting-wrapper {
                max-width: 1700px;
            }
        }

        @media (max-width:600px) {
            h1, h2, h3, h4, h5, h6 {
                line-height: 1;
            }
        }

        .motivation-container .react-limiting-wrapper {
            padding: 0 25px;
            -webkit-box-sizing: content-box;
            box-sizing: content-box;
        }

        @media (min-width: 1721px) {
            .motivation-container .react-limiting-wrapper {
                max-width: 1700px;
            }
        }

        .motivation-container .react-limiting-wrapper {
            padding: 0 25px;
        }

        @media (min-width: 1721px) {
            .motivation-container .react-limiting-wrapper {
                max-width: 1700px;
            }
        }

        .motivation-container .react-limiting-wrapper {
            padding: 0 25px;
        }

        .react-limiting-wrapper {
            position: relative;
            margin: 0 auto;
            padding: 0 7px;
            max-width: 1336px;
            min-width: 320px;
            -webkit-box-sizing: border-box;
            box-sizing: border-box;
        }

        .benefits-container {
            margin: 0 auto;
            max-width: 1340px;
            width: 100%;
        }

            .benefits-container > .wrapper {
                display: table;
                width: 100%;
            }



            .benefits-container .benefit {
                font-size: 16px;
                vertical-align: top;
                text-align: center;
                margin: 20px 0;
                width: 33%;
                float: left;
            }

                .benefits-container .benefit .image {
                    display: block;
                    margin: auto;
                    max-width: 100%;
                    max-height: 131px;
                }

                .benefits-container .benefit .image-placeholder > .wrapper {
                    text-align: center;
                    vertical-align: middle;
                }

        @media only screen and (max-width: 999px) {
            .itemTemplate {
                width: 100% !important;
                height: 100% !important;
                padding: 0px !important;
            }

            .signUpForm img {
                width: 100% !important;
                height: 100% !important;
            }

            .motivation-container .react-limiting-wrapper {
                padding: 0px !important;
            }

            video {
                width: 100% !important;
                height: 100% !important;
                object-fit: fill !important;
            }
        }

        .button1 {
            width: 150px;
            height: 30px;
            background-color: green;
            color: white;
            margin: auto;
            line-height: 30px;
            text-align: center;
            border-radius: 5px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="video-area1" id="video-area1" style="height: 600px; overflow: hidden;">

        <div class="coverDiv" style="opacity: 0.7"></div>
        <video autoplay="" muted="" loop="" id="myVideo" style="zoom: 3;">
			<source src="/media/videos/700_F_80556980_NDS8T9EMeVAreqdg7RH5RXXSDGSXQYWe_ST.mp4" type="video/mp4">
			Your browser does not support HTML5 video.
		</video>
        <div id="slogenMainPage">
            <h3><%=populateClassFromDB.GetSiteMessagesByKey("meet") %> </h3>
            <h2><%=populateClassFromDB.GetSiteMessagesByKey("meetHer")%></h2>
            <p style="font-size: 24px; line-height: 20px"><%=populateClassFromDB.GetSiteMessagesByKey("meetHer2") %></p>
            <p style="font-size: 18px; line-height: 14px"><%=populateClassFromDB.GetSiteMessagesByKey("meetHer3") %></p>
        </div>

    </div>
    <div class="performers">
        <%--    <h1>Performers</h1>--%>
    </div>
    <div id="mainGirls">
        <asp:ListView ID="repItems" runat="server"
            OnPagePropertiesChanged="repItems_SelectedIndexChanged"
            DataSourceID="SqlDataSource2">
            <LayoutTemplate>
                <div id="itemPlaceholder" runat="server">
                </div>
                <div class="paging" style="clear: both; width: 100%" runat="server">
                    <asp:DataPager ID="DataPagerUsers" runat="server" PagedControlID="repItems" PageSize="36">
                        <Fields>
                            <asp:NumericPagerField ButtonType="Link" CurrentPageLabelCssClass="current_page"
                                NumericButtonCssClass="current_page"
                                ButtonCount="5" />
                        </Fields>
                    </asp:DataPager>
                </div>
            </LayoutTemplate>
            <ItemTemplate>
                <div class="itemTemplate">
                    <div class="itemTop">
                        <a href='users/photoGallery.aspx?ID=<%#Eval("SupplierID") %>' class="itemImage" title="<%# populateClassFromDB.GetSiteMessagesByKey("Iam") + " " + Eval("name").ToString() %>"
                            rel="nofollow">
                            <%# Nifgashot.NewPic(Eval("pic1").ToString(), "Suppliers")%></a>

                    </div>
                    <div class="itemInfo">
                        <ul class="ul7">
                            <li>
                                <span class="itemName"><%# Eval("name")%></span>
                            </li>
                            <li style="height: 100px; overflow: hidden; display: block">
                                <div>
                                    <%#Nifgashot.MaxLen(Eval("ExtraDetails").ToString(), 100)%>...
                                </div>
                            </li>
                            <li>
                                <div>
                                    <%#Eval("City").ToString()%>...
                                </div>
                            </li>
                            <li>
                                <a href="/chat/CreateAnonymousUser.aspx?ID=<%#Eval("SupplierID") %>">
                                    <div class="button1">
                                        <%=populateClassFromDB.GetSiteMessagesByKey("call") %>
                                    </div>
                                </a>
                            </li>
                        </ul>

                    </div>


                </div>
            </ItemTemplate>
        </asp:ListView>
    </div>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" CacheDuration="1000"
        ConnectionString="<%$ ConnectionStrings:AskMe %>"
        SelectCommand="mainPageHebrew" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    <section class="motivation-container benefits"><div class="react-limiting-wrapper">
        <div class="benefits-container"><div class="wrapper">
            <section class="benefit"><div class="wrapper">
                <div class="image-placeholder">
                    <div class="wrapper">
                        <img class="image" src="/media/images/512.png" alt="Global" style="width:initial !important;height:initial !important"></div></div><div class="content"><h3>
                            </h3><p>
                                <l10n  contenteditable="false">
                               <%=populateClassFromDB.GetSiteMessagesByKey("fakeSites") %>

  </l10n></p></div></div>

            </section><section class="benefit"><div class="wrapper">
                <div class="image-placeholder"><div class="wrapper">
                    <img class="image" src="/media/images/excited.png" alt="Exciting" style="width:initial !important;height:initial !important""></div></div>
                <div class="content"><p>
                    <l10n contenteditable="false"><%=populateClassFromDB.GetSiteMessagesByKey("meetGirlsBoys") %></l10n></p></div></div></section>
            <section class="benefit"><div class="wrapper">
                <div class="image-placeholder">
                    <div class="wrapper">
                        <img class="image" src="/media/images/female.png" alt="Modern" 
                            style="width:initial !important;height:initial !important"></div></div><div class="content">
                                <p><l10n  contenteditable="false"><%=populateClassFromDB.GetSiteMessagesByKey("notPassAlone") %></l10n></p></div></div></section></div></div></div></section>
</asp:Content>
