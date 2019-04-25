<%@ Page Language="VB" MasterPageFile="~/masters/main.master" Inherits="caltureCustomer" %>
<%@ Import Namespace="Entities" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<script runat="server">

    Public Shared LblOnline As String = ""

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        If String.IsNullOrEmpty(Session("employeeID")) = False Then
            cpaOuter.Visible = False
        End If
        Page.Title = populateClassFromDB.GetSiteMessagesByKey("pageTitle")

        If String.IsNullOrEmpty(Request("message")) = False Then
            'If Request("message") = 54 Then
            '    If String.IsNullOrEmpty(Session("candidateApplyToJobGuid")) = False Then
            '        Dim candidateApplyToJobGuid = Session("candidateApplyToJobGuid")
            '        Using db = New Entities.Entities()
            '            Dim canddidateApplyToJob = (From a In db.CandidateApplyToJob Where a.CandidateApplyToJobGuid = candidateApplyToJobGuid Select a).FirstOrDefault()
            '            Dim job_ = (From a In db.Jobs Where a.ID = canddidateApplyToJob.jobID Select a).FirstOrDefault()
            '            Dim company_ = (From a In db.Companies Where a.ID = job_.companyID Select a).FirstOrDefault()
            '            Dim nextRequest = (From a In db.RequestToVideoInterview Where a.ID = canddidateApplyToJob.requestToVideoInterviewID Select a).FirstOrDefault()
            '            If (job_.orderForApplies = 1) Then
            '                Response.Redirect("companyProfile.aspx?companyGuid=" & company_.companyGuid.ToString() & "&action=58&RequestToVideoInterviewGuid=" & nextRequest.RequestToVideoInterviewGuid.ToString() & "&candidateApplyToJobGuid=" & candidateApplyToJobGuid.ToString())
            '            End If
            '        End Using
            '    End If
            'End If
        End If
    End Sub







</script>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">


    <link href="https://fonts.googleapis.com/css?family=Assistant:800" rel="stylesheet">

    <style>
        @import url(//fonts.googleapis.com/earlyaccess/opensanshebrew.css);

        #slogenMainPage {

            text-align: center;
            border-radius: 10px;
            opacity: 0.95;
            color: #245c65;
            font-weight: 900;
            font-size: 6em;
            line-height: 1.2em;
            margin-bottom: 15px;
            text-shadow:2px 2px 3px rgb(183, 178, 178);
            font-family: 'Open Sans Hebrew';
            position: absolute;
            top: 300px;
            position: absolute;
            left: 50%; /* position the left edge of the element at the middle of the parent */
            transform: translate(-50%, -50%); /* This is a shorthand of
                                         translateX(-50%) and translateY(-50%) */
        }

            #slogenMainPage label {
                font-size: 0.5em;
                width: 100%;
                display: inline-block;
                text-align: center;
                COLOR: #474747;
            }
.feature {
    width: 300px;
    float: left;
    margin: 10px 10px;
        border: 1px solid #cac6c6;
    padding: 10px;
    background-color: #fdfdfd;
}

            .feature p {
                color: #2f2f2f;
                font-size: 16px;
            }
.row1 {
    margin: auto;
    display: table;
    /* height: 300px; */
    display: flex;
    justify-content: center;
        margin-bottom:30px;
}

        .row2 {
            /*width: 1000px;*/
            margin: auto;
            display: flex;
            height: 1000px;
            justify-content: center;
        }

        .fa {
            display: block;
            color: #26ae61;
            font-size: 30px;
            margin: auto;
            width: 40px;
        }

        .single_bright_feature {
            background-color: #f7f7f7;
            border-radius: 5px;
            margin-bottom: 30px;
            padding: 30px;
            position: relative;
            -webkit-transition-duration: 500ms;
            -o-transition-duration: 500ms;
            transition-duration: 500ms;
            z-index: 1;
        }


        /*.col-lg-4 {
            -ms-flex: 0 0 30%;
            flex: 0 0 30%;
            max-width: 30%;
        }*/

        .text-center {
            text-align: center !important;
        }

        .features_icon {
            background-color: #0a5f6d;
            border-radius: 50%;
            color: #fff;
            font-size: 24px;
            height: 50px;
            line-height: 56px;
            margin-top: -25px;
            position: absolute;
            right: -25px;
            top: 50%;
            width: 50px;
        }

        .features_iconright {
            background-color: #0a5f6d;
            border-radius: 50%;
            color: #fff;
            font-size: 24px;
            height: 50px;
            line-height: 56px;
            margin-top: -25px;
            position: absolute;
            left: -25px;
            top: 50%;
            width: 50px;
        }

        h1, h2, h3, h4, h5, h6 {
            font-family: 'Raleway', sans-serif;
            font-weight: 400;
            color: #000;
            line-height: 1.2;
        }

        .h5, h5 {
            font-size: 1.25rem;
        }

        .single_bright_feature > p {
            margin-bottom: 0;
            color: #2f2f2f;
        }

        .col, .col-1, .col-10, .col-11, .col-12, .col-2, .col-3, .col-4, .col-5, .col-6, .col-7, .col-8, .col-9, .col-auto, .col-lg, .col-lg-1, .col-lg-10, .col-lg-11, .col-lg-12, .col-lg-2, .col-lg-3, .col-lg-4, .col-lg-5, .col-lg-6, .col-lg-7, .col-lg-8, .col-lg-9, .col-lg-auto, .col-md, .col-md-1, .col-md-10, .col-md-11, .col-md-12, .col-md-2, .col-md-3, .col-md-4, .col-md-5, .col-md-6, .col-md-7, .col-md-8, .col-md-9, .col-md-auto, .col-sm, .col-sm-1, .col-sm-10, .col-sm-11, .col-sm-12, .col-sm-2, .col-sm-3, .col-sm-4, .col-sm-5, .col-sm-6, .col-sm-7, .col-sm-8, .col-sm-9, .col-sm-auto, .col-xl, .col-xl-1, .col-xl-10, .col-xl-11, .col-xl-12, .col-xl-2, .col-xl-3, .col-xl-4, .col-xl-5, .col-xl-6, .col-xl-7, .col-xl-8, .col-xl-9, .col-xl-auto {
            /*position: relative;*/
            width:300px;
            min-height: 1px;
            margin:10px;
            padding:10px;
        }

        .mt-50 {
            margin-top: 50px;
        }

        .align-items-center {
            -ms-flex-align: center !important;
            align-items: center !important;
        }

        .row {
            display: -ms-flexbox;
            display: flex;
            -ms-flex-wrap: wrap;
            flex-wrap: wrap;
            margin-right: -15px;
            margin-left: -15px;
        }

        p {
            color: #fff;
            font-size: 16px;
            font-weight: 300;
        }

        img {
            max-width: 100%;
        }

        #rowsDiv {
            margin-top:450px;
        }

        #callToAction {
            background-color: #3d3d3d;
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
        }

            #callToAction:hover {
                background-color: #111;
            }

        .fa {
            font-size: 20px !important;
            display: inline-block;
            margin: auto;
        }
        .companyUsing{
            list-style-type:none;
            width:100%;
        }
         .companyUsing li{
       width: 10%;
    float: left;
        }
    </style>
    <link href="media/slick.css" rel="stylesheet" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="defaultBackground">

        <div class="container">
            <%--          <div class="clients">--%>
            <div aria-live="polite" class="slick-list draggable">
                <ul class="companyUsing">
                    <li>
                        <img src="/media/images/Bank-Investments.jpg" alt="Client Logo 1">
                    </li>
                    <li>
                        <img src="/media/images/client-google.png" alt="Client Logo 2">
                    </li>
                    <li>
                        <img src="/media/images/client-sap.png" alt="Client Logo 3">
                    </li>
                    <li>
                        <img src="/media/images/burla17.png" alt="Client Logo 4">
                    </li>
                    <li>
                        <img src="/media/images/bank_client_logo.png" alt="Client Logo 5">
                    </li>
                    <li>
                        <img src="/media/images/client-hp.png" alt="Client Logo 1">
                    </li>
                    <li>
                        <img src="/media/images/works4u.png" alt="Client Logo 2">
                    </li>
                    <li>
                        <img src="/media/images/client-at-and-t.png" alt="Client Logo 3">
                    </li>
                    <li>
                        <img src="/media/images/client-infosys.png" alt="Client Logo 4">
                    </li>
                    <li>
                        <img src="/media/images/client-tata.png" alt="Client Logo 5">
                    </li>

                </ul>
            </div>

            <%--  </div>--%>
        </div>
    </div>
    <div id="slogenMainPage">
        <%=populateClassFromDB.GetSiteMessagesByKey("bigLogo")%>
        <br />
        <label><%=populateClassFromDB.GetSiteMessagesByKey("smallLogo")%></label>
        <div id="cpaOuter" runat="server">
        <div id="callToAction">
            <a href="companies/companySignUp.aspx"><%=populateClassFromDB.GetSiteMessagesByKey("SignUpForFree") %></a>
        </div>
            </div>
    </div>



    <div id="rowsDiv">
        <div class="row1">
            <div class="feature">
                <!-- Single Feature-->
                <div class="single_feature home_2 text-center">
                    <!--  Feature Icon-->
                    <div class="feature_icon">
                        <i class="fa fa-paper-plane-o" aria-hidden="true"></i>
                    </div>
                    <h2><%=populateClassFromDB.GetSiteMessagesByKey("getRidOfPaper")%></h2>
                    <p><%=populateClassFromDB.GetSiteMessagesByKey("getRidOfPaperDescription")%></p>
                </div>
            </div>

            <div class="feature">
                <!-- Single Feature-->
                <div class="single_feature home_2 text-center">
                    <!--  Feature Icon-->
                    <div class="feature_icon">
                        <i class="fa fa-car" aria-hidden="true"></i>
                    </div>
                    <h2><%=populateClassFromDB.GetSiteMessagesByKey("saveTimeAndEffort")%></h2>
                    <p><%=populateClassFromDB.GetSiteMessagesByKey("saveTimeAndEffortDescription")%></p>
                </div>
            </div>

            <div class="feature">
                <!-- Single Feature-->
                <div class="single_feature home_2 text-center">
                    <!--  Feature Icon-->
                    <div class="feature_icon">
                        <i class="fa fa-video-camera" aria-hidden="true"></i>
                    </div>
                    <h2><%=populateClassFromDB.GetSiteMessagesByKey("anotherDimension")%></h2>
                    <p><%=populateClassFromDB.GetSiteMessagesByKey("anotherDimensionDescription")%></p>
                </div>
            </div>

            <%-- <div class="feature">
                    <!-- Single Feature-->
                    <div class="single_feature home_2 text-center">
                        <!--  Feature Icon-->
                        <div class="feature_icon">
                            <i class="pe-7s-mouse"></i>
                        </div>
                        <h2>Web Development</h2>
                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis at </p>
                    </div>
                </div>--%>
        </div>
        <div class="row2">
<%--            <div class="row align-items-center mt-50">--%>
                <div class="col-lg-4">
                    <div class="single_bright_feature text-center">
                        <div class="features_icon">
                            <i class="pe-7s-server"></i>
                        </div>
                        <h5><%=populateClassFromDB.GetSiteMessagesByKey("powerfullProduct")%></h5>
                        <p><%=populateClassFromDB.GetSiteMessagesByKey("powerfullProductDescription")%></p>
                    </div>
                    <div class="single_bright_feature text-center">
                        <div class="features_icon">
                            <i class="pe-7s-science"></i>
                        </div>
                        <h5><%=populateClassFromDB.GetSiteMessagesByKey("fullSupport")%></h5>
                        <p><%=populateClassFromDB.GetSiteMessagesByKey("fullSupportDescription")%></p>
                    </div>
                    <div class="single_bright_feature text-center">
                        <div class="features_icon">
                            <i class="pe-7s-album"></i>
                        </div>
                        <h5><%=populateClassFromDB.GetSiteMessagesByKey("unbeatablePrices")%></h5>
                        <p><%=populateClassFromDB.GetSiteMessagesByKey("unbeatablePricesDescription")%></p>
                    </div>
                </div>

                <div class="col-lg-4">
                    <div class="bright_features_thumb">
                        <img src="/media/images/feature-1.jpg" alt="ראיונות עבודה בוידאו צ'ט">
                    </div>
                </div>

                <div class="col-lg-4">
                    <div class="single_bright_feature right-fea text-center">
                        <div class="features_iconright">
                            <i class="pe-7s-rocket"></i>
                        </div>
                        <h5><%=populateClassFromDB.GetSiteMessagesByKey("customizationOption")%></h5>
                        <p><%=populateClassFromDB.GetSiteMessagesByKey("customizationOptionDescription")%></p>
                    </div>
                    <div class="single_bright_feature right-fea text-center">
                        <div class="features_iconright">
                            <i class="pe-7s-cup"></i>
                        </div>
                        <h5><%=populateClassFromDB.GetSiteMessagesByKey("fullIntegretion")%></h5>
                        <p><%=populateClassFromDB.GetSiteMessagesByKey("fullIntegretionDescription")%></p>
                    </div>
                    <div class="single_bright_feature right-fea text-center">
                        <div class="features_iconright">
                            <i class="pe-7s-graph3"></i>
                        </div>
                        <h5><%=populateClassFromDB.GetSiteMessagesByKey("easyForUse")%></h5>
                        <p><%=populateClassFromDB.GetSiteMessagesByKey("easyForUseDescription")%></p>
                    </div>
                </div>
         <%--   </div>--%>
        </div>
    </div>
    <%--    <div id="mainButtonsDiv">

            <a href="/companies/companySignUp.aspx" class="mainButton">חברות השמה</a>

            <a href="/main/login.aspx" class="mainButton">מתראיינים</a>
       
    </div>--%>
</asp:Content>
