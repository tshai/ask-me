<%@page  language="vb"  Title="נפגשות במצלמה"  %>
<%@ Import Namespace="entitie" %>
<script runat="server">


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Response.Redirect("/")

        'If Session("UserNum") Is Nothing Or String.IsNullOrEmpty(Session("GirlNum")) Or Not IsNumeric(Session("GirlNum")) = True Then Response.Redirect("/users/log_off.aspx")
        'Try
        '    Dim girlGuid = databaseCon.scalerSql("select MainModelGuid from Users where ID=" & Request("SupplierID"))
        '    Dim User As Users = populateClassFromDB.getUsers(Request("SupplierID"))
        '    'If Request("RndNum").ToString() = newModels.RndNumber.ToString() Then
        '    '    Call inChat.SendNotification(User, "endCall")
        '    'End If

        'Catch ex As Exception
        '    errors.insertErrors(ex)
        '    'Response.End()
        'End Try
        ''Response.End()
        ''populateClassFromDB.addWindowsServiceLogs(Session("GirlNum"), Session("UserNum"), Session("RndNum").ToString(), "user click disconnect from mobile-this page name is outCamera.aspx", 0)
        'userClass.userEndSession(25, "user click out link", Session("UserNum"), Session("GirlNum"), Session("RndNum"))
        ''Session("time_balance") = main_funct.sumUserTime(CType(Session("UserNum"), Integer))
        ''Session("login") = 1
        'databaseCon.ExecuteNonQuerySql("update ChatTimeUse set TimeUse=0,theChatWasActive=2 where SessionStatus=1 and theChatWasActive=0 and datediff(second,TheChatWasActiveDateIn,dateout)>29")
        'Response.Redirect("/users/add_review.aspx?GirlNum=" & Session("GirlNum") & "&t=1&m=1", True)
        'If String.IsNullOrEmpty(Request("EndError")) = False Then
        '    populateClassFromDB.addWindowsServiceLogs(Session("GirlNum"), Session("UserNum"), Session("RndNum").ToString(), "outCamera.aspx+err=" & Request("error") & "+request_get_out:" & Request("get_out"), 0)
        'Else
        '    populateClassFromDB.addWindowsServiceLogs(Session("GirlNum"), Session("UserNum"), Session("RndNum").ToString(), "outCamera.aspx+request_get_out:" & Request("get_out"), 0)
        'End If
        'Response.Cache.SetCacheability(HttpCacheability.NoCache)
        ''databaseCon.ExecuteNonQuerySql("update ChatTimeUse set TimeUse=0,theChatWasActive=2 where SessionStatus=1 and theChatWasActive=0 and datediff(second,TheChatWasActiveDateIn,dateout)>29")
        'Response.Redirect("/users/add_review.aspx?GirlNum=" & Session("GirlNum") & "&t=1&m=1")
        'Response.End()
    End Sub
</script>


