<%@ Page Language="VB" %>
<%@ Import Namespace="dbClass" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="entitie" %>
<script runat="server">
	'Dim camGirl_ As New camGirl()
	'Dim sessionSupplier_ As New sessionSupplier()
	Protected Sub Page_Load(sender As Object, e As EventArgs)

		Response.Expires = 0
		Response.ExpiresAbsolute = DateAdd("m", 1, "31-Jan-00")
		Response.AddHeader("pragma", "no-cache")
		Response.AddHeader("cache-control", "private")
		Response.CacheControl = ("no-cache")
		If Session("girl_login") = 0 Then Response.End()
		If Request("qType") = 6 Then 'insert error to db from js
			Tools.addWindowsServiceLogs(Session("GetUserID_worker"), 0, 0, "error from js=" & Request("err"), Request("isError"))
			Response.End()
		ElseIf Request("qType") = 17 Then 'theChatWasActive=1
			databaseCon.ExecuteNonQuerySql("update ChatTimeUse set theChatWasActive=1,theChatWasActiveDateIn=getdate() where GetUserID=" & Session("GetUserID_worker") & " and UserID=(select UserID from NewModels where GetUserID=" & Session("GetUserID_worker") & " and Online=1) and RndNum=(select RndNum from NewModels where GetUserID=" & Session("GetUserID_worker") & ")")
			Response.Write("true")
			Response.End()
		ElseIf Request("qType") = 20 Then 'getGirlOnlineStatus=1 this is the blue screen
			Response.Write(databaseCon.scalerSql("select performerApproveUser from NewModels where GetUserID = " & Session("GetUserID_worker")))
			Response.End()
		ElseIf Request("qType") = 21 Then
			databaseCon.ExecuteNonQuerySql("update NewModels set performerApproveUser=0 where GetUserID=" & Session("GetUserID_worker"))
		End If
	End Sub
</script>
