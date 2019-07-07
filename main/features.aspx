<%@ Page Language="VB" MasterPageFile="~/masters/main.master" Inherits="caltureCustomer" %>
<%@ Import Namespace="System.Windows.Forms" %>
<script runat="server">

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        Dim head As HtmlHead = Page.Header
        Dim metaDescription As New HtmlMeta()
        metaDescription.Name = "description"
        metaDescription.Content = populateClassFromDB.GetSiteMessagesByKey("VideoInterviewPlatformMeta")
        head.Controls.Add(metaDescription)
        Page.Title = populateClassFromDB.GetSiteMessagesByKey("VideoInterviewPlatform")
        If Session("domainName") <> "en-US" Then
            featureLink.HRef = "#"
            featureLink1.HRef = "#"
            'featureLink2.HRef = "#"
            'featureLink3.HRef = "#"
            'featureLink4.HRef = "#"
        End If
    End Sub


</script>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        .content {
            background-color: #ececec;
        }
                .content {
    min-height:2500px;
}


        .featuresDiv {
            width: 100%;
            display: table;
            margin-bottom: 40px;
            padding: 20px;
            padding-top:0;
            border-bottom: 1px solid #999;
            background-color: #fff;
            box-shadow: 2px 2px 9px 4px #c5c2c2;
        }
         .featuresDiv video{
         padding-top:30px;
        }
        .featuresDivLeft {
            width: 50%;
            float: left;
        }

        .featuresDivRight {
           width: 50%;
    float: right;
    padding: 20px;
    padding-right: 10px;
    box-sizing: border-box;
    color: #333;
    font-size: 14px;
    padding-left: 10px;
        }

        .mainDiv {
            width: 800px;
            display: table;
            margin: auto;
            margin-top: 50px;
            min-height: 1500px;
            box-sizing: border-box;
        }

        video {
            width: 400px;
        }

        img {
            width: 400px;
        }

        .fa {
            /*font-size: 30px;*/
            color: #006f30;
        }

        h1 {
            font-size: 40px;
            margin-top: 30px;
            background-color: white;
            padding: 20px;
            border-bottom: 1px solid #006f30;
        }

        h2 {
            color: #006f30;
        }

        @media screen and (max-width:500px) {
            .featuresDivRight {
                width: 100%;
				float: right;
            }

            .mainDiv {
                width: 100%;
            }

            .featuresDivLeft {
                width: 100%;
                float: left;
            }

            .featuresDivLeft img{
                width:100%;
            }
            .featuresDiv{
                padding:0;
            }
            video {
                width:100vw;
            }
        }
        .featuresDivRight div{
            display:inline-table !important; 
        }
        .featuresDivRight h2{
            margin-top:0;
        }

  .aneClass {
        list-style-type: none;
    }

        .aneClass div {
            display: inline-block;
            margin-left: 5px;
            margin-right: 5px;
            width: calc(100% - 50px);
        }
  
    .aneClass li {
       /*border:1px solid #999;*/
       height:30px;
       line-height:30px;
       width:100%;
       display:inline-table;
    }
        .aneClass li l {
            vertical-align: top;
            display: inline-block;
        }
        .ani5{

        }
         #callToAction {
            background-color: #0cb555;
            text-align: center;
            line-height: initial;
            font-size: 40px;
            color: white;
            text-shadow: initial;
            /*font-family: ariel;*/
            font-weight: initial;
            /* font-weight: 900; */
            font-size: 25px !important;
            border-radius: 10px;
            opacity: initial;
            display: table;
            margin: auto;
            padding: 10px 30px;
            margin: auto;
            display: table;
                margin-bottom: 50px;
        }

            #callToAction:hover {
                background-color: #111;
                cursor:pointer;
            }
            #callToAction a:hover{
                color:white;
                cursor:pointer;
            }
    </style>

    <!-- Custom styles for this template -->

    <h1><%=populateClassFromDB.GetSiteMessagesByKey("featuresTitle")%><br />
    </h1>
    <div class="mainDiv">
         <div class="featuresDiv">
            <div class="featuresDivLeft">

                <a href="videoInterviewSoftwarePlatform.aspx" id="featureLink" runat="server"><video class="img-fluid rounded-circle" autoplay loop class="embed-responsive-item">
                  <%--    <img src="../media/images/voiceSupport.jpg" />--%>
                    <source src="../media/videos/video-features.mp4" type="video/mp4">
                  </video></a>
            </div>
            <div class="featuresDivRight">

                <%=populateClassFromDB.GetSiteMessagesByKey("featuresInfo")%>
            </div>
        </div>

        <div class="featuresDiv">
            <div class="featuresDivLeft">

                <a href="videoInterviewFeature.aspx" id="featureLink1" runat="server">
                    <video class="img-fluid rounded-circle" autoplay loop class="embed-responsive-item">
                      <source src="  /media/videos/Fotolia_128733355_V_S.mp4" type="video/mp4">
                  </video></a>
            </div>
            <div class="featuresDivRight">

                <%=populateClassFromDB.GetSiteMessagesByKey("oneWayVideoInterviewTour")%>
            </div>
        </div>







           <div id="callToAction">
            <a href="../companies/companySignUp.aspx"><%=populateClassFromDB.GetSiteMessagesByKey("SignUpForFree") %></a>
        </div>
        
    </div>

</asp:Content>
