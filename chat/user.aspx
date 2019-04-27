<%@ Page  Theme="" Language="vb" Title="נפגשות במצלמה" %>

<%@ Import Namespace="Entities" %>
<%@ Import Namespace="Math" %>
<%@ Import Namespace="System.IO" %>
<%@ Register Src="user.ascx" TagName="chatUser" TagPrefix="uc1" %>
<script runat="server">
    Public RndNum As String
    Public UserID As Integer
    Public SupplierID As Integer
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        UserID = populateClassFromDB.getUsersByGuid(Guid.Parse(Request("UserGuid"))).ID                                                                   )
        Dim checkAccess = New WaitingList(UserID, Request("SupplierID")).RunClass()
        If checkAccess <> 1 Then
            Response.End()
        End If
        SupplierID = Request("SupplierID")
        RndNum = userClass.insertUserToCamera(UserID, SupplierID).ToString()

        If RndNum = "99" Or RndNum = "98" Then
            Tools.addWindowsServiceLogs(SupplierID, UserID, RndNum, "user/MainModelsAPI.aspxqType=33-RndNum=" + RndNum + "", 1)
            Response.End()
        End If
        Try
            inChat.SendNotification((SupplierAPI.getMainModelsByNum(SupplierID).MainModelGuid).ToString(), "startCall")
        Catch ex As Exception
            errors.addErrorString(ex.InnerException.ToString())
        End Try
        Dim OnlineUsers_ As OnlineUsers = populateClassFromDB.getOnlineUsers(SupplierID)
        If RndNum <> OnlineUsers_.RndNumber.ToString() Then
            Response.Redirect("outCamera.aspx")
        End If
        Dim girlGuidAsString = databaseCon.scalerSql("select MainModelGuid from MainModels where SupplierID=" & SupplierID)
        Try
            Call inChat.SendNotification(girlGuidAsString, "startCall")
        Catch ex As Exception
            errors.addErrorString(ex.InnerException.ToString())
            Response.End()
        End Try
    End Sub
</script>


<html>
<head runat="server">
	<title></title>
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=0" />
	<link href="/users/chat/css/styleC.css" rel="stylesheet" />
	<link href="/users/chat/css/bootstrap.css" rel="stylesheet" />
	<link href="css/userCam.css" rel="stylesheet" />
	<script src="/Core/Scripts/jquery-3.1.1.js"></script>
	<script src="/Core/Scripts/jquery.signalR-2.2.2.js"></script>
	<script src="/Core/signalr/hubs"></script>
	<script src="/ws/adapter.js?v=1.01"></script>
	<script src="sfc.js?v=1.1"></script>
	<link href="/users/chat/css/chatC2018.css" rel="stylesheet" />
	<script>
		function disconnectChat() {
			//userDontWantToWaitForSupplier();
			disconnectUser();
		}

		$(window).on('beforeunload', function () {
			$.ajax({
				async: true,
				url: "camClientBackground.aspx?qtype=11&RndNumber=" + "<%=Session("RndNum")%>", success: function (result) {
				}
			});
		});
	</script>
</head>
<body style="margin: 0 0" class="userBody">
	<img src="/media/images/ajax-loader-purple.gif" style="width: 200px; margin-bottom: 20px; z-index: 100; position: fixed; top: 100px; display: none; left: 50%; transform: translate(-50%, -50%);" id="disconnectGif" />
	<div id="waitForSuppliers" style="z-index: 1500">
		<img src="/media/images/ajax-loader-purple.gif" style="width: 200px; margin-bottom: 20px;" />
		<br />
		<p>
			נא המתן להתחברות הבחורה
		<br />
			כל עוד הבחורה לא התחברה אתה לא מחוייב
		</p>
		<br />

		<label onclick="disconnectChat()" id="disconnectChat">להתנתקות לחץ כאן / To quit click here</label><br />
	</div>
	<script>
		var RndNumber = '<%=RndNum%>';
		var UserID = '<%=UserID%>'
		var SupplierID = '<%=SupplierID%>'
	</script>
	<script src="user.js?v=1.01"></script>
	<script type="text/javascript">

		function disconnectUser() {
			$("#disconnectGif").show();
			window.location.assign("/users/chat/outCamera.aspx?ios=11");
		}
	</script>
	<div class="main" style="display: block">
		<div class="performerName">
			<ul>
				<li>&nbsp;
				</li>
				<li>צ'אט עם
            <%=populateClassFromDB.getUsers(HttpContext.Current.Session("SupplierID")).Name%></li>
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
