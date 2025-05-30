﻿<%@ Page Theme="" Language="vb" Title="נפגשות במצלמה" %>

<%@ Import Namespace="entitie" %>
<%@ Import Namespace="Math" %>
<%@ Import Namespace="System.IO" %>
<%@ Register Src="user.ascx" TagName="chatUser" TagPrefix="uc1" %>
<script runat="server">
    Public RndNum As String
    Public CustomerID As Integer
    Public SupplierID As Integer
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        CustomerID = SupplierAPI.getMainModelsByChatGuid(Guid.Parse(Request("UserChatGuid"))).ID 'this is the watcher
        SupplierID = SupplierAPI.getMainModelsByChatGuid(Guid.Parse(Request("SupplierChatGuid"))).ID 'this is the supplier
        Dim checkAccess = New WaitingList(CustomerID, SupplierID).RunClass()
        If checkAccess <> 1 Then
            Response.Write(checkAccess)
            Response.End()
        End If
        Dim SupplierToServicePriceGuid1 As Guid
        Using db = New Entities.Entities()
            Dim Users_ As Users = populateClassFromDB.getUsers(SupplierID)

            SupplierToServicePriceGuid1 = (From a In db.SupplierToServicePrice Where a.ID = Users_.SupplierToServicePriceID Select a.SupplierToServicePriceGuid).First()



        End Using

        RndNum = userClass.insertUserToCamera(CustomerID, SupplierID, SupplierToServicePriceGuid1).ToString()

        If RndNum = "99" Or RndNum = "98" Or RndNum = "96" Then
            Tools.addWindowsServiceLogs(SupplierID, CustomerID, RndNum, "chat/MainModelsAPI.aspxqType=33-RndNum=" + RndNum + "", 1)
            Response.Write(RndNum)

            Response.End()
        End If
        'Try
        '    inChat.SendNotification((SupplierAPI.getMainModelsByNum(SupplierID).MainModelGuid).ToString(), "startCall")
        'Catch ex As Exception
        '    errors.addErrorString(ex.InnerException.ToString())
        'End Try
        Dim OnlineUsers_ As OnlineUsers = populateClassFromDB.getOnlineUsers(SupplierID)

        If RndNum <> OnlineUsers_.RndNumber.ToString() Then

            Response.Write("2-" + RndNum)

            Response.End()
            Response.Redirect("outCamera.aspx")
        End If

        'Try
        Call inChat.SendNotification(populateClassFromDB.getUsers(SupplierID), "startCall", Guid.Parse(RndNum), CustomerID)
        Response.Write(SupplierID)

        Response.End()
        'Catch ex As Exception
        '    errors.addErrorString(ex.InnerException.ToString())
        '    Response.End()
        'End Try

    End Sub
</script>


<html>
<head runat="server">
    <title></title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=0" />
    <link href="/chat/css/styleC.css" rel="stylesheet" />
    <link href="/chat/css/bootstrap.css" rel="stylesheet" />
    <link href="/chat/css/userCam.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://www.ask-me.app/Core/lib/signalr/dist/browser/signalr.js"></script>
    <script src="/chat/js/adapter-latest.js?v=1.01"></script>
    <script src="/chat/js/sfc.js?v=1.1"></script>
    <link href="/chat/css/chatC2018.css" rel="stylesheet" />
    <script>
        function disconnectChat() {
			//userDontWantToWaitForSupplier();
<%--            $.ajax({
                async: true,
                url: "camClientBackground.aspx?qtype=11&RndNumber=" + "<%=RndNum%>", success: function (result) {
                }
            });--%>
            disconnectUser();
        }

		<%--$(window).on('beforeunload', function () {
			$.ajax({
				async: true,
				url: "camClientBackground.aspx?qtype=11&RndNumber=" + "<%=RndNum%>", success: function (result) {
				}
			});
		});--%>
</script>
</head>
<body style="margin: 0 0" class="userBody">
    <audio controls id="ringTone" style="display: none">
        <source src="phone-calling-1.mp3" type="audio/mpeg">
        Your browser does not support the audio element.
    </audio>
    <img src="/media/images/ajax-loader-purple.gif" style="width: 200px; margin-bottom: 20px; z-index: 100; position: fixed; top: 100px; display: none; left: 50%; transform: translate(-50%, -50%);" id="disconnectGif" />
    <div id="waitForSuppliers" style="z-index: 1500; display: block">
        <img src="/media/images/ajax-loader-purple.gif" style="width: 200px; margin-bottom: 20px;" />
        <br />
        <p>
            נא המתן להתחברות הבחורה

        </p>
        <br />

        <label onclick="disconnectChat()" id="disconnectChat">להתנתקות לחץ כאן / To quit click here</label><br />
    </div>
    <script>
        var RndNumber = '<%=RndNum%>';
        var CustomerID = '<%=CustomerID%>'
        var CustomerID = CustomerID;
        var SupplierID = '<%=SupplierID%>'
<%--		var RndNumber = '<%=Session("RndNum")%>';
        var CustomerGuid = '<%=populateClassFromDB.getMainModels(HttpContext.Current.Session("CustomerID")).MainModelGuid%>'
        var CustomerID='<%=Session("CustomerID")%>'
		var supplierID = '<%=Session("GirlNum")%>'--%>
</script>
    <script src="/chat/js/customerCore28-2-19.js?v=1.49"></script>
    <script type="text/javascript">

        function disconnectUser() {
            $.ajax({
                async: true,
                url: "camClientBackground.aspx?qtype=11&RndNum=" + "<%=RndNum%>", success: function (result) {
                }
            });
            $("#disconnectGif").show();
            //window.location.assign("/");
        }
        $("#ringTone")[0].play();
    </script>
    <div class="main" style="display: block">
        <div class="performerName">
            <ul>
                <li>&nbsp;
                </li>
                <li>צ'אט עם
            <%=populateClassFromDB.getUsers(SupplierID).Name%></li>
                <li>
                    <div id="disconnectDiv3">
                        <label onclick="disconnectUser()" class="buttonRed">ניתוק</label>
                    </div>
                </li>
            </ul>

        </div>
        <div id="cameraClose" runat="server" visible="false">
            <label>כדי שתוכל לפתוח מצלמה ולדבר עליך לאפשר זאת בהגדרות הדפדפן</label><label onclick="hideCameraMessage()">( הסתר הודעה)</label>
            <span class="glyphicon glyphicon-remove"></span>
            &nbsp;
        </div>
        <div id="lessMinute" style="margin: auto; width: 100%; display: none">
            <div style="position: absolute; margin-right: 40%; top: 40px; opacity: 0.7; filter: alpha(opacity=40); z-index: 2000">
                <img src="../../media/images/lessMinute.gif" alt="" />
            </div>
        </div>
        <div id="disconnectDiv">
            <label id="disconnectUserButton"
                class="disconnectButton" onclick="disconnectUser()">
                התנתק</label>

        </div>
        <div id="videoSection">
            <uc1:chatUser ID="chatUser1" runat="server" />
            <div id="disconnectDiv2" style="display: none">
                <img src="/media/images/delete-icon.png" onclick="disconnectUser()" style="width: 20px; cursor: pointer;" />
            </div>
        </div>

        <div id="mainDiv">



            <div id="CCPreloader" style="text-align: center; display: none">
                <img src="/media/images/preloader.gif" />
            </div>

        </div>
        <div style="width: 100%">


            <div id="cc_answer_table" style="display: none">
                <label id="Label5"></label>
            </div>
            <asp:Label ID="Label2" runat="server" Text=""></asp:Label>
        </div>
    </div>
</body>
</html>
