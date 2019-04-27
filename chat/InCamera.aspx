<%@ Page AspCompat="true" Language="vb"  Title="נפגשות במצלמה"  %>
<%@ Import Namespace="entity" %>
<script runat="server">
    Sub Page_Load(ByVal sender As Object, ByVal args As EventArgs) Handles MyBase.Load
        If databaseCon.scalerSql("select UsersActive from Setting") = 0 Then
            Response.Write("<center>האתר סגור למספר דקות לצורך שדרוג המערכת</center>")
            Response.End()
        End If
        'If main_funct.checkIfBlockIp(userClass.extractUserIp()) = 1 Then
        '    Response.Redirect("/users/performersList.aspx")
        'End If
        If String.IsNullOrEmpty(Session("UserNum")) = True Then
            Response.Redirect("/Default.aspx")
        End If
        If String.IsNullOrEmpty(Session("GirlNum")) Or Not IsNumeric(Session("GirlNum")) = True Or Session("login") <> 2 Or IsNumeric(Request("GirlNum").Trim) = False Then
            populateClassFromDB.addWindowsServiceLogs(Session("GirlNum"), Session("UserNum"), Session("RndNum"), "user/in_camera.aspx-RndNum=session_problem:login:" & Session("login"), 1)
            Session("login") = 1
            Response.Redirect("/users/performersList.aspx?s=2")
            Response.End()
        End If
        Response.Cache.SetCacheability(HttpCacheability.NoCache)
        'i remove the old no cache

        Dim DateIn As Date = userClass.get_sql_time
        Session("RndNum") = main_funct.insertUserToCamera(Session("UserNum"), Session("GirlNum"))

        If Session("RndNum").ToString() = "99" Or Session("RndNum").ToString() = "98" Then
            populateClassFromDB.addWindowsServiceLogs(Session("GirlNum"), Session("UserNum"), Session("RndNum").ToString(), "user/in_camera.aspx-RndNum=" & Session("RndNum").ToString() & "", 1)
            Session("login") = 1
            Response.Redirect("/users/performersList.aspx?Reason=" & Session("RndNum").ToString())
            Response.End()
        End If

        Call main_funct.SaveUserComputer(Session("UserNum"), Session("GirlNum"), Session("RndNum"))
        Session("login") = 3
        Session("time_balance") = main_funct.sumUserTime(Session("UserNum"))
        populateClassFromDB.addWindowsServiceLogs(Trim(Request("GirlNum")), Session("UserNum"), "0", "insert camera 94", 0)
        Response.Redirect("/chat/user.aspx?GirlNum=" & Request("GirlNum") & "&ver=1")
        Response.End()
    End Sub
</script>
