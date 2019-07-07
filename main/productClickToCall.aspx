<%@ Page Title="" Language="C#" MasterPageFile="~/masters/main.master" Inherits="caltureCustomer" %>

<script runat="server">

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        .content {
            background-color: #ffffff;
        }

        .content {
            min-height: 2500px;
        }


        .featuresDiv {
            width: 100%;
            display: table;
            margin-bottom: 40px;
            padding: 20px;
            padding-top: 0;
            border-bottom: 1px solid #999;
            background-color: #fff;
            /* box-shadow: 2px 2px 9px 4px #c5c2c2; */
        }

            .featuresDiv video {
                padding-top: 30px;
            }


                    .featuresDivLeft {
                width:50%;
                float: left;
            padding: 20px;
            padding-right: 10px;
            box-sizing: border-box;
            color: #333;
            font-size: 14px;
            padding-left: 10px;
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

        .featuresDivRight img {
            width: 200px;
            float:right;
        }

        .featuresDivLeft img {
            width: 200px;
            float:left;
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
            padding: 20px;
            padding-right: 10px;
            box-sizing: border-box;
            color: #333;
            font-size: 14px;
            padding-left: 10px;
            }

            .featuresDivRight img {
                width: 200px;
                float: right;
            }

            .featuresDivLeft img {
                width: 200px;
                float: left;
            }

            .featuresDiv {
                padding: 0;
            }

            video {
                width: 100vw;
            }
        }

        .featuresDivRight div {
            display: inline-table !important;
        }

        .featuresDivRight h2 {
            margin-top: 0;
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
                height: 30px;
                line-height: 30px;
                width: 100%;
                display: inline-table;
            }

                .aneClass li l {
                    vertical-align: top;
                    display: inline-block;
                }

        .ani5 {
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
                cursor: pointer;
            }

            #callToAction a:hover {
                color: white;
                cursor: pointer;
            }
            .text-box h3{
               color: #0a5f6d;
    font-size: 24px;
            }
    </style>

    <!-- Custom styles for this template -->

    <h1><%=populateClassFromDB.GetSiteMessagesByKey("featuresTitle")%><br />
    </h1>
    <div class="mainDiv">
        <div class="featuresDiv">
            <div class="featuresDivLeft">

                <img src="../App_Themes/main/images/video-chat.png" />
            </div>
            <div class="featuresDivRight">
                <div class="cell text-box" >
                    <h3>Ask me Assessments</h3>
                    <p>Ask me leverages artificial intelligence, video, as well as game-based and coding challenges to collect key candidate insights, enabling organizations to make more informed hiring decisions. Ask me Assessments are customizable to your hiring objectives or ready to deploy based on pre-validated models.</p>
                    <p><a href="https://www.Ask me.com/products/assessments" target="_blank" rel="noopener">Learn More About Ask me Assessments &gt;</a></p>

                </div>
            </div>
        </div>

        <div class="featuresDiv">

            <div class="featuresDivLeft">
                <div class="cell text-box">
                    <h3>Ask me Assessments</h3>
                    <p>Ask me leverages artificial intelligence, video, as well as game-based and coding challenges to collect key candidate insights, enabling organizations to make more informed hiring decisions. Ask me Assessments are customizable to your hiring objectives or ready to deploy based on pre-validated models.</p>
                    <p><a href="https://www.Ask me.com/products/assessments" target="_blank" rel="noopener">Learn More About Ask me Assessments &gt;</a></p>

                </div>
            </div>
            <div class="featuresDivRight">

                <img src="../App_Themes/main/images/network.png" />
            </div>
        </div>







        <div id="callToAction">
            <a href="../companies/companySignUp.aspx"><%=populateClassFromDB.GetSiteMessagesByKey("SignUpForFree") %></a>
        </div>

    </div>
</asp:Content>

