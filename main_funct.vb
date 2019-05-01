Imports System
Imports System.Collections
Imports System.Data
Imports System.Data.SqlClient
Imports System.IO
Imports System.Web
Imports Microsoft.VisualBasic
Public Class main_funct

	Public Shared Function hebrew_date_and_time(ByVal intext As Date) As String
		Dim newdate = Day(intext) & "/" & Month(intext) & "/" & Year(intext)
		hebrew_date_and_time = newdate & "&nbsp;" & CStr(CDate(intext).ToLongTimeString)
	End Function
	Public Shared Function insertUserToCamera(ByVal UserNum As Integer, ByVal GirlNum As Integer) As Guid
		Using con = databaseCon.create_sql_con
			Dim cmd As New SqlCommand("insertUserToCameraEntity", con)
			cmd.CommandType = CommandType.StoredProcedure
			cmd.Parameters.Add("@UserNum", SqlDbType.Int).Value = UserNum
			cmd.Parameters.Add("@GirlNum", SqlDbType.Int).Value = GirlNum
			insertUserToCamera = cmd.ExecuteScalar
		End Using
	End Function

	Public Shared Sub SaveUserComputer(ByVal UserNum As Integer, ByVal GirlNum As Integer, ByVal fatal As Guid)
		Using con = databaseCon.create_sql_con
			Dim cmd As New SqlCommand("INSERT INTO userComputer (UserNum,os,fatal,GirlNum,ip,userAgent,domain,browser) VALUES(@UserNum,@os,@fatal,@GirlNum,@ip,@userAgent,@domain,@browser)", con)
			cmd.Parameters.Add("@UserNum", SqlDbType.Int).Value = UserNum
			cmd.Parameters.Add("@GirlNum", SqlDbType.Int).Value = GirlNum
			cmd.Parameters.Add("@os", SqlDbType.VarChar, 50).Value = HttpContext.Current.Request.Browser.Platform
			cmd.Parameters.Add("@ip", SqlDbType.VarChar, 15).Value = userClass.extractUserIp()
			cmd.Parameters.Add("@browser", SqlDbType.VarChar, 100).Value = HttpContext.Current.Request.Browser.Type & "-" & HttpContext.Current.Request.Browser.Version
			cmd.Parameters.Add("@userAgent", SqlDbType.VarChar, 500).Value = If(HttpContext.Current.Request.UserAgent, "blocked")
			cmd.Parameters.Add("@domain", SqlDbType.VarChar, 100).Value = HttpContext.Current.Request.ServerVariables("SERVER_NAME")
			cmd.Parameters.Add("@fatal", SqlDbType.UniqueIdentifier).Value = fatal
			cmd.ExecuteNonQuery()
		End Using
	End Sub

	Public Shared Function SendMessage(ByVal intext As Integer) As String
		Select Case intext
			Case 0
				SendMessage = Resources.Resources.Chat
			Case 1
				SendMessage = Resources.Resources.Message
			Case 2
				SendMessage = Resources.Resources.Game
			Case 3
				SendMessage = Resources.Resources.Tip
			Case Else
				SendMessage = ""
		End Select
	End Function
	Public Shared Function ShowIfPrivate(ByVal intext As Integer) As String
		If intext = 0 Then
			ShowIfPrivate = Resources.Resources.Regular
		Else
			ShowIfPrivate = Resources.Resources.BehindScenes
		End If
	End Function
	Public Shared Function ShowFullCharge(ByVal intext As Integer) As String
		ShowFullCharge = Resources.Resources.Regular
		If intext = 0 Then
			ShowFullCharge = Resources.Resources.Regular
		ElseIf intext = 1 Then
			ShowFullCharge = "קיצור של 10 שניות"
		ElseIf intext = 2 Then
			ShowFullCharge = Resources.Resources.FullRefund
		End If
	End Function
	Public Shared Function ShowEmptyImages(ByVal intext As String, ByVal lng As String) As String
		If intext = "0" Then
			ShowEmptyImages = "/app_themes/login." & lng & "/img/no-image-male.png"
		Else
			ShowEmptyImages = "/media/users/photo/" & intext
		End If
	End Function

	Public Shared Function checkIfBlockIp(ByVal ip As String) As String
		Using con = databaseCon.create_sql_con
			Dim cmd As New SqlCommand("checkIfBlockIp", con)
			cmd.CommandType = CommandType.StoredProcedure
			cmd.Parameters.Add("@IpAddress", SqlDbType.VarChar, 15).Value = ip
			checkIfBlockIp = cmd.ExecuteScalar
		End Using
	End Function





	Public Shared Function computeGirlsVacationParam(ByVal basicSalary As Integer) As Integer
		computeGirlsVacationParam = basicSalary * 0.04
	End Function
	Public Shared Function computeGirlsCompensationParam(ByVal basicSalary As Integer) As Integer
		computeGirlsCompensationParam = basicSalary * 0.08333
	End Function
	Public Shared Function computeGirlsPensionParam(ByVal basicSalary As Integer) As Integer
		computeGirlsPensionParam = basicSalary * 0.05
	End Function
	Public Shared Function computeGirlsSocialParam(ByVal min As Integer) As Integer
		If min <= 2000 Then
			computeGirlsSocialParam = min * 0.017
		ElseIf min > 2000 And min <= 4000 Then
			computeGirlsSocialParam = 34 + (min - 2000) * 0.0202
		ElseIf min > 4000 And min <= 6000 Then
			computeGirlsSocialParam = 74 + (min - 4000) * 0.0234
		ElseIf min > 6000 Then
			computeGirlsSocialParam = 121 + (min - 6000) * 0.026
		End If
	End Function

	Public Shared Function computeGirlsBasicSalary(ByVal min As Integer) As Integer
		If min <= 2000 Then
			computeGirlsBasicSalary = min * 2
		ElseIf min > 2000 And min <= 4000 Then
			computeGirlsBasicSalary = 4000 + (min - 2000) * 2.4
		ElseIf min > 4000 And min <= 6000 Then
			computeGirlsBasicSalary = 8800 + (min - 4000) * 2.8
		ElseIf min > 6000 Then
			computeGirlsBasicSalary = 14400 + (min - 6000) * 3.1
		End If
	End Function

	Public Shared Function computer(ByVal intext As Integer) As Integer
		If intext <= 2000 Then
			computer = intext * 2
		ElseIf intext > 2000 And intext <= 4000 Then
			computer = 4000 + (intext - 2000) * 2.4
		ElseIf intext > 4000 And intext <= 6000 Then
			computer = 8800 + (intext - 4000) * 2.8
		ElseIf intext > 6000 Then
			computer = 14400 + (intext - 6000) * 3.1
		End If
	End Function

	Public Shared Function sumUserTime(ByVal UserNum As Integer) As Integer 'create 04/01/2010
		Using con = create_sql_con()
			Dim cmd As New SqlCommand("sumUserTime", con)
			cmd.CommandType = CommandType.StoredProcedure
			cmd.Parameters.AddWithValue("@UserNum", UserNum)
			sumUserTime = cmd.ExecuteScalar()
		End Using
	End Function
	Public Shared Function sumUserTimeWithNoLock(ByVal UserNum As Integer) As Integer 'create 17/10/2014
		Using con = create_sql_con()
			Dim cmd As New SqlCommand("sumUserTime", con)
			cmd.CommandType = CommandType.StoredProcedure
			cmd.Parameters.AddWithValue("@UserNum", UserNum)
			sumUserTimeWithNoLock = cmd.ExecuteScalar()
		End Using
	End Function
	Public Shared Function time_amount(ByVal date1 As Date, ByVal date2 As Date, ByVal GirlNum As Int32, ByVal q_type As Int16) As String
		Using con = create_sql_con()
			Dim cmd As New SqlCommand("sp_stats_net", con)
			cmd.CommandType = CommandType.StoredProcedure
			cmd.Parameters.AddWithValue("@date1", date1)
			cmd.Parameters.AddWithValue("@date2", date2)
			cmd.Parameters.AddWithValue("@GirlNum", GirlNum)
			cmd.Parameters.AddWithValue("@q_type", q_type)
			time_amount = cmd.ExecuteScalar
		End Using
	End Function

	Public Shared Function check_user_time_buy(ByVal UserNum As Integer) As Integer
		Using con = create_sql_con()
			Dim myCommand As New SqlCommand("select(case when sum(TimeExpire) is null then 0 else sum(TimeExpire)   end)as TimeExpire from CardCam where UserNum=@UserNum", con)
			myCommand.Parameters.AddWithValue("@UserNum", UserNum)
			check_user_time_buy = myCommand.ExecuteScalar * 60
		End Using
	End Function

	Public Shared Function user_time_spend(ByVal UserNum As Integer, ByVal q_type As Int16) As Integer
		Using con = create_sql_con()
			Dim cmd As New SqlCommand("sumUserTimeUse", con)
			cmd.CommandType = CommandType.StoredProcedure
			cmd.Parameters.AddWithValue("@UserNum", UserNum)
			user_time_spend = cmd.ExecuteScalar()
		End Using
	End Function

	Public Shared Function show_if_private(ByVal intext As Integer) As String
		If intext = 0 Then
			show_if_private = "רגיל"
		Else
			show_if_private = "מאחורי הקלעים"
		End If
	End Function
	Public Shared Function sessionType(ByVal intext As Integer) As String
		If intext = 0 Then
			sessionType = "רגיל"
		ElseIf intext = 2 Then
			sessionType = "הודעה"
		ElseIf intext = 3 Then
			sessionType = "טיפ"
		End If
	End Function

	Public Shared Function send_sms(ByVal message As String, ByVal phone_num As String, ByVal is_unicode As Int16) As String
		Dim mystring As String
		If is_unicode = 1 Then
			mystring = "http://api.clickatell.com/http/sendmsg?api_id=3147762&user=tshai&password=abc123&to=972" & Right(phone_num, 9) & "&text=" & main_funct.create_unicode(message) & "&unicode=1"
		Else
			mystring = "http://api.clickatell.com/http/sendmsg?api_id=3147762&user=tshai&password=abc123&to=972" & Right(phone_num, 9) & "&text=" & message & ""
		End If
		Dim uri As New Uri(mystring)
		Dim request1 As HttpWebRequest = HttpWebRequest.Create(uri)
		request1.ContentType = "application/x-www-form-urlencoded"
		request1.Method = WebRequestMethods.Http.Get
		Dim response1 As HttpWebResponse = request1.GetResponse()
		Dim reader As New StreamReader(response1.GetResponseStream())
		Dim tmp As String = reader.ReadToEnd()
		response1.Close()
		send_sms = tmp
	End Function

	Public Shared Function create_unicode(ByVal intext As String) As String
		intext = Replace(intext, "א", "05D0")
		intext = Replace(intext, "ב", "05D1")
		intext = Replace(intext, "ג", "05D2")
		intext = Replace(intext, "ד", "05D3")
		intext = Replace(intext, "ה", "05D4")
		intext = Replace(intext, "ו", "05D5")
		intext = Replace(intext, "ז", "05D6")
		intext = Replace(intext, "ח", "05D7")
		intext = Replace(intext, "ט", "05D8")
		intext = Replace(intext, "י", "05D9")
		intext = Replace(intext, "כ", "05DB")
		intext = Replace(intext, "ל", "05DC")
		intext = Replace(intext, "מ", "05DE")
		intext = Replace(intext, "נ", "05E0")

		intext = Replace(intext, "ס", "05E1")
		intext = Replace(intext, "ע", "05E2")
		intext = Replace(intext, "פ", "05E4")
		intext = Replace(intext, "צ", "05E6")
		intext = Replace(intext, "ק", "05E7")
		intext = Replace(intext, "ר", "05E8")
		intext = Replace(intext, "ש", "05E9")
		intext = Replace(intext, "ת", "05EA")

		intext = Replace(intext, "ף", "05E3")
		intext = Replace(intext, "ך", "05DA")
		intext = Replace(intext, "ץ", "05E5")
		intext = Replace(intext, "ם", "05DD")
		intext = Replace(intext, " ", "0020")
		intext = Replace(intext, "!", "0021")
		intext = Replace(intext, ",", "002C")
		intext = Replace(intext, ":", "003A")
		intext = Replace(intext, ".", "002E")
		intext = Replace(intext, "'", "0027")
		intext = Replace(intext, "?", "003F")
		create_unicode = Replace(intext, "ן", "05DF")
	End Function

	Public Shared Function create_sql_con() As SqlConnection
		Dim con As New SqlConnection(ConfigurationManager.ConnectionStrings("cam").ConnectionString)
		con.Open()
		create_sql_con = con
	End Function

	Public Shared Function change_id_to_UserNum(ByVal intext As Integer, ByVal UserNum As Integer) As Integer
		If intext.ToString.Length < 5 Then
			change_id_to_UserNum = UserNum
		Else
			change_id_to_UserNum = intext
		End If
	End Function

	Public Shared Function RemoveLastLetter(ByVal intext As String) As String
		If String.IsNullOrEmpty(intext) Then
			intext = "0"
		End If
		RemoveLastLetter = Left(intext, intext.Length - 1)
	End Function

	Public Shared Function HebrewDate(ByVal intext)
		HebrewDate = Day(intext) & "/" & Month(intext) & "/" & Year(intext)
	End Function
	Public Shared Function GetEverageConvThisMonth(ByVal GirlNum As Integer) As Integer
		GetEverageConvThisMonth = 0
		Using con = databaseCon.create_sql_con
			Dim cmd As New SqlCommand("admin1", con)
			cmd.CommandType = CommandType.StoredProcedure
			cmd.Parameters.Add("@q_type", SqlDbType.Int).Value = 48
			cmd.Parameters.Add("@GirlNum", SqlDbType.VarChar).Value = GirlNum
			Dim dr As SqlDataReader = cmd.ExecuteReader
			Do While dr.Read
				GetEverageConvThisMonth = Math.Floor(dr("TimeUse1"))
			Loop
		End Using
	End Function
	Public Shared Function GetEverageConvLastMonth(ByVal GirlNum As Integer) As Integer
		GetEverageConvLastMonth = 0
		Using con = databaseCon.create_sql_con
			Dim cmd As New SqlCommand("admin1", con)
			cmd.CommandType = CommandType.StoredProcedure
			cmd.Parameters.Add("@q_type", SqlDbType.Int).Value = 49
			cmd.Parameters.Add("@GirlNum", SqlDbType.VarChar).Value = GirlNum
			Dim dr As SqlDataReader = cmd.ExecuteReader
			Do While dr.Read
				GetEverageConvLastMonth = Math.Floor(dr("TimeUse1"))
			Loop
		End Using
	End Function
	Public Shared Sub addMinToUser(UserNum As Integer, TimeExpire As Integer)
		Using con = databaseCon.create_sql_con
			Dim myCommand As New SqlCommand("insert into CardCam (price,SiteName,IpAddress,lastdigits,SubSite,TimeExpire,UserNum)values(@price,@site,@remote_addr,@lastdigits,@SubSite,@TimeExpire,@UserNum)", con)
			myCommand.Parameters.AddWithValue("@price", 0)
			myCommand.Parameters.AddWithValue("@site", "inside")
			myCommand.Parameters.AddWithValue("@remote_addr", "admin")
			myCommand.Parameters.AddWithValue("@lastdigits", "0000")
			myCommand.Parameters.AddWithValue("@SubSite", "admin")
			myCommand.Parameters.AddWithValue("@TimeExpire", TimeExpire)
			myCommand.Parameters.AddWithValue("@UserNum", UserNum)
			myCommand.ExecuteNonQuery()
		End Using
	End Sub
	Public Shared Sub sendMessaageToUser(UserNum As Integer, message As String)
		Using con = databaseCon.create_sql_con
			Dim myCommand As New SqlCommand("insert into messages(message,UserNum,GirlNum,who_send,mustRead)values(@my_test,@UserNum,@GirlNum,@who_send,1)", con)
			myCommand.Parameters.Add("@my_test", SqlDbType.NVarChar, 1000).Value = HttpContext.Current.Server.HtmlEncode(message.Trim)
			myCommand.Parameters.Add("@UserNum", SqlDbType.Int).Value = UserNum
			myCommand.Parameters.Add("@who_send", SqlDbType.Int).Value = 1
			myCommand.Parameters.Add("@GirlNum", SqlDbType.Int).Value = 0
			myCommand.ExecuteNonQuery()
		End Using
	End Sub

	Public Shared Sub sendEmail(UserNum As Integer, message As String, Subject As String)
		Using con = databaseCon.create_sql_con
			Dim cmd As New SqlCommand("select email from UserDetails where UserNum=" & UserNum & " ", con)
			Dim dr As SqlDataReader = cmd.ExecuteReader
			If dr.Read Then
				Dim user_mail = dr("email")
				If user_mail <> "0" Then
					Dim mymail As New System.Net.Mail.MailMessage("mail@nifgashot", user_mail)
					Dim messageTitle As String = Subject
					Dim messageUrl As String = "http://www.nifgashot"
					Dim messageUrlText As String = "נפגשותמצלמות "
					Dim messageUrlTextSpecial As String = "לחץ כאן לכניסה לאתר"
					Dim sb As New StringBuilder()
					sb.Append("<div style=""border:1px solid #ddd;font-family:Arial;font-size:12px;direction:rtl;text-align:right;width:604px;"">")
					sb.AppendFormat("<div style=""background-color:#eee;border:1px solid #ddd;font-size:1.4em;font-weight:bold;height:30px;line-height:30px;margin:1px;text-indent:20px;width:600px;"">{0}</div>", messageTitle)
					sb.Append("<div style=""background-color:#fff;border:1px solid #ddd;font-size:1em;margin:1px;overflow:hidden;padding:10px;width:580px;"">")
					sb.AppendFormat("<p>{0}</p>", HttpContext.Current.Server.HtmlEncode(message.Trim))
					sb.AppendFormat("<a style=""background-color:#900;border:1px solid #000;color:#fff;display:block;font-size:1.1em;font-weight:bold;height:30px;line-height:30px;text-decoration:none;text-align:center;width:150px;"" href=""{0}"">{1}</a>", messageUrl, messageUrlTextSpecial)
					sb.Append("</div>")
					sb.AppendFormat("<div style=""background-color:#eee;border:1px solid #ddd;font-size:0.9em;font-weight:bold;height:20px;line-height:20px;margin:1px;text-indent:20px;width:600px;"">{0} &copy; <a href=""{1}"">{2}</a></div>", Date.Now.Year, messageUrl, messageUrlText)
					sb.Append("</div>")

					mymail.Body = sb.ToString()
					mymail.Subject = Subject
					mymail.IsBodyHtml = True
					Dim mysmtp As New System.Net.Mail.SmtpClient(ConfigurationManager.AppSettings("smtp"))
					mysmtp.Send(mymail)
				End If
			End If
		End Using
	End Sub
End Class






