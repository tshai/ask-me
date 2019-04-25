<%@ Page Language="C#" ValidateRequest="false" EnableEventValidation="false" %>

<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="Newtonsoft.Json" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Data.Entity.SqlServer" %>
<%@ Import Namespace="System.Data.Entity" %>
<%@ Import Namespace="Entities" %>
<script runat="server">
            public partial class ActiveModel
            {
                public int Active { get; set; }
                public int AdminApprovedAccount { get; set; }
            }

            public partial class GirlMessages
            {
                public int UserNum { get; set; }
                public string NewestMessage { get; set; }
                public string Date { get; set; }
                public int IsReaded { get; set; }
                public int MessageID { get; set; }
                public int WhoSend { get; set; }
                public string Photo { get; set; }
            }
            public partial class GirlMessagesToUser
            {
                public string Message { get; set; }
                public string DateIn { get; set; }
                public int SendUserID { get; set; }
                public int GetUserID { get; set; }
                public int MessageRead { get; set; }
                public int SendUserDelete { get; set; }
                public int GetUserDelete { get; set; }
                public int SenderDeleteForAll { get; set; }
                public int MessageType { get; set; }
                public string VideoImage { get; set; }
                public bool IsSavedInServer { get; set; }
                public string MessageGuid { get; set; }
            }

            public partial class GirlProfile
            {
                public string Name { get; set; }
                public string YearOfBirth { get; set; }
                public string Gender { get; set; }
                public string AditionalInfo { get; set; }
                public string PaymentMethod { get; set; }
                public string PayPerMinute { get; set; }
                public string Curency { get; set; }
                public string City { get; set; }
                public string Pic1 { get; set; }
                public int GirlNum { get; set; }
                public string GeneratedNumber { get; set; }
            }

            public partial class GirlBankAccount
            {
                public string TotalMinutes { get; set; }
                public string TotalPrice { get; set; }
                public string Currency { get; set; }
            }

            public partial class GirlChat
            {
                public string UserNum { get; set; }
                public string TimeIn { get; set; }
                public string ChatType { get; set; }
                public string Seconds { get; set; }
            }

            public partial class ContactListUser
            {
                public int GirlNum { get; set; }
                public string Name { get; set; }
                public string Pic1 { get; set; }
                public string GeneratedNumber { get; set; }
                public string City { get; set; }
            }

            public partial class ServerSetting
            {
                public string Url { get; set; }
                public string UserName { get; set; }
                public string Credential { get; set; }
            }

            public partial class VideoSettings
            {
                public ServerSetting Google { get; set; }
                public ServerSetting Udp { get; set; }
                public ServerSetting Tcp { get; set; }
                public int VideoResolutionWidth { get; set; }
                public int VideoResolutionHeight { get; set; }
                public int FramePerSecond { get; set; }
            }

            public partial class UserChatTimeUse
            {
                public int TimeUse { get; set; }
                public string DateIn { get; set; }
                public string Dateout { get; set; }
                public int GetUserID { get; set; }
                public int SendUserID { get; set; }
                public bool IsAnswer { get; set; }
            }

            public Users user;
            public Guid MainModelGuid;
            public int ToGirlNum;
            protected void Page_Load(object sender, EventArgs e)
            {
                //requestt
                Response.Expires = 0;
                Response.AddHeader("pragma", "no-cache");
                Response.AddHeader("cache-control", "private");
                Response.CacheControl = ("no-cache");

                if (Request["MainModelGuid"] != null)
                {
                    using (var db = new Entities())
                    {
                        MainModelGuid = Guid.Parse(Request["MainModelGuid"].ToString());
                        user = (from a in db.Users where a.MainModelGuid == MainModelGuid select a).FirstOrDefault();
                    }
                }

                //var cache = new MemoryCache("CacheName");

                //cache.Add(key, value, new CacheItemPolicy()
                //{ AbsoluteExpiration = DateTime.UtcNow.AddSeconds(20) });

                if (Request["qType"] == "1") //check if girl has registration
                {
                    using (var db = new Entities())
                    {
                        var phone = Request["phone"];
                        var password = Request["password"];
                        var hasRegistration = from a in db.Users where a.Phone == phone && a.Password == password select a;

                        if (!hasRegistration.Any())
                        {
                            Response.Write("0");
                        }
                        else
                        {
                            Response.Write(hasRegistration.FirstOrDefault().MainModelGuid);
                        }
                        Response.End();
                    }
                }

                //else if (Request["qType"] == "3") //check if girl activate and approved
                //{
                //	using (var con = databaseCon.create_sql_con())
                //	{
                //		var activeModel = new ActiveModel();
                //		//var MainModelGuid = Request["MainModelGuid"];
                //		var cmd = new SqlCommand("select active, adminApprovedCard from MainModels where MainModelGuid=@MainModelGuid", con);
                //		cmd.Parameters.Add("@MainModelGuid", SqlDbType.UniqueIdentifier).Value = MainModelGuid;
                //		var dr = cmd.ExecuteReader();
                //		while (dr.Read())
                //		{
                //			activeModel.Active = int.Parse(dr["active"].ToString());
                //			activeModel.AdminApprovedAccount = int.Parse(dr["adminApprovedCard"].ToString());
                //		}
                //		Response.Write(JsonConvert.SerializeObject(activeModel, Formatting.Indented));
                //	}
                //}
                else if (Request["qType"] == "4") // hang up call
                {
                    databaseCon.ExecuteNonQuerySql("update onlineUsers set ID=1,Online=2,RndNumber='" + Guid.NewGuid() + "' where GetUserID=" + user.ID);
                    //databaseCon.ExecuteNonQuerySql("update ChatTimeUse set TimeUse=0,TheChatWasActive=2 where SessionStatus=1 and TheChatWasActive=0 and datediff(second,DateIn,dateout)>29");
                    Response.Write("true");
                    Response.End();
                }
                else if (Request["qType"] == "5") // log in db errors
                {
                    try
                    {
                        var errorText = Request["text"];
                        errors.addErrorString(Server.HtmlEncode(errorText));
                    }
                    catch (Exception ex)
                    {
                        Response.Write(ex.Message);
                    }
                }
                else if (Request["qType"] == "6") // change girl status
                {
                    //var MainModelGuid = Guid.Parse(Request["MainModelGuid"].ToString());
                    var status = Request["status"];
                    var statusAsInteger = 0;
                    var onlineUser = new OnlineUsers();

                    using (var db = new Entities())
                    {
                        onlineUser = user.OnlineUsers;
                        //Session["GirlNum_worker"] = onlineUser.GirlNum;
                    }

                    switch (status)
                    {
                        case "Online":
                            statusAsInteger = 2;
                            break;

                        case "Offline":
                            statusAsInteger = 0;
                            break;
                        default:
                            break;
                    }

                    using (var db = new Entities())
                    {
                        onlineUser.Online = statusAsInteger;
                        onlineUser.RndNumber = Guid.NewGuid();
                        onlineUser.SendUserID = 1;
                        db.Entry(onlineUser).State = System.Data.Entity.EntityState.Modified;
                        db.SaveChanges();
                    }
                    Response.Write(statusAsInteger);
                    Response.End();
                }

                else if (Request["qType"] == "7") // check girl status
                {
                    using (var con = databaseCon.create_sql_con())
                    {
                        var cmd = new SqlCommand("select Online from OnlineUsers inner join Users on OnlineUsers.GetUserID=Users.ID where MainModelGuid=@MainModelGuid", con);
                        cmd.Parameters.Add("@MainModelGuid", SqlDbType.UniqueIdentifier).Value = MainModelGuid;
                        var result = cmd.ExecuteScalar();
                        Response.Write(result);
                        Response.End();
                    }
                }
                else if (Request["qType"] == "8") // get users messages
                {
                    //var MainModelGuid = Request["MainModelGuid"];
                    //var GirlNum = 0;
                    //using (var con = databaseCon.create_sql_con())
                    //{
                    //    var cmd = new SqlCommand("select GirlNum from MainModels where MainModelGuid=@MainModelGuid", con);
                    //    cmd.Parameters.Add("@MainModelGuid", SqlDbType.UniqueIdentifier).Value = MainModelGuid;
                    //    GirlNum = int.Parse(cmd.ExecuteScalar().ToString());
                    //}
                    using (var con = databaseCon.create_sql_con())
                    {
                        var girlMessages = new List<GirlMessages>();
                        var cmd = new SqlCommand("select ID, max(message_id) as messageId from [messages] where GirlNum=@GirlNum and girl_delete=0 and who_send=0 group by  ID order by max(message_id) desc", con);
                        cmd.Parameters.Add("@GirlNum", SqlDbType.Int).Value = user.ID;
                        var reader = cmd.ExecuteReader();
                        while (reader.Read())
                        {
                            var girlMessage = new GirlMessages();
                            girlMessage.UserNum = int.Parse(reader["ID"].ToString());
                            girlMessage.MessageID = int.Parse(reader["messageId"].ToString());
                            girlMessage.NewestMessage = getMessageTextFromId(int.Parse(reader["messageId"].ToString()));
                            girlMessage.IsReaded = getMessageIsReadFromId(int.Parse(reader["messageId"].ToString()));
                            girlMessage.Date = getMessageDateFromId(int.Parse(reader["messageId"].ToString()));
                            girlMessage.WhoSend = getMessageWhoSendFromId(int.Parse(reader["messageId"].ToString()));
                            girlMessage.Photo = getUserPhotoFromNum(int.Parse(reader["ID"].ToString()));
                            girlMessages.Add(girlMessage);
                        }
                        Response.Write(JsonConvert.SerializeObject(girlMessages, Formatting.Indented));
                        Response.End();
                    }
                }
                //else if (Request["qType"] == "9") // get single user messages
                //{
                //    //var girl = SupplierAPI.getMainModelsByGuid(Guid.Parse(Request["MainModelGuid"]));
                //    var userNum = int.Parse(Request["userNum"]);
                //    using (var con = databaseCon.create_sql_con())
                //    {
                //        var cmd = new SqlCommand("select * from messages where GirlNum=@GirlNum and girl_delete=0 and UserNum=@UserNum order by DateIn", con);
                //        cmd.Parameters.Add("@GirlNum", SqlDbType.Int).Value = user.UserNum;
                //        cmd.Parameters.Add("@UserNum", SqlDbType.Int).Value = userNum;
                //        var reader = cmd.ExecuteReader();
                //        var girlMessages = new List<GirlMessagesToUser>();
                //        while (reader.Read())
                //        {
                //            var girlMessage = new GirlMessagesToUser();
                //            girlMessage.UserNum = int.Parse(reader["UserNum"].ToString());
                //            if (DateTime.Parse(reader["DateIn"].ToString()).Date == DateTime.Now.Date)
                //            {
                //                girlMessage.Date = DateTime.Parse(reader["DateIn"].ToString()).ToString("HH:mm");
                //            }
                //            else
                //            {
                //                girlMessage.Date = DateTime.Parse(reader["DateIn"].ToString()).Day + "/" + DateTime.Parse(reader["DateIn"].ToString()).Month + "/" + DateTime.Parse(reader["DateIn"].ToString()).Year;
                //            }
                //            girlMessage.Message = Server.HtmlDecode(reader["message"].ToString());
                //            girlMessage.WhoSend = int.Parse(reader["who_send"].ToString());
                //            girlMessage.MessageID = int.Parse(reader["message_id"].ToString());
                //            girlMessage.MessageType = int.Parse(reader["messageType"].ToString());
                //            if (reader["videoImage"] != null)
                //            {
                //                girlMessage.ImageVideo = reader["videoImage"].ToString();
                //            }
                //            girlMessages.Add(girlMessage);
                //        }
                //        Response.Write(JsonConvert.SerializeObject(girlMessages, Formatting.Indented));
                //        Response.End();
                //    }
                //}
                else if (Request["qType"] == "10") // send user a message
                {
                    var UserNum = int.Parse(Request["UserNum"]); //to
                    var message = Request["message"];
                    var type = byte.Parse(Request["messageType"]);
                    var messageGuid = Request["messageGuid"];

                    using (var db = new Entities())
                    {
                        var userMessage = new UsersToUsersMessages
                        {
                            DateIn = DateTime.Now,
                            GetUserDelete = 0,
                            GetUserID = UserNum,
                            MessageRead = 0,
                            MessageText = message,
                            MessageType = type,
                            MustRead = 0,
                            SenderDeleteForAll = 0,
                            SendUserDelete = 0,
                            SendUserID = user.ID,
                            MessageGuid = messageGuid
                        };
                        db.UsersToUsersMessages.Add(userMessage);
                        db.SaveChanges();
                    }
                    try
                    {
                        inChat.SendNotification(SupplierAPI.getMainModelsByNum(UserNum).MainModelGuid.ToString(), "message");
                    }
                    catch (Exception ex)
                    {
                        errors.insertErrors(ex);
                    }

                    Response.End();
                }
                else if (Request["qType"] == "11") // mark messages as read/unread
                {
                    var UserNum = int.Parse(Request["UserNum"]);
                    if (Request["markAsUnread"] != null)
                    {
                        using (var con = databaseCon.create_sql_con())
                        {
                            var command = new SqlCommand("update TOP (1) UsersToUsersMessages set MessageRead=0 where SendUserID=" + UserNum + " and GetUserID=" + user.ID + " and GetUserDelete=0 and SenderDeleteForAll=0 and ID in(select top(1) ID from UsersToUsersMessages where SendUserID=" + UserNum + " and GetUserID=" + user.ID + " and GetUserDelete=0 and SenderDeleteForAll=0 order by ID desc)", con);
                            command.ExecuteNonQuery();
                        }
                    }
                    using (var con = databaseCon.create_sql_con())
                    {
                        var command = new SqlCommand("update UsersToUsersMessages set MessageRead=1 where SendUserID=" + UserNum + " and GetUserID=" + user.ID + " and GetUserDelete=0 and SenderDeleteForAll=0", con);
                        command.ExecuteNonQuery();
                    }
                }

                else if (Request["qType"] == "13") //girl delete conversation
                {
                    var UserNum = int.Parse(Request["UserNum"]);
                    using (var con = databaseCon.create_sql_con())
                    {
                        var cmd = new SqlCommand("update UsersToUsersMessages set SendUserDelete=1 where (SendUserID=@GirlNum and GetUserID=@UserNum)", con);
                        cmd.Parameters.Add("@UserNum", SqlDbType.Int).Value = UserNum;
                        cmd.Parameters.Add("@GirlNum", SqlDbType.Int).Value = user.ID;
                        cmd.ExecuteNonQuery();
                    }
                    using (var con = databaseCon.create_sql_con())
                    {
                        var cmd = new SqlCommand("update UsersToUsersMessages set GetUserDelete=1 where (GetUserID=@GirlNum and SendUserID=@UserNum)", con);
                        cmd.Parameters.Add("@UserNum", SqlDbType.Int).Value = UserNum;
                        cmd.Parameters.Add("@GirlNum", SqlDbType.Int).Value = user.ID;
                        cmd.ExecuteNonQuery();
                    }
                }
                else if (Request["qType"] == "12") // check if new message
                {
                    using (var con = databaseCon.create_sql_con())
                    {
                        var cmd = new SqlCommand("select top(1) * from UsersToUsersMessages where GetUserID=@GirlNum and MessageRead=0 and SenderDeleteForAll=0 order by DateIn desc", con);
                        cmd.Parameters.Add("@GirlNum", SqlDbType.Int).Value = user.ID;
                        var reader = cmd.ExecuteReader();
                        if (!reader.HasRows)
                        {
                            Response.Write("no new messages");
                            Response.End();
                        }
                        var girlMessages = new List<GirlMessagesToUser>();
                        while (reader.Read())
                        {
                            var girlMessage = new GirlMessagesToUser();
                            girlMessage.DateIn = DateTime.Parse(reader["DateIn"].ToString()).ToString("yyyy/MM/dd HH:mm:ss");
                            girlMessage.GetUserDelete = int.Parse(reader["GetUserDelete"].ToString());
                            girlMessage.GetUserID = int.Parse(reader["GetUserID"].ToString());
                            girlMessage.IsSavedInServer = true;
                            girlMessage.Message = reader["MessageText"].ToString();
                            girlMessage.MessageRead = int.Parse(reader["MessageRead"].ToString());
                            girlMessage.MessageType = int.Parse(reader["MessageType"].ToString());
                            girlMessage.SenderDeleteForAll = int.Parse(reader["SenderDeleteForAll"].ToString());
                            girlMessage.SendUserDelete = int.Parse(reader["SendUserDelete"].ToString());
                            girlMessage.SendUserID = int.Parse(reader["SendUserID"].ToString());
                            girlMessage.VideoImage = reader["videoImage"].ToString();
                            girlMessage.MessageGuid = reader["MessageGuid"].ToString();
                            girlMessages.Add(girlMessage);
                        }
                        Response.Write(JsonConvert.SerializeObject(girlMessages, Formatting.Indented));
                        Response.End();
                    }
                }

                else if (Request["qType"] == "16") // log out from the app
                {
                    //var GirlNum = 0;
                    databaseCon.ExecuteNonQuerySql("update OnlineUsers set Online=0 where GetUserID=(select top 1 ID from Users where MainModelGuid='" + MainModelGuid + "')");
                }
                else if (Request["qType"] == "17") // send sms
                {
                    var phone = Request["phone"];
                    string Answer = Tools.twiloSms(phone, Request["body"]);
                    databaseCon.ExecuteNonQuerySql("INSERT INTO SMSLogs (PhoneNumber,Answer,Processor)VALUES('" + phone + "', '" + Answer + "' ,'twilio')");
                    Response.End();

                }
                else if (Request["qType"] == "18") //get Supplier app version
                {
                    using (var db = new Entities())
                    {
                        Setting s = (from a in db.Setting select a).First();
                        if (s.UserAppVersion == "0")
                        {
                            Response.Write("0");
                        }
                        else
                        {
                            Response.Write(s.UserAppVersion);
                        }
                    }
                    Response.End();
                }
                else if (Request["qType"] == "19") //add new Supplier 
                {
                    Response.Write(SupplierAPI.AddNewSupplier(Request["Phone"], Request["CountryCode"]));
                    Response.End();
                }
                else if (Request["qType"] == "20") //validate password sent by sms
                {
                    Response.Write(SupplierAPI.ValidateSMSPassword(Request["Phone"], Request["CountryCode"], int.Parse(Request["SMSCode"])));
                    Response.End();
                }
                //else if (Request["qType"] == "17") // decline user call from app button
                //{
                //    using (SqlConnection con = databaseCon.create_sql_con())
                //    {
                //        {
                //            SqlCommand cmd = new SqlCommand("supplier", con);
                //            cmd.CommandType = CommandType.StoredProcedure;
                //            cmd.Parameters.Add("@MainModelGuid", SqlDbType.UniqueIdentifier).Value = Guid.Parse(Request["MainModelGuid"].ToString());

                //            cmd.Parameters.Add("@qType", SqlDbType.Int).Value = 1;

                //            cmd.ExecuteNonQuery();
                //        }
                //    }
                //    Response.Write("true");
                //    Response.End();
                //}

                else if (Request["qType"] == "21") //get profile info
                {
                    var girlProfile = new GirlProfile()
                    {
                        Name = checkIfNull(user.Name),
                        YearOfBirth = checkIfNull(user.YearBirth),
                        Gender = (int.Parse(checkIfNull(user.Gender)) - 1).ToString(),
                        AditionalInfo = checkIfNull(user.ExtraDetails),
                        Curency = (int.Parse(checkIfNull(user.CurrencyID)) - 1).ToString(),
                        PaymentMethod = checkIfNull(user.PaymentsInformation),
                        PayPerMinute = checkIfNull(user.PricePerMinute),
                        City = checkIfNull(user.City),
                        Pic1 = checkIfNull(user.Pic1),
                        GirlNum = user.ID,
                        GeneratedNumber = user.GenerateNumber
                    };

                    Response.Write(JsonConvert.SerializeObject(girlProfile, Formatting.Indented));
                    Response.End();
                }
                else if (Request["qType"] == "22") //upload profile image file
                {
                    //MainModels user = SupplierAPI.getMainModelsByGuid(Guid.Parse(Request["MainModelGuid"]));
                    string fileName = "";
                    foreach (string upload in Request.Files)
                    {
                        var path = AppDomain.CurrentDomain.BaseDirectory + "/media/Suppliers";
                        var file = Request.Files[upload];
                        if (file == null) continue;
                        fileName = Guid.NewGuid().ToString() + Path.GetExtension(file.FileName);
                        file.SaveAs(Path.Combine(path, fileName));
                    }
                    user.Pic1 = fileName;
                    using (var db = new Entities())
                    {
                        db.Entry(user).State = System.Data.Entity.EntityState.Modified;
                        db.SaveChanges();
                    }
                    Response.End();
                }
                else if (Request["qType"] == "23") //check if supplier add to onlineUsers table
                {
                    Response.Write(SupplierAPI.CheckIfSupplierActive(Guid.Parse(Request["MainModelGuid"])));
                    Response.End();
                }

                else if (Request["qType"] == "24") //update profile info
                {
                    //var MainModelGuid = Guid.Parse(Request["MainModelGuid"]);
                    //var mainModel = new MainModels();
                    using (var db = new Entities())
                    {
                        //mainModel = (from a in db.MainModels where a.MainModelGuid == MainModelGuid select a).FirstOrDefault();
                        user.Name = Request["Name"];
                        user.YearBirth = int.Parse(Request["YearOfBirth"]);
                        user.Gender = int.Parse(Request["Gender"]) + 1;
                        user.ExtraDetails = Request["AditionalInfo"];
                        user.PaymentsInformation = Request["PaymentMethod"];
                        user.PricePerMinute = 0;//double.Parse(Request["PayPerMinute"]);
                        user.CurrencyID = 1;// int.Parse(Request["Curency"]) + 1;
                        db.Entry(user).State = System.Data.Entity.EntityState.Modified;
                        db.SaveChanges();
                        Response.Write("ok");
                        Response.End();
                    }
                }

                else if (Request["qType"] == "25")  //get girl total salary for period
                {
                    //var girl = SupplierAPI.getMainModelsByGuid(Guid.Parse(Request["MainModelGuid"]));
                    var startDate = DateTime.Parse(Request["startDate"]);
                    var endDate = DateTime.Parse(Request["endDate"]);

                    var totalTime = 0.0;
                    var totalPrice = 0.0;

                    using (var con = databaseCon.create_sql_con())
                    {
                        var command = new SqlCommand("select TimeUse, PricePerMinute from ChatTimeUse where GetUserID=" + user.ID + " and DateIn>='" + startDate + "' and DateIn <=DATEADD(day,1, '" + endDate + "') and TimeUse>0", con);
                        var reader = command.ExecuteReader();

                        while (reader.Read())
                        {
                            totalTime += double.Parse(reader["TimeUse"].ToString());
                            totalPrice += double.Parse(reader["PricePerMinute"].ToString()) / 60 * double.Parse(reader["TimeUse"].ToString());
                        }

                        var girlBankAccount = new GirlBankAccount
                        {
                            TotalMinutes = Math.Round((totalTime / 60), 2).ToString("0.00"),
                            TotalPrice = Math.Round(totalPrice, 2).ToString("0.00"),
                            Currency = GetCurrencyByID(user.CurrencyID)
                        };

                        Response.Write(JsonConvert.SerializeObject(girlBankAccount, Formatting.Indented));
                        Response.End();
                    }
                }
                else if (Request["qType"] == "26")  //get girl chats for period
                {
                    //var girlNum = SupplierAPI.getMainModelsByGuid(Guid.Parse(Request["MainModelGuid"])).GirlNum;
                    var startDate = DateTime.Parse(Request["startDate"]);
                    var endDate = DateTime.Parse(Request["endDate"]);
                    var girlChats = new List<GirlChat>();
                    using (var con = databaseCon.create_sql_con())
                    {
                        var command = new SqlCommand("select TimeUse, DateIn, SendUserID, SendMessage from ChatTimeUse where GetUserID=" + user.ID + " and DateIn>='" + startDate + "' and DateIn <=DATEADD(day,1, '" + endDate + "') and TimeUse>0 order by ID desc", con);
                        var reader = command.ExecuteReader();

                        while (reader.Read())
                        {
                            var girlChat = new GirlChat
                            {
                                ChatType = reader["SendMessage"].ToString(),
                                Seconds = reader["TimeUse"].ToString(),
                                TimeIn = DateTime.Parse(reader["DateIn"].ToString()).ToString("MM/dd/yy"),
                                UserNum = reader["SendUserID"].ToString()
                            };
                            girlChats.Add(girlChat);
                        }
                    }
                    Response.Write(JsonConvert.SerializeObject(girlChats, Formatting.Indented));
                    Response.End();
                }
                else if (Request["qType"] == "27")  //set langitude and latitude
                {
                    //MainModels user = SupplierAPI.getMainModelsByGuid(Guid.Parse(Request["MainModelGuid"]));
                    user.Longitude = double.Parse(Request["Longitude"].ToString());
                    user.Latitude = double.Parse(Request["Latitude"].ToString());
                    user.City = SupplierAPI.ReverseGeocoding(Request["Longitude"].ToString(), Request["Latitude"].ToString());
                    using (var db = new Entities())
                    {
                        db.Entry(user).State = System.Data.Entity.EntityState.Modified;
                        db.SaveChanges();
                    }
                    try
                    {
                        //Response.Write("telavweeiv");
                        Response.Write(user.City);
                    }
                    catch (Exception ex)
                    {
                        errors.insertErrors(ex);
                        Response.Write("err");
                    }

                    // Response.Write(JsonConvert.SerializeObject(girlChats, Formatting.Indented));
                    Response.End();
                }
                else if (Request["qType"] == "28") //upload image from chat
                {
                    try
                    {
                        //var girlNum = SupplierAPI.getMainModelsByGuid(Guid.Parse(Request["MainModelGuid"])).GirlNum;
                        var userNum = int.Parse(Request["userNum"].ToString());
                        var messageType = Request["messageType"];
                        var messageGuid = Request["messageGuid"];

                        var fileName = "";
                        foreach (string upload in Request.Files)
                        {
                            var path = "";
                            if (messageType == "1")
                            {
                                path = AppDomain.CurrentDomain.BaseDirectory + "/media/appMessageChat";
                            }
                            else if (messageType == "2")
                            {
                                path = AppDomain.CurrentDomain.BaseDirectory + "/media/appMessageChat/videos";
                            }
                            else if (messageType == "3")
                            {
                                path = AppDomain.CurrentDomain.BaseDirectory + "/media/appMessageChat/audios";
                            }
                            else if (messageType == "4")
                            {
                                var message = new UsersToUsersMessages();
                                using (var db = new Entities())
                                {
                                    message = (from a in db.UsersToUsersMessages where a.GetUserID == userNum && a.SendUserID == user.ID && a.MessageGuid == messageGuid select a).FirstOrDefault();
                                }
                                path = AppDomain.CurrentDomain.BaseDirectory + "/media/appMessageChat/videos/images";
                                var fileImage = Request.Files[upload];
                                if (fileImage == null) continue;
                                fileName = Path.GetFileNameWithoutExtension(message.MessageText) + Path.GetExtension(fileImage.FileName);
                                fileImage.SaveAs(Path.Combine(path, fileName));
                                using (var db = new Entities())
                                {
                                    message.VideoImage = fileName;
                                    db.Entry(message).State = System.Data.Entity.EntityState.Modified;
                                    db.SaveChanges();
                                }
                                Response.End();
                            }
                            var file = Request.Files[upload];
                            if (file == null) continue;
                            fileName = Request["fileName"];
                            file.SaveAs(Path.Combine(path, fileName));
                        }
                        using (var db = new Entities())
                        {
                            var newMessage = new UsersToUsersMessages
                            {
                                DateIn = DateTime.Now,
                                GetUserDelete = 0,
                                GetUserID = userNum,
                                MessageRead = 0,
                                MessageText = fileName,
                                MessageType = byte.Parse(messageType),
                                MustRead = 0,
                                SenderDeleteForAll = 0,
                                SendUserDelete = 0,
                                SendUserID = user.ID,
                                MessageGuid = messageGuid
                            };
                            db.UsersToUsersMessages.Add(newMessage);
                            db.SaveChanges();
                            try
                            {
                                inChat.SendNotification(SupplierAPI.getMainModelsByNum(userNum).MainModelGuid.ToString(), "message");
                            }
                            catch (Exception ex)
                            {
                                errors.insertErrors(ex);
                            }
                            Response.Write(fileName);
                        }
                        Response.End();
                    }
                    catch (Exception ex)
                    {
                        Response.Write(ex.InnerException);
                        Response.Write(ex.Message);
                    }
                    Response.End();
                }
                else if (Request["qType"] == "29") //create user registration
                {
                    using (var db = new Entities())
                    {
                        if (Request["account"] == "user")
                        {
                            user.IsSupplier = 0;
                            user.Active = 1;
                            user.AdminApprovedCard = 1;
                        }
                        else if (Request["account"] == "consultant")
                        {
                            user.IsSupplier = 1;
                            user.Active = 0;
                            user.AdminApprovedCard = 0;
                        }
                        db.Entry(user).State = EntityState.Modified;
                        db.SaveChanges();

                        var onlineUser = new OnlineUsers
                        {
                            GetUserID = user.ID,
                            RndNumber = Guid.NewGuid(),
                            Lastvisit = DateTime.Now,
                            Ulastvisit = DateTime.Now,
                            LastStatusChange = DateTime.Now,
                            TimeTheChatStart = DateTime.Now,
                            SendUserID = 1
                        };
                        db.OnlineUsers.Add(onlineUser);
                        db.SaveChanges();
                    }
                }
                else if (Request["qType"] == "30") //list all contacts
                {
                    using (var db = new Entities())
                    {
                        var users = (from a in db.Users where a.ID != user.ID orderby a.Name select a).ToList();
                        var userContactList = new List<ContactListUser>();
                        for (int i = 0; i < users.Count(); i++)
                        {
                            var contactUser = new ContactListUser
                            {
                                GirlNum = users[i].ID,
                                Name = users[i].Name,
                                Pic1 = users[i].Pic1
                            };
                            userContactList.Add(contactUser);
                        }
                        Response.Write(JsonConvert.SerializeObject(userContactList, Formatting.Indented));
                        Response.End();
                    }
                }
                else if (Request["qType"] == "31") //get girlnum from guid
                {
                    Response.Write(new { user.ID, user.GenerateNumber, user.NeedUpdate, user.IsSupplier });
                    Response.End();
                }
                else if (Request["qType"] == "32") //get turnserver and video settings
                {
                    using (var db = new Entities())
                    {
                        var setting = (from a in db.Setting select a).FirstOrDefault();
                        var videoSettings = new VideoSettings
                        {
                            VideoResolutionWidth = setting.VideoResoultionWidth,
                            VideoResolutionHeight = setting.VideoResoultionHeight,
                            FramePerSecond = 20,
                            Google = new ServerSetting
                            {
                                Url = "stun:stun.l.google.com:19302",
                                UserName = "",
                                Credential = ""
                            },
                            Tcp = new ServerSetting
                            {
                                Url = "turn:116.203.70.128:80?transport=tcp",
                                UserName = "test",
                                Credential = "test"
                            },
                            Udp = new ServerSetting
                            {
                                Url = "turn:116.203.70.128:80?transport=udp",
                                UserName = "test",
                                Credential = "test"
                            }
                        };
                        Response.Write(JsonConvert.SerializeObject(videoSettings, Formatting.Indented));
                        Response.End();
                    }
                }
                else if (Request["qType"] == "33") // get UsersToUsers
                {
                    using (var db = new Entities())
                    {

                        var q = (from a1 in db.UsersToUsers
                                 join a2 in db.Users on a1.GetUserID equals a2.ID
                                 where a1.SendUserID == user.ID
                                 select new { a2.ID, a2.Pic1, a2.Name, a2.City, a2.GenerateNumber }).ToList();
                        if (q.Any())
                        {
                            var userContactList = new List<ContactListUser>();
                            for (int i = 0; i < q.Count(); i++)
                            {
                                var contactUser = new ContactListUser
                                {
                                    GirlNum = q[i].ID,
                                    Name = q[i].Name,
                                    Pic1 = q[i].Pic1,
                                    GeneratedNumber = q[i].GenerateNumber,
                                    City = q[i].City
                                };
                                userContactList.Add(contactUser);
                            }
                            Response.Write(JsonConvert.SerializeObject(userContactList, Formatting.Indented));
                        }

                        Response.End();
                    }
                }
                else if (Request["qType"] == "34") //get mainmodel profile
                {
                    int mainModelNumber = int.Parse(Request["mainModelNumber"].ToString());
                    using (var db = new Entities())
                    {
                        var mainModel = (from a in db.Users where a.ID == mainModelNumber select a).FirstOrDefault();
                        var model = new GirlProfile
                        {
                            GirlNum = mainModel.ID,
                            Name = mainModel.Name,
                            Pic1 = mainModel.Pic1,
                            City = mainModel.City,
                            GeneratedNumber = mainModel.GenerateNumber
                        };
                        Response.Write(JsonConvert.SerializeObject(model, Formatting.Indented));
                        Response.End();
                    }
                }
                else if (Request["qType"] == "35") //incamera
                {
                    ToGirlNum = int.Parse(Request["ToGirlNum"]);
                    string RndNum = userClass.insertUserToCamera(user.ID, ToGirlNum).ToString();

                    if (RndNum == "99" || RndNum == "98")
                    {
                        Tools.addWindowsServiceLogs(ToGirlNum, user.ID, RndNum, "user/MainModelsAPI.aspxqType=33-RndNum=" + RndNum + "", 1);
                        Response.End();
                    }
                    try
                    {
                        inChat.SendNotification((SupplierAPI.getMainModelsByNum(ToGirlNum).MainModelGuid).ToString(), "startCall");
                        //Response.Write((populateClassFromDB.getMainModels(ToGirlNum).MainModelGuid).ToString());
                    }
                    catch (Exception ex)
                    {
                        errors.addErrorString(ex.InnerException.ToString());
                    }
                    Response.Write(RndNum);
                    Response.End();
                }
                else if (Request["qType"] == "36") // delete user message
                {
                    var sendUserID = int.Parse(Request["SendUserID"]);
                    var getUserID = int.Parse(Request["GetUserID"]);
                    var whoDelete = int.Parse(Request["WhoDelete"]);
                    var messageGuid = Request["MessageGuid"];

                    using (var db = new Entities())
                    {
                        var message = (from a in db.UsersToUsersMessages where a.SendUserID == sendUserID && a.GetUserID == getUserID && a.MessageGuid == messageGuid select a).FirstOrDefault();
                        if (whoDelete == 0) // getUserDelete
                        {
                            message.GetUserDelete = 1;
                        }
                        else if (whoDelete == 1) // sendUserDelete
                        {
                            message.SendUserDelete = 1;
                        }
                        else if (whoDelete == 2) // sendUserDeleteForBoth
                        {
                            message.SenderDeleteForAll = 1;
                            inChat.SendNotification((SupplierAPI.getMainModelsByNum(getUserID).MainModelGuid).ToString(), "deleteMessage:" + sendUserID + ":" + messageGuid);
                        }
                        db.Entry(message).State = EntityState.Modified;
                        db.SaveChanges();
                    }
                }
                else if (Request["qType"] == "37") // get users by generated number
                {
                    var text = Request["text"];
                    using (var db = new Entities())
                    {
                        var usersInContactList = db.UsersToUsers.Where(u => u.SendUserID == user.ID).Select(u => u.GetUserID);
                        var users = db.Users.Where(a => a.GenerateNumber.Contains(text)).Where(a => a.ID != user.ID)
                            .Where(a => !usersInContactList.Contains(a.ID)).ToList();
                        if (users.Any())
                        {
                            var userContactList = new List<ContactListUser>();
                            for (int i = 0; i < users.Count(); i++)
                            {
                                var contactUser = new ContactListUser
                                {
                                    GirlNum = users[i].ID,
                                    Name = users[i].Name,
                                    Pic1 = users[i].Pic1,
                                    GeneratedNumber = users[i].GenerateNumber,
                                    City = users[i].City
                                };
                                userContactList.Add(contactUser);
                            }
                            Response.Write(JsonConvert.SerializeObject(userContactList, Formatting.Indented));
                        }

                        Response.End();
                    }
                }
                else if (Request["qType"] == "38") // insert usertouser 
                {
                    var userNum = int.Parse(Request["UserNum"]);
                    var userToUser = new UsersToUsers
                    {
                        DateIn = DateTime.Now,
                        GetUserID = userNum,
                        SendUserID = user.ID
                    };

                    using (var db = new Entities())
                    {
                        db.UsersToUsers.Add(userToUser);
                        db.SaveChanges();
                    }
                }
                else if (Request["qType"] == "39") // get all userMessages
                {
                    using (var con = databaseCon.create_sql_con())
                    {
                        var cmd = new SqlCommand("select * from UsersToUsersMessages where (SendUserID=@GirlNum and SendUserDelete=0 and SenderDeleteForAll=0) or (GetUserID=@GirlNum and GetUserDelete=0 and SenderDeleteForAll=0)", con);
                        cmd.Parameters.Add("@GirlNum", SqlDbType.Int).Value = user.ID;
                        var reader = cmd.ExecuteReader();
                        if (!reader.HasRows)
                        {
                            Response.Write("no messages");
                            Response.End();
                        }
                        var girlMessages = new List<GirlMessagesToUser>();
                        while (reader.Read())
                        {
                            var girlMessage = new GirlMessagesToUser();
                            girlMessage.DateIn = DateTime.Parse(reader["DateIn"].ToString()).ToString("yyyy/MM/dd HH:mm:ss");
                            girlMessage.GetUserDelete = int.Parse(reader["GetUserDelete"].ToString());
                            girlMessage.GetUserID = int.Parse(reader["GetUserID"].ToString());
                            girlMessage.IsSavedInServer = true;
                            girlMessage.Message = reader["MessageText"].ToString();
                            girlMessage.MessageRead = int.Parse(reader["MessageRead"].ToString());
                            girlMessage.MessageType = int.Parse(reader["MessageType"].ToString());
                            girlMessage.SenderDeleteForAll = int.Parse(reader["SenderDeleteForAll"].ToString());
                            girlMessage.SendUserDelete = int.Parse(reader["SendUserDelete"].ToString());
                            girlMessage.SendUserID = int.Parse(reader["SendUserID"].ToString());
                            girlMessage.VideoImage = reader["videoImage"].ToString();
                            girlMessage.MessageGuid = reader["MessageGuid"].ToString();
                            girlMessages.Add(girlMessage);
                        }
                        Response.Write(JsonConvert.SerializeObject(girlMessages, Formatting.Indented));
                        Response.End();
                    }
                }
                else if (Request["qType"] == "40") // get users not in contact list, but in chat
                {
                    using (var con = databaseCon.create_sql_con())
                    {
                        var cmd = new SqlCommand("select * from Users where ID in (select distinct GetUserID from UsersToUsersMessages where SendUserID=@GirlNum) or ID in (select distinct SendUserID from UsersToUsersMessages where GetUserID=@GirlNum) or ID in (select distinct SendUserID from ChatTimeUse where GetUserID=@GirlNum) or ID in (select distinct GetUserID from ChatTimeUse where SendUserID=@GirlNum) and ID<>@GirlNum and ID not in (select GetUserID from UsersToUsers where SendUserID=@GirlNum)", con);
                        cmd.Parameters.Add("@GirlNum", SqlDbType.Int).Value = user.ID;
                        var reader = cmd.ExecuteReader();
                        if (!reader.HasRows)
                        {
                            Response.Write("");
                            Response.End();
                        }
                        var userContactList = new List<ContactListUser>();
                        while (reader.Read())
                        {
                            var contactUser = new ContactListUser
                            {
                                GirlNum = int.Parse(reader["ID"].ToString()),
                                Name = reader["Name"].ToString(),
                                Pic1 = reader["Pic1"].ToString(),
                                GeneratedNumber = reader["GenerateNumber"].ToString(),
                                City = reader["City"].ToString()
                        };
                        userContactList.Add(contactUser);
                    }
                    Response.Write(JsonConvert.SerializeObject(userContactList, Formatting.Indented));
                }
                Response.End();
            }
        else if (Request["qType"] == "41") // user update finish
        {
            using (var db = new Entities())
            {
                user.NeedUpdate = 0;
                db.Entry(user).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
            }
    }

        else if (Request["qType"] == "42") // get user chats
        {
            using (var con = databaseCon.create_sql_con())
            {
                if (Request["chatID"] != null)
                {
                    var cmd = new SqlCommand("select top(1) * from ChatTimeUse where ID=@ID", con);
    cmd.Parameters.Add("@ID", SqlDbType.Int).Value = int.Parse(Request["chatID"].ToString());
    var reader = cmd.ExecuteReader();
                    if (!reader.HasRows)
                    {
                        Response.Write("no chats");
                        Response.End();
                    }
                    else
                    {
                        while (reader.Read())
                        {
                            var chat = new UserChatTimeUse
                            {
                                DateIn = DateTime.Parse(reader["DateIn"].ToString()).ToString("yyyy/MM/dd HH:mm:ss"),
                                Dateout = DateTime.Parse(reader["Dateout"].ToString()).ToString("yyyy/MM/dd HH:mm:ss"),
                                GetUserID = int.Parse(reader["GetUserID"].ToString()),
                                IsAnswer = true,
                                SendUserID = int.Parse(reader["SendUserID"].ToString()),
                                TimeUse = int.Parse(reader["TimeUse"].ToString())
                            };
    Response.Write(JsonConvert.SerializeObject(chat, Formatting.Indented));
                        }
                    }
                }
                else
                {
                    var cmd = new SqlCommand("select * from ChatTimeUse where (SendUserID=@GirlNum) or (GetUserID=@GirlNum)", con);
    cmd.Parameters.Add("@GirlNum", SqlDbType.Int).Value = user.ID;
                    var reader = cmd.ExecuteReader();
                    if (!reader.HasRows)
                    {
                        Response.Write("no chats");
                        Response.End();
                    }
                    var chats = new List<UserChatTimeUse>();

                    while (reader.Read())
                    {
                        var chat = new UserChatTimeUse
                        {
                            DateIn = DateTime.Parse(reader["DateIn"].ToString()).ToString("yyyy/MM/dd HH:mm:ss"),
                            Dateout = DateTime.Parse(reader["Dateout"].ToString()).ToString("yyyy/MM/dd HH:mm:ss"),
                            GetUserID = int.Parse(reader["GetUserID"].ToString()),
                            IsAnswer = true,
                            SendUserID = int.Parse(reader["SendUserID"].ToString()),
                            TimeUse = int.Parse(reader["TimeUse"].ToString())
                        };
    chats.Add(chat);
                    }
                    Response.Write(JsonConvert.SerializeObject(chats, Formatting.Indented));
                }
            }
            Response.End();
        }
    }

    protected string getUserPhotoFromNum(int userNum)
    {
        using (var db = new Entities())
        {
            var userPhoto = (from a in db.Users where a.ID == userNum select a).FirstOrDefault().Pic1;
            return userPhoto;
        }
    }

    protected string GetCurrencyByID(int? id)
    {
        var currencyName = "";
        using (var con = databaseCon.create_sql_con())
        {
            var command = new SqlCommand("select Name from Currencies where ID=" + id, con);
            currencyName = command.ExecuteScalar().ToString();
        }
        return currencyName;
    }

    protected string checkIfNull(object value)
    {
        if (value == null)
        {
            return "-1";
        }
        return value.ToString();
    }

    protected string getMessageTextFromId(int id)
    {
        using (var con = databaseCon.create_sql_con())
        {
            var cmd = new SqlCommand("select message from messages where message_id=@id", con);
            cmd.Parameters.Add("@id", SqlDbType.Int).Value = id;
            var message = cmd.ExecuteScalar().ToString();
            if (message.Length > 20)
            {
                return message.Substring(0, 20) + "...";
            }
            return message;
        }
    }

    protected int getMessageIsReadFromId(int id)
    {
        using (var con = databaseCon.create_sql_con())
        {
            var cmd = new SqlCommand("select message_read from messages where message_id=@id", con);
            cmd.Parameters.Add("@id", SqlDbType.Int).Value = id;
            return int.Parse(cmd.ExecuteScalar().ToString());
        }
    }

    protected int getMessageWhoSendFromId(int id)
    {
        using (var con = databaseCon.create_sql_con())
        {
            var cmd = new SqlCommand("select who_send from messages where message_id=@id", con);
            cmd.Parameters.Add("@id", SqlDbType.Int).Value = id;
            return int.Parse(cmd.ExecuteScalar().ToString());
        }
    }

    protected string getMessageDateFromId(int id)
    {
        using (var con = databaseCon.create_sql_con())
        {
            var cmd = new SqlCommand("select DateIn from messages where message_id=@id", con);
            cmd.Parameters.Add("@id", SqlDbType.Int).Value = id;
            var date = DateTime.Parse(cmd.ExecuteScalar().ToString());
            return date.ToString("yyyy/MM/dd HH:mm:ss");
        }
    }

    private string GetGirlNameFromNumber(int girlNum)
    {
        string girlName = "";

        using (var con = databaseCon.create_sql_con())
        {
            var cmd = new SqlCommand("select Name from MainModels where GirlNum=@GirlNum", con);
            cmd.Parameters.Add("@GirlNum", SqlDbType.Int).Value = girlNum;
            girlName = cmd.ExecuteScalar().ToString();
        }
        return girlName;
    }

    protected List<string> GetGirlMessages()
    {
        if (HttpContext.Current.Cache["GirlMessages"] == null)
        {
            using (var con = databaseCon.create_sql_con())
            {
                var cmd = new SqlCommand("select distinct MainModelGuid as girl_guid from MainModels inner join messages on MainModels.GirlNum = messages.GirlNum  where who_send=0 and isMessageReadInApp=0 and girl_delete = 0 ", con);
                var reader = cmd.ExecuteReader();
                var girlMessages = new List<string>();
                while (reader.Read())
                {
                    girlMessages.Add(reader["girl_guid"].ToString());
                }
                if (HttpContext.Current.Cache["GirlMessages"] == null)
                {
                    HttpContext.Current.Cache.Insert("GirlMessages", girlMessages, null, DateTime.Now.AddSeconds(5), System.Web.Caching.Cache.NoSlidingExpiration);
                }
            }
        }
        return (List<string>)(HttpContext.Current.Cache["GirlMessages"]);
    }

    protected int getMessageTypeFromId(int id)
    {
        using (var con = databaseCon.create_sql_con())
        {
            var cmd = new SqlCommand("select messageType from messages where message_id=@id", con);
            cmd.Parameters.Add("@id", SqlDbType.Int).Value = id;
            return int.Parse(cmd.ExecuteScalar().ToString());
        }
    }
</script>

