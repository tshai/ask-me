<%@ Page Language="VB" %>
<%@ Import Namespace="entitie" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="dbClass" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<script runat="server">
    'Dim camGirl_ As New camGirl()
    'Dim sessionSupplier_ As New sessionSupplier()
    Protected Sub Page_Load(sender As Object, e As EventArgs)
        Response.Expires = 0
        Response.ExpiresAbsolute = DateAdd("m", 1, "31-Jan-00")
        Response.AddHeader("pragma", "no-cache")
        Response.AddHeader("cache-control", "private")
        Response.CacheControl = ("no-cache")
        If Session("UserID") Is Nothing Then Response.End()
        If Request("qType") = 10 Then
            'databaseCon.ExecuteNonQuerySql("INSERT INTO LogLastVisit (userID,gender)VALUES(" & Session("UserID") & ",3)")
            'databaseCon.ExecuteNonQuerySql("update NewModels set ulastvisit=getdate() where SupplierID=" & Session("SupplierID") & " and UserID=" & Session("UserID") & " and Online=1")
        ElseIf Request("qType") = 11 Then 'user close chat
            'If databaseCon.
            userClass.userEndSession("1", "userClickOut", Session("UserID"), Session("SupplierID"), Session("RndNum"))
            'databaseCon.ExecuteNonQuerySql("update NewModels set UserID=1,Online=2,RndNumber='" & Guid.NewGuid().ToString() & "' where RndNumber='" & Request("RndNumber").ToString() & "')")
            Dim girlGuid = databaseCon.scalerSql("select MainModelGuid from MainModels where SupplierID=" & Session("SupplierID"))
            Call inChat.SendNotification(girlGuid, "endCall")
            Response.Write("true")
            Response.End()

        End If
    End Sub
</script>
