<%@ Page Language="VB" Title="מסך הצ'ט" Theme="" EnableViewState="false" %>

<%@ Import Namespace="entitie" %>
<%@ Import Namespace="System.Linq" %>
<%@ Register Src="supplier.ascx" TagName="chatSLeora" TagPrefix="uc2" %>
<script language="vbscript" runat="server">

</script>

<html>

<head runat="server">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
      <script src="https://www.ask-me.app/Core/lib/signalr/dist/browser/signalr.js"></script>
    <script src="/chat/js/adapter-latest.js?v=1.01"></script>
    <script src="/chat/js/sfc.js?v=1.1"></script>
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">

    <script type="text/javascript">
        var supplierGuid = '231A153D-3762-4F76-B972-419832680505'
        var GirlNum = '1009';
        var SupplierID = GirlNum;
        function startChat() {//remove for test 26/1/19
            //connectChat();//remove 26-1-19
            //sendConnectToUser();
            $.ajax({
                async: false,
                url: "camSupplierBackground.aspx?qType=17", success: function (result) {
                    if (result == "true") {
                        connectChat();//remove 26-1-19
                        sendConnectToUser();
                    }

                }
            })
        }
    </script>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <script src="supplierWs4a2019NewCore.js?var=1"></script>
    <script type="text/javascript">

        function closeChat() {
            $.ajax({
                async: false,
                url: "chatApiForApp.aspx?qType=4&girlGuid=" + supplierGuid, success: function (result) {
                    if (result == "true") {
                        window.close();
                    }
                    else {
                        alert("error");
                    }
                }
            });
        }
        //setInterval(function () {
        //    $.ajax({
        //        async: false,
        //        url: "chatApiForApp.aspx?qType=7&girlGuid=" + supplierGuid, success: function (result) {
        //            if (result != "1") {
        //                window.close();
        //            }

        //        }
        //    });
        //    myTimer();
        //}, 3000);
    </script>
</head>
<body>

    <form runat="server" id="my_form">
        <div id="preloader" style="margin: auto; width: 800px; display: none;">
            <img src="/media/images/preloader.gif" />
        </div>

        <div class="content">

            <div class="topDiv header">
                <div class="customerTime">


                    <div class="cl cl-left">
                        <span>זמן שנשאר</span>
                        <input type="text" class="time-left" id="clientTimeTxt" readonly="readonly">
                    </div>
                    <div class="cl cl-right">
                        <span>מס' לקוח</span>
                        <input type="text" class="client-no" id="clientNumTxt" readonly="readonly">
                    </div>


                </div>
                <div class="closeChat" onclick="closeChat()">נתקי</div>

            </div>
            <div class="topDiv">
                <uc2:chatSLeora ID="chatSLeora1" runat="server" />
            </div>


        </div>

    </form>


</body>
</html>
