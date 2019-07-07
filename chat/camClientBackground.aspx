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
        'If Session("UserID") Is Nothing Then Response.End()
        If Request("qType") = 10 Then
            'databaseCon.ExecuteNonQuerySql("INSERT INTO LogLastVisit (userID,gender)VALUES(" & Session("UserID") & ",3)")
            'databaseCon.ExecuteNonQuerySql("update OnlineUsers set ulastvisit=getdate() where SupplierID=" & Session("SupplierID") & " and UserID=" & Session("UserID") & " and Online=1")
        ElseIf Request("qType") = 11 Then 'user close chat
            'If databaseCon.
            Using db As New Entities.Entities
                Dim RndNum As Guid = Guid.Parse(Request("RndNum"))
                Dim chatTimeUse As ChatTimeUse = (From a In db.ChatTimeUse Where a.RndNum = RndNum Select a).First()
                userClass.userEndSession("1", "userClickOut", chatTimeUse.CustomerID, chatTimeUse.SupplierID, chatTimeUse.RndNum)
                'databaseCon.ExecuteNonQuerySql("update OnlineUsers set UserID=1,Online=2,RndNumber='" & Guid.NewGuid().ToString() & "' where RndNumber='" & Request("RndNumber").ToString() & "')")
                Dim User As Users = populateClassFromDB.getUsers(chatTimeUse.SupplierID)
                Call inChat.SendNotification(User, "endCall", RndNum, chatTimeUse.CustomerID)



                Response.Write(chatTimeUse.SupplierID)

            End Using


            Response.Write("true")
            Response.End()

        End If
    End Sub
</script>
