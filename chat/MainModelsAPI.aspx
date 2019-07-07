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
    public class DomainsListForApp
    {
        public string MainAPPActivity { get; set; }
        public string AppBarBackgroundColor { get; set; }
        public string AppBackgroundColor { get; set; }
        public int RealPhoneView { get; set; }
        public int ExtractUserPhoneContacts { get; set; }
        public string AppButtonColor { get; set; }
        public string AppSplashImage { get; set; }
        public string AppButtonTextColor { get; set; }
        public int IsAddultApp { get; set; }
        public string AppSplashIcon { get; set; }
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
        public int CustomerID { get; set; }
        public int SupplierID { get; set; }
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
        public string Phone { get; set; }
        public string AditionalInfo { get; set; }
        public string PaymentMethod { get; set; }
        public string PayPerMinute { get; set; }
        public string PayPerMessage { get; set; }
        public string Curency { get; set; }
        public string City { get; set; }
        public string Pic1 { get; set; }
        public int SupplierID { get; set; }
        public string CountryCode { get; set; }
        public string MainModelGuid { get; set; }
        public int IsSupplier { get; set; }
        public string GeneratedNumber { get; set; }
        public int NeedUpdate { get; set; }
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
        public string TotalPrice { get; set; }
    }

    public partial class ContactListUser
    {
        public int SupplierID { get; set; }
        public string Name { get; set; }
        public string Pic1 { get; set; }
        public string GeneratedNumber { get; set; }
        public string City { get; set; }
        public int IsPublicUser { get; set; }
        public string CountryCode { get; set; }
        public string Phone { get; set; }
        public int YearOfBirth { get; set; }
        public int Gender { get; set; }
        public string AditionalInfo { get; set; }
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
        public int SupplierID { get; set; }
        public int CustomerID { get; set; }
        public int IsAnswer { get; set; }
        public string RndNum { get; set; }
        public int CallViewStatus { get; set; }
        public int IsPayPerMinute { get; set; }
    }


    public partial class UserAccountProperties
    {
        public int IsPublic { get; set; }
        public string PropertyName { get; set; }
        public DateTime DateIn { get; set; }
        public int UserID { get; set; }
    }


    public partial class UserPayments
    {
        public int SupplierID { get; set; }
        public double Price { get; set; }
        public DateTime DateIn { get; set; }
        public string LastDigits { get; set; }
    }

    public partial class UserToUserServicePayments
    {
        public int SupplierID { get; set; }
        public int CustomerID { get; set; }
        public double TotalPriceInDollar { get; set; }
        public string ChatTimeUseGuid { get; set; }
        public string UsersToUsersMessagesGuid { get; set; }
    }

    public partial class UserGallery
    {
        public int SupplierID { get; set; }
        public string ImageName { get; set; }
    }

    public partial class LanguagePartial
    {
        public int ID { get; set; }
        public string Language { get; set; }
    }

    public partial class UserReviewPartial
    {
        public string ReviewText { get; set; }
        public string Date { get; set; }
    }

    public partial class UserListPartial
    {
        public int Status { get; set; }
        public double SupplierRating { get; set; }
        public string SupplierToServicePriceGuid { get; set; }
        public List<int> LanguageID { get; set; }
    }

    public string SupplierToServicePriceGuid;
    public Users user;
    public Guid MainModelGuid;
    public int ToSupplierID;
    public DomainsList domain;
    public DomainProperties domainProperties;
    protected void Page_Load(object sender, EventArgs e)
    {
        //requestt
        Response.Expires = 0;
        Response.AddHeader("pragma", "no-cache");
        Response.AddHeader("cache-control", "private");
        Response.CacheControl = ("no-cache");

        using (var db = new Entities())
        {
            var settings = (from a in db.Setting select a).FirstOrDefault();
            if (settings.MessageForAppUserUpgrade == 0)
            {
                Response.StatusCode = 500;
            }
        }

        if (Request["MainModelGuid"] != null)
        {
            using (var db = new Entities())
            {
                MainModelGuid = Guid.Parse(Request["MainModelGuid"].ToString());
                user = (from a in db.Users where a.MainModelGuid == MainModelGuid select a).FirstOrDefault();
            }
        }

        if (Request["DomainID"] != null)
        {
            using (var db = new Entities())
            {
                var domainID = int.Parse(Request["DomainID"].ToString());
                domain = (from a in db.DomainsList where a.ID == domainID select a).FirstOrDefault();
                domainProperties = (from a in db.DomainProperties where a.DomainID == domainID select a).FirstOrDefault();
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
        else if (Request["qType"] == "4") //supplier hang up call
        {
            using (var db = new Entities())
            {
                var RndNum = (from a in db.OnlineUsers where a.SupplierID == user.ID select a).FirstOrDefault().RndNumber;
                //var chatTimeUse = (from a in db.ChatTimeUse where a.RndNum == RndNum select a);
                //Trace.Warn("1="+RndNum);
                ////if (chatTimeUse.Any() == true)
                ////{
                //Trace.Warn("2="+RndNum);
                userClass.SupplierEndSession(1, "supplierClickOut", user.ID);
                //}

                //databaseCon.ExecuteNonQuerySql("update onlineUsers set CustomerID=1,Online=2,RndNumber='" + Guid.NewGuid() + "' where SupplierID=" + user.ID);
                //databaseCon.ExecuteNonQuerySql("update ChatTimeUse set TimeUse=0,TheChatWasActive=2 where SessionStatus=1 and TheChatWasActive=0 and datediff(second,DateIn,dateout)>29");
                Response.Write(RndNum);
                Response.End();
            }
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
                onlineUser = (from a in db.OnlineUsers where a.SupplierID == user.ID select a).FirstOrDefault();
                //Session["SupplierID_worker"] = onlineUser.SupplierID;
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
                onlineUser.CustomerID = 1;
                db.Entry(onlineUser).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
            }
            Response.Write(statusAsInteger);
            Response.End();
        }

        else if (Request["qType"] == "7") // check girl status
        {
            if (Request["SupplierID"] == null)
            {
                using (var con = databaseCon.create_sql_con())
                {
                    var cmd = new SqlCommand("select Online from OnlineUsers inner join Users on OnlineUsers.SupplierID=Users.ID where MainModelGuid=@MainModelGuid", con);
                    cmd.Parameters.Add("@MainModelGuid", SqlDbType.UniqueIdentifier).Value = MainModelGuid;
                    var result = cmd.ExecuteScalar();
                    Response.Write(result);
                    Response.End();
                }
            }
            else
            {
                using (var con = databaseCon.create_sql_con())
                {
                    var cmd = new SqlCommand("select Online from OnlineUsers where SupplierID=@SupplierID", con);
                    cmd.Parameters.Add("@SupplierID", SqlDbType.Int).Value = Request["SupplierID"];
                    var result = cmd.ExecuteScalar();
                    Response.Write(result);
                    Response.End();
                }
            }
        }
        else if (Request["qType"] == "8") // get users messages
        {
            //var MainModelGuid = Request["MainModelGuid"];
            //var SupplierID = 0;
            //using (var con = databaseCon.create_sql_con())
            //{
            //    var cmd = new SqlCommand("select SupplierID from MainModels where MainModelGuid=@MainModelGuid", con);
            //    cmd.Parameters.Add("@MainModelGuid", SqlDbType.UniqueIdentifier).Value = MainModelGuid;
            //    SupplierID = int.Parse(cmd.ExecuteScalar().ToString());
            //}
            using (var con = databaseCon.create_sql_con())
            {
                var girlMessages = new List<GirlMessages>();
                var cmd = new SqlCommand("select ID, max(message_id) as messageId from [messages] where SupplierID=@SupplierID and girl_delete=0 and who_send=0 group by  ID order by max(message_id) desc", con);
                cmd.Parameters.Add("@SupplierID", SqlDbType.Int).Value = user.ID;
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

        else if (Request["qType"] == "10") // send user a message
        {

            var UserIDGetMessage = int.Parse(Request["UserNum"]); //the one that receive the message
            SupplierToServicePriceGuid = Request["SupplierToServicePriceGuid"];
            using (var db = new Entities())
            {

                float sumUserBalanceInDollar = userClass.getCustomerBalanceInDollar(user.ID);
                float CountMaxMessage = userClass.getCountIfMessageCustomerToSupplier(user.ID, UserIDGetMessage, sumUserBalanceInDollar, Guid.Parse(SupplierToServicePriceGuid));
                if (CountMaxMessage > 0)
                {
                    var message = Request["message"];
                    var type = byte.Parse(Request["messageType"]);
                    var messageGuid = Request["messageGuid"];

                    var userMessage = new UsersToUsersMessages
                    {
                        DateIn = DateTime.Now,
                        GetUserDelete = 0,
                        SupplierID = user.ID,
                        MessageRead = 0,
                        MessageText = message,
                        MessageType = type,
                        MustRead = 0,
                        SenderDeleteForAll = 0,
                        SendUserDelete = 0,
                        CustomerID = UserIDGetMessage,
                        MessageGuid = messageGuid
                    };
                    db.UsersToUsersMessages.Add(userMessage);
                    db.SaveChanges();

                    try
                    {
                        inChat.SendNotification(SupplierAPI.getMainModelsByNum(UserIDGetMessage), "message", Guid.NewGuid(), 0);
                    }
                    catch (Exception ex)
                    {
                        errors.insertErrors(ex);
                    }
                }
                else
                {
                    Response.Write("No message");
                }

            }
        }
        else if (Request["qType"] == "11") // mark messages as read/unread
        {
            var UserNum = int.Parse(Request["UserNum"]);
            if (Request["markAsUnread"] != null)
            {
                using (var con = databaseCon.create_sql_con())
                {
                    var command = new SqlCommand("update TOP (1) UsersToUsersMessages set MessageRead=0 where SupplierID=" + UserNum + " and CustomerID=" + user.ID + " and GetUserDelete=0 and SenderDeleteForAll=0 and ID in(select top(1) ID from UsersToUsersMessages where CustomerID=" + UserNum + " and SupplierID=" + user.ID + " and GetUserDelete=0 and SenderDeleteForAll=0 order by ID desc)", con);
                    command.ExecuteNonQuery();
                }
            }
            using (var con = databaseCon.create_sql_con())
            {
                var command = new SqlCommand("update UsersToUsersMessages set MessageRead=1 where SupplierID=" + UserNum + " and CustomerID=" + user.ID + " and GetUserDelete=0 and SenderDeleteForAll=0", con);
                command.ExecuteNonQuery();
            }
        }

        else if (Request["qType"] == "13") //girl delete conversation
        {
            var UserNum = int.Parse(Request["UserNum"]);
            using (var con = databaseCon.create_sql_con())
            {
                var cmd = new SqlCommand("update UsersToUsersMessages set SendUserDelete=1 where (CustomerID=@SupplierID and SupplierID=@UserNum)", con);
                cmd.Parameters.Add("@UserNum", SqlDbType.Int).Value = UserNum;
                cmd.Parameters.Add("@SupplierID", SqlDbType.Int).Value = user.ID;
                cmd.ExecuteNonQuery();
            }
            using (var con = databaseCon.create_sql_con())
            {
                var cmd = new SqlCommand("update UsersToUsersMessages set GetUserDelete=1 where (SupplierID=@SupplierID and CustomerID=@UserNum)", con);
                cmd.Parameters.Add("@UserNum", SqlDbType.Int).Value = UserNum;
                cmd.Parameters.Add("@SupplierID", SqlDbType.Int).Value = user.ID;
                cmd.ExecuteNonQuery();
            }
        }
        else if (Request["qType"] == "12") // check if new message
        {
            using (var con = databaseCon.create_sql_con())
            {
                var cmd = new SqlCommand("select top(1) * from UsersToUsersMessages where CustomerID=@SupplierID and MessageRead=0 and SenderDeleteForAll=0 order by DateIn desc", con);
                cmd.Parameters.Add("@SupplierID", SqlDbType.Int).Value = user.ID;
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
                    girlMessage.SupplierID = int.Parse(reader["SupplierID"].ToString());
                    girlMessage.IsSavedInServer = true;
                    girlMessage.Message = reader["MessageText"].ToString();
                    girlMessage.MessageRead = int.Parse(reader["MessageRead"].ToString());
                    girlMessage.MessageType = int.Parse(reader["MessageType"].ToString());
                    girlMessage.SenderDeleteForAll = int.Parse(reader["SenderDeleteForAll"].ToString());
                    girlMessage.SendUserDelete = int.Parse(reader["SendUserDelete"].ToString());
                    girlMessage.CustomerID = int.Parse(reader["CustomerID"].ToString());
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
            //var SupplierID = 0;
            databaseCon.ExecuteNonQuerySql("update OnlineUsers set Online=0 where SupplierID=(select top 1 ID from Users where MainModelGuid='" + MainModelGuid + "')");
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
                if (s.UserAppVersionID == 0)
                {
                    Response.Write("0");
                }
                else
                {
                    Response.Write(s.UserAppVersionID);
                }
            }
            Response.End();
        }
        else if (Request["qType"] == "19") //add new Supplier 
        {
            Response.Write(SupplierAPI.AddNewSupplier(Request["Phone"], Request["CountryCode"], int.Parse(Request["DomainID"])));
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
            using (var db = new Entities())
            {
                var supplierToServicePrice = (from a in db.SupplierToServicePrice where a.SupplierID == user.ID select a).OrderByDescending(s => s.ID).FirstOrDefault();
                var currency = (from a in db.Currencies where a.ID == supplierToServicePrice.CurrencyID select a).FirstOrDefault();
                var girlProfile = new GirlProfile()
                {
                    Name = checkIfNull(user.Name),
                    YearOfBirth = checkIfNull(user.YearBirth),
                    Gender = (int.Parse(checkIfNull(user.Gender)) - 1).ToString(),
                    AditionalInfo = checkIfNull(user.ExtraDetails),
                    Curency = currency.CurrencySymbol,
                    PaymentMethod = checkIfNull(user.PaymentsInformation),
                    PayPerMinute = supplierToServicePrice.PricePerMinute.ToString(),
                    PayPerMessage = supplierToServicePrice.PricePerMessage.ToString(),
                    City = checkIfNull(user.City),
                    Pic1 = checkIfNull(user.Pic1),
                    SupplierID = user.ID,
                    GeneratedNumber = user.GenerateNumber,
                    CountryCode = user.CountryCode,
                    IsSupplier = int.Parse(user.IsSupplier.ToString()),
                    MainModelGuid = user.MainModelGuid.ToString(),
                    Phone = user.Phone


                };
                Response.Write(JsonConvert.SerializeObject(girlProfile, Formatting.Indented));
                Response.End();
            }
        }
        else if (Request["qType"] == "22") //upload profile image file
        {
            //MainModels user = SupplierAPI.getMainModelsByGuid(Guid.Parse(Request["MainModelGuid"]));
            var filePath = Server.MapPath("/media/Suppliers/gallery/big/" + user.Pic1);
            if (File.Exists(filePath))
            {
                File.Delete(filePath);
            }

            string fileName = "";
            foreach (string upload in Request.Files)
            {
                var path = AppDomain.CurrentDomain.BaseDirectory + "/media/Suppliers";
                var file = Request.Files[upload];
                if (file == null) continue;
                var extention = Path.GetExtension(file.FileName);
                if (String.IsNullOrEmpty(extention))
                {
                    extention = ".jpg";
                }
                fileName = Guid.NewGuid().ToString() + extention;
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
            using (var db = new Entities())
            {
                var action = Request["action"];

                if (action == "nameUpdate")
                {
                    user.Name = Request["Name"];
                }
                else if (action == "updatePersonalData")
                {
                    user.Name = Request["Name"];
                    int number;
                    bool success = Int32.TryParse(Request["YearOfBirth"], out number);
                    if (success)
                    {
                        user.YearBirth = int.Parse(Request["YearOfBirth"]);
                    }
                    success = Int32.TryParse(Request["Gender"], out number);
                    if (success)
                    {
                        user.Gender = int.Parse(Request["Gender"]) + 1;
                    }
                    if (Request["AditionalInfo"] != "")
                    {
                        user.ExtraDetails = Request["AditionalInfo"];
                    }
                    else
                    {
                        user.ExtraDetails = "";
                    }
                }
                else if (action == "updatePaymentData")
                {
                    var currencySymbol = Request["Curency"].ToString();
                    var pricePerMinute = float.Parse(Request["PayPerMinute"]);
                    var pricePerMessage = float.Parse(Request["PricePerMessage"]);

                    var currency = (from a in db.Currencies where a.CurrencySymbol == currencySymbol select a).FirstOrDefault();
                    var supplierToServicePrice = (from a in db.SupplierToServicePrice where a.SupplierID == user.ID select a).FirstOrDefault();

                    // if one of the prices is different - add new row
                    if (pricePerMinute != supplierToServicePrice.PricePerMinute || pricePerMessage != supplierToServicePrice.PricePerMessage)
                    {
                        SupplierToServicePrice SupplierToServicePrice_ = new SupplierToServicePrice
                        {
                            DateIn = DateTime.Now,
                            CurrencyID = currency.ID,
                            PricePerMinute = pricePerMinute,
                            PricePerMessage = pricePerMessage,
                            SupplierToServicePriceGuid = Guid.NewGuid(),
                            SupplierID = user.ID
                        };
                        db.SupplierToServicePrice.Add(SupplierToServicePrice_);
                        db.SaveChanges();
                        user.SupplierToServicePriceID = SupplierToServicePrice_.ID;
                    }
                    user.PaymentsInformation = Request["PaymentMethod"];
                }
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

            using (var db = new Entities())
            {
                var supplierToServicePrice = (from a in db.SupplierToServicePrice where a.SupplierID == user.ID select a);
                var usersToUsersServicesPayments = db.UsersToUsersServicesPayments.Where(us => supplierToServicePrice.Select(s => s.ID).Contains(us.ID));
                totalTime = usersToUsersServicesPayments.Sum(u => u.ChatTimeUse.TimeUse);
                totalPrice = usersToUsersServicesPayments.Sum(u => u.TotalPriceInDollar);

                var girlBankAccount = new GirlBankAccount
                {
                    TotalMinutes = Math.Round((totalTime / 60), 2).ToString("0.00"),
                    TotalPrice = Math.Round(totalPrice, 2).ToString("0.00"),
                    Currency = GetCurrencyByID(user.CustomerCurrencyID)
                };

                Response.Write(JsonConvert.SerializeObject(girlBankAccount, Formatting.Indented));
                Response.End();
            }
        }
        else if (Request["qType"] == "26")  //get girl chats for period
        {
            var startDate = DateTime.Parse(Request["startDate"]);
            var endDate = DateTime.Parse(Request["endDate"]);
            var girlChats = new List<GirlChat>();
            using (var db = new Entities())
            {
                var supplierToServicePrice = (from a in db.SupplierToServicePrice where a.SupplierID == user.ID select a);
                var usersToUsersServicesPayments = db.UsersToUsersServicesPayments.Where(us => supplierToServicePrice.Select(s => s.ID).Contains(us.ID));
                foreach (var item in usersToUsersServicesPayments)
                {
                    if (item.ChatTimeUseID != 0)
                    {
                        var chat = new GirlChat
                        {
                            ChatType = "0",
                            TimeIn = item.ChatTimeUse.DateIn.ToString(),
                            Seconds = item.ChatTimeUse.TimeUse.ToString(),
                            UserNum = item.CustomerID.ToString(),
                            TotalPrice = item.TotalPriceInDollar.ToString()
                        };
                        girlChats.Add(chat);
                    }
                    else if (item.UsersToUsersMessagesID != 0)
                    {
                        var chat = new GirlChat
                        {
                            ChatType = "1",
                            TimeIn = item.UsersToUsersMessages.DateIn.ToString(),
                            Seconds = "0",
                            UserNum = item.CustomerID.ToString(),
                            TotalPrice = item.TotalPriceInDollar.ToString()
                        };
                        girlChats.Add(chat);
                    }
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
                //var SupplierID = SupplierAPI.getMainModelsByGuid(Guid.Parse(Request["MainModelGuid"])).SupplierID;
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
                            message = (from a in db.UsersToUsersMessages where a.SupplierID == user.ID && a.CustomerID == userNum && a.MessageGuid == messageGuid select a).FirstOrDefault();
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
                        SupplierID = user.ID,
                        MessageRead = 0,
                        MessageText = fileName,
                        MessageType = byte.Parse(messageType),
                        MustRead = 0,
                        SenderDeleteForAll = 0,
                        SendUserDelete = 0,
                        CustomerID = userNum,
                        MessageGuid = messageGuid
                    };
                    db.UsersToUsersMessages.Add(newMessage);
                    db.SaveChanges();
                    try
                    {
                        inChat.SendNotification(SupplierAPI.getMainModelsByNum(userNum), "message", Guid.NewGuid(), 0);
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
        //else if (Request["qType"] == "29") //create user registration
        //{
        //    using (var db = new Entities())
        //    {
        //        if (Request["account"] == "user")
        //        {
        //            user.IsSupplier = 0;
        //            user.Active = 1;
        //            user.AdminApprovedCard = 1;
        //        }
        //        else if (Request["account"] == "consultant")
        //        {
        //            user.IsSupplier = 1;
        //            user.Active = 1;
        //            user.AdminApprovedCard = 1;
        //        }
        //        db.Entry(user).State = EntityState.Modified;
        //        db.SaveChanges();
        //    }
        //}
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
                        SupplierID = users[i].ID,
                        Name = users[i].Name,
                        Pic1 = users[i].Pic1
                    };
                    userContactList.Add(contactUser);
                }
                Response.Write(JsonConvert.SerializeObject(userContactList, Formatting.Indented));
                Response.End();
            }
        }
        else if (Request["qType"] == "31") //get SupplierID from guid
        {
            var userProfile = new GirlProfile
            {
                AditionalInfo = user.ExtraDetails,
                City = user.City,
                CountryCode = user.CountryCode,
                Gender = user.Gender.ToString(),
                GeneratedNumber = user.GenerateNumber,
                IsSupplier = user.IsSupplier,
                MainModelGuid = user.MainModelGuid.ToString(),
                Name = user.Name,
                PaymentMethod = user.PaymentsInformation,
                Phone = user.Phone,
                Pic1 = user.Pic1,
                SupplierID = user.ID,
                YearOfBirth = user.YearBirth.ToString(),
                NeedUpdate = user.NeedUpdate,

            };
            Response.Write(JsonConvert.SerializeObject(userProfile, Formatting.Indented));
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
                         join a2 in db.Users on a1.CustomerID equals a2.ID
                         where a1.SupplierID == user.ID
                         select new
                         {
                             a2.ID,
                             a2.Pic1,
                             a2.Name,
                             a2.City,
                             a2.GenerateNumber,
                             a2.ExtraDetails,
                             a2.Gender,
                             a2.YearBirth,
                             a2.CountryCode,
                             a2.Phone,
                             a2.IsPublicUser
                         }).ToList();
                if (q.Any())
                {
                    var userContactList = new List<ContactListUser>();
                    for (int i = 0; i < q.Count(); i++)
                    {
                        var contactUser = new ContactListUser
                        {
                            SupplierID = q[i].ID,
                            Name = q[i].Name,
                            Pic1 = q[i].Pic1,
                            GeneratedNumber = q[i].GenerateNumber,
                            City = q[i].City,
                            CountryCode = q[i].CountryCode,
                            Phone = q[i].Phone,
                            IsPublicUser = int.Parse(q[i].IsPublicUser.ToString()),
                            AditionalInfo = q[i].ExtraDetails,
                            Gender = q[i].Gender,
                            YearOfBirth = (int)q[i].YearBirth
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
                    SupplierID = mainModel.ID,
                    Name = mainModel.Name,
                    Pic1 = mainModel.Pic1,
                    City = mainModel.City,
                    GeneratedNumber = mainModel.GenerateNumber,
                    Phone = mainModel.Phone,
                    AditionalInfo = mainModel.ExtraDetails,
                    CountryCode = mainModel.CountryCode,
                    Gender = mainModel.Gender.ToString(),
                    IsSupplier = mainModel.IsSupplier,
                    PaymentMethod = mainModel.PaymentsInformation,
                    YearOfBirth = mainModel.YearBirth.ToString()
                };
                Response.Write(JsonConvert.SerializeObject(model, Formatting.Indented));
                Response.End();
            }
        }
        else if (Request["qType"] == "35") //incamera
        {
            SupplierToServicePriceGuid = Request["SupplierToServicePriceGuid"];
            ToSupplierID = int.Parse(Request["ToSupplierID"]);
            string RndNum = userClass.insertUserToCamera(user.ID, ToSupplierID, Guid.Parse(SupplierToServicePriceGuid)).ToString();

            if (RndNum == "99" || RndNum == "98" || RndNum == "96")
            {
                Tools.addWindowsServiceLogs(ToSupplierID, user.ID, RndNum, "user/MainModelsAPI.aspxqType=33-RndNum=" + RndNum + "", 1);
                Response.Write(RndNum);
                Response.End();
            }
            if (RndNum == "0")
            {
                Tools.addWindowsServiceLogs(ToSupplierID, user.ID, RndNum, "user/MainModelsAPI.aspxqType=33-RndNum=" + RndNum + "", 1);
                Response.Write(RndNum);
                Response.End();
            }
            try
            {
                Tools.addWindowsServiceLogs(ToSupplierID, user.ID, RndNum, "before send notification", 1);
                inChat.SendNotification(SupplierAPI.getMainModelsByNum(ToSupplierID), "startCall", Guid.Parse(RndNum), user.ID);
                Tools.addWindowsServiceLogs(ToSupplierID, user.ID, RndNum, "before send notification2", 1);
                //Response.Write((populateClassFromDB.getMainModels(ToSupplierID).MainModelGuid).ToString());
            }
            catch (Exception ex)
            {
                errors.addErrorString(ex.InnerException.ToString());
            }
            Trace.Warn("RndNum" + RndNum);
            Response.Write(RndNum);
            Response.End();
        }
        else if (Request["qType"] == "36") // delete user message
        {
            var CustomerID = int.Parse(Request["CustomerID"]);
            var SupplierID = int.Parse(Request["SupplierID"]);
            var whoDelete = int.Parse(Request["WhoDelete"]);
            var messageGuid = Request["MessageGuid"];

            using (var db = new Entities())
            {
                var message = (from a in db.UsersToUsersMessages where a.CustomerID == CustomerID && a.SupplierID == SupplierID && a.MessageGuid == messageGuid select a).FirstOrDefault();
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
                    inChat.SendNotification((SupplierAPI.getMainModelsByNum(SupplierID)), "deleteMessage:" + CustomerID + ":" + messageGuid, Guid.NewGuid(), 0);
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
                var usersInContactList = db.UsersToUsers.Where(u => u.CustomerID == user.ID).Select(u => u.SupplierID);
                var users = db.Users.Where(a => a.GenerateNumber.Contains(text)).Where(a => a.ID != user.ID)
                    .Where(a => !usersInContactList.Contains(a.ID)).ToList();
                if (users.Any())
                {
                    var userContactList = new List<ContactListUser>();
                    for (int i = 0; i < users.Count(); i++)
                    {
                        var contactUser = new ContactListUser
                        {
                            SupplierID = users[i].ID,
                            Name = users[i].Name,
                            Pic1 = users[i].Pic1,
                            GeneratedNumber = users[i].GenerateNumber,
                            City = users[i].City,
                            CountryCode = users[i].CountryCode,
                            Phone = users[i].Phone,
                            IsPublicUser = int.Parse(users[i].IsPublicUser.ToString())

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
                SupplierID = user.ID,
                CustomerID = userNum
            };

            using (var db = new Entities())
            {
                db.UsersToUsers.Add(userToUser);
                db.SaveChanges();
            }
            try
            {
                inChat.SendNotification(SupplierAPI.getMainModelsByNum(userNum), "add to contact", Guid.NewGuid(), user.ID);
            }
            catch (Exception ex)
            {
                errors.insertErrors(ex);
            }
        }
        else if (Request["qType"] == "39") // get all userMessages
        {
            using (var con = databaseCon.create_sql_con())
            {
                var cmd = new SqlCommand("select * from UsersToUsersMessages where ((CustomerID=@SupplierID and SendUserDelete=0 and SenderDeleteForAll=0) or (SupplierID=@SupplierID and GetUserDelete=0 and SenderDeleteForAll=0)) and DateIn>='" + DateTime.Now.AddYears(-1) + "'", con);
                cmd.Parameters.Add("@SupplierID", SqlDbType.Int).Value = user.ID;
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
                    girlMessage.SupplierID = int.Parse(reader["SupplierID"].ToString());
                    girlMessage.IsSavedInServer = true;
                    girlMessage.Message = reader["MessageText"].ToString();
                    girlMessage.MessageRead = int.Parse(reader["MessageRead"].ToString());
                    girlMessage.MessageType = int.Parse(reader["MessageType"].ToString());
                    girlMessage.SenderDeleteForAll = int.Parse(reader["SenderDeleteForAll"].ToString());
                    girlMessage.SendUserDelete = int.Parse(reader["SendUserDelete"].ToString());
                    girlMessage.CustomerID = int.Parse(reader["CustomerID"].ToString());
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
                var cmd = new SqlCommand("select * from Users where ID in (select distinct SupplierID from UsersToUsersMessages where CustomerID=@SupplierID) or ID in (select distinct CustomerID from UsersToUsersMessages where SupplierID=@SupplierID) or ID in (select distinct CustomerID from ChatTimeUse where SupplierID=@SupplierID) or ID in (select distinct SupplierID from ChatTimeUse where CustomerID=@SupplierID) and ID<>@SupplierID and ID not in (select SupplierID from UsersToUsers where CustomerID=@SupplierID)", con);
                cmd.Parameters.Add("@SupplierID", SqlDbType.Int).Value = user.ID;
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
                        SupplierID = int.Parse(reader["ID"].ToString()),
                        Name = reader["Name"].ToString(),
                        Pic1 = reader["Pic1"].ToString(),
                        GeneratedNumber = reader["GenerateNumber"].ToString(),
                        City = reader["City"].ToString(),
                        CountryCode = reader["CountryCode"].ToString(),
                        Phone = reader["Phone"].ToString(),
                        IsPublicUser = int.Parse(reader["IsPublicUser"].ToString())
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
            using (var db = new Entities())
            {
                if (Request["RndNum"] != null)
                {
                    var RndNum = Guid.Parse(Request["RndNum"].ToString());
                    var chatTimeUse = (from a in db.ChatTimeUse where a.RndNum == RndNum select a);
                    if (chatTimeUse.Any())
                    {
                        var chat = new UserChatTimeUse
                        {
                            DateIn = chatTimeUse.First().DateIn.ToString("yyyy/MM/dd HH:mm:ss"),
                            Dateout = chatTimeUse.First().Dateout.ToString("yyyy/MM/dd HH:mm:ss"),
                            SupplierID = chatTimeUse.First().SupplierID,
                            IsAnswer = byte.Parse(chatTimeUse.First().IsAnswer.ToString()),
                            CustomerID = chatTimeUse.First().CustomerID,
                            TimeUse = chatTimeUse.First().TimeUse,
                            RndNum = chatTimeUse.First().RndNum.ToString(),
                            CallViewStatus = byte.Parse(chatTimeUse.First().CallViewStatus.ToString()),
                            IsPayPerMinute = chatTimeUse.First().IsPayPerMinute
                        };
                        Response.Write(JsonConvert.SerializeObject(chat, Formatting.Indented));
                    }
                    else
                    {
                        var chatTimeUses = from a in db.ChatTimeUse where a.CustomerID == user.ID || a.SupplierID == user.ID select a;
                        var chats = new List<UserChatTimeUse>();

                        foreach (var chat in chatTimeUses)
                        {
                            var chatTimeUse2 = new UserChatTimeUse
                            {
                                DateIn = chat.DateIn.ToString("yyyy/MM/dd HH:mm:ss"),
                                Dateout = chat.Dateout.ToString("yyyy/MM/dd HH:mm:ss"),
                                SupplierID = chat.SupplierID,
                                IsAnswer = byte.Parse(chat.IsAnswer.ToString()),
                                CustomerID = chat.CustomerID,
                                TimeUse = chat.TimeUse,
                                RndNum = chat.RndNum.ToString(),
                                CallViewStatus = byte.Parse(chat.CallViewStatus.ToString()),
                                IsPayPerMinute = chatTimeUses.First().IsPayPerMinute
                            };
                            chats.Add(chatTimeUse2);
                        }
                        Response.Write(JsonConvert.SerializeObject(chats, Formatting.Indented));
                    }

                }
                else
                {
                    var date = DateTime.Now.AddYears(-1);
                    var chatTimeUses = from a in db.ChatTimeUse where (a.CustomerID == user.ID || a.SupplierID == user.ID) && a.DateIn >= date select a;
                    var chats = new List<UserChatTimeUse>();

                    foreach (var chat in chatTimeUses)
                    {
                        var chatTimeUse = new UserChatTimeUse
                        {
                            DateIn = chat.DateIn.ToString("yyyy/MM/dd HH:mm:ss"),
                            Dateout = chat.Dateout.ToString("yyyy/MM/dd HH:mm:ss"),
                            SupplierID = chat.SupplierID,
                            IsAnswer = byte.Parse(chat.IsAnswer.ToString()),
                            CustomerID = chat.CustomerID,
                            TimeUse = chat.TimeUse,
                            RndNum = chat.RndNum.ToString(),
                            CallViewStatus = byte.Parse(chat.CallViewStatus.ToString()),
                            IsPayPerMinute = chat.IsPayPerMinute
                        };
                        chats.Add(chatTimeUse);
                    }
                    Response.Write(JsonConvert.SerializeObject(chats, Formatting.Indented));
                }
            }
            Response.End();
        }

        else if (Request["qType"] == "43") // get new contact
        {
            var text = Request["text"];
            var hasUsers = new List<Users>();
            using (var db = new Entities())
            {
                if (domainProperties.IsAddultApp == 0 && domainProperties.ExtractUserPhoneContacts == 1)
                {
                    //take all users that match search
                    hasUsers = (from a in db.Users where (a.Name.ToLower().Contains(text.ToLower()) || a.GenerateNumber.Contains(text) || a.Phone.Contains(text)) && a.IsPublicUser == 0 && a.DomainID == domain.ID && a.ID != user.ID select a).ToList();
                }
                else if (domainProperties.IsAddultApp == 1 && domainProperties.ExtractUserPhoneContacts == 0)
                {
                    var isUserOrSupplier = from a in db.DomainIDToUsers where a.UserID == user.ID select a;
                    if (isUserOrSupplier.Any())
                    {
                        // take users that are not suppliers
                        hasUsers = db.Users.Where(u => !db.DomainIDToUsers.Select(du => du.UserID).Contains(u.ID) && u.DomainID == user.DomainID &&
                            (u.Name.ToLower().Contains(text.ToLower()) || u.GenerateNumber.Contains(text) || u.Phone.Contains(text))).ToList();
                    }
                    else
                    {
                        //take users that are suppliers
                        hasUsers = db.Users.Where(u => db.DomainIDToUsers.Where(du => du.DomainID == user.DomainID).Select(du => du.UserID).Contains(u.ID)
                            && (u.Name.ToLower().Contains(text.ToLower()) || u.GenerateNumber.Contains(text) || u.Phone.Contains(text))).ToList();
                    }
                }

            }
            var userContactList = new List<ContactListUser>();
            foreach (var user in hasUsers)
            {
                var userDAO = new ContactListUser
                {
                    City = user.City,
                    GeneratedNumber = user.GenerateNumber,
                    Name = user.Name,
                    Pic1 = user.Pic1,
                    SupplierID = user.ID,
                    CountryCode = user.CountryCode,
                    Phone = user.Phone,
                    IsPublicUser = int.Parse(user.IsPublicUser.ToString())
                };
                userContactList.Add(userDAO);
            }

            Response.Write(JsonConvert.SerializeObject(userContactList, Formatting.Indented));
            Response.End();
        }
        else if (Request["qType"] == "44") // get UsersToUsers by specific user
        {
            using (var db = new Entities())
            {
                int CustomerID = int.Parse(Request["CustomerID"].ToString());
                var q = (from a in db.UsersToUsers
                         where a.SupplierID == user.ID && a.CustomerID == CustomerID
                         select a).ToList();
                if (q.Any())
                {

                    Response.Write("1");
                }
                else
                {
                    Response.Write("0");
                }
                Response.End();
            }
        }
        else if (Request["qType"] == "45") // update unanswered calls
        {
            using (var con = databaseCon.create_sql_con())
            {
                if (Request["RndNum"] != null)
                {
                    var rndNum = Request["RndNum"];
                    var command = new SqlCommand("update ChatTimeUse set IsAnswer=1, CallViewStatus=1 where RndNum='" + rndNum + "'", con);
                    command.ExecuteNonQuery();
                    Response.Write("ok");
                    Response.End();
                }
                else
                {
                    var command = new SqlCommand("update ChatTimeUse set CallViewStatus=1 where SupplierID=" + user.ID, con);
                    command.ExecuteNonQuery();
                    Response.Write("ok");
                    Response.End();
                }
            }
        }
        else if (Request["qType"] == "46")//when user want to send message he get his preview data
        {
            using (var db = new Entities())
            {
                //string SupplierToServicePriceGuid = Request["SupplierToServicePriceGuid"];
                int UserGetMessage = int.Parse(Request["UserGetMessage"]);
                float sumUserBalanceInDollar = userClass.getCustomerBalanceInDollar(user.ID);
                Users UserGetMessage_ = (from a in db.Users where a.ID == UserGetMessage select a).First();
                SupplierToServicePrice sp = (from a in UserGetMessage_.SupplierToServicePrice where a.ID == UserGetMessage_.SupplierToServicePriceID select a).First();
                float SumUserTimeCustomerToSupplier = userClass.getSumUserTimeCustomerToSupplier(UserGetMessage, sumUserBalanceInDollar, sp.ID);
                float CountMaxMessage = userClass.getCountIfMessageCustomerToSupplier(user.ID, UserGetMessage, sumUserBalanceInDollar, sp.SupplierToServicePriceGuid);
                // Response.Write("SupplierToServicePriceGuid=" + (from a in db.SupplierToServicePrice where a.SupplierID == user.ID orderby a.ID descending select a).First());

                var SupplierToServicePrice_ = new
                {
                    PricePerMinute = sp.PricePerMinute,
                    PricePerMessage = sp.PricePerMessage,
                    SupplierToServicePriceGuid = sp.SupplierToServicePriceGuid,
                    SumUserTimeCustomerToSupplier = SumUserTimeCustomerToSupplier,
                    CountMaxMessage = CountMaxMessage,
                    SupplierRating = UserGetMessage_.UsersScore
                };

                //var SupplierToServicePrice_ = new
                //{
                //    PricePerMinute = 5.50,
                //    PricePerMessage = 0.20,
                //    SupplierToServicePriceGuid = "803AE349-26E6-4359-8719-4C4CFD848060",
                //    SumUserTimeCustomerToSupplier = 200,
                //    CountMaxMessage = 7
                //};

                Response.Write(JsonConvert.SerializeObject(SupplierToServicePrice_, Formatting.Indented));

            }

            Response.End();
        }

        else if (Request["qType"] == "47") //user hang up
        {
            var rndNum = Guid.Parse(Request["RndNum"]);
            userClass.userEndSession(1, "userClickOut", user.ID, rndNum);
            Response.End();
        }

        else if (Request["qType"] == "48") //get rnd number
        {
            using (var db = new Entities())
            {
                var rndNum = (from a in db.OnlineUsers where a.SupplierID == user.ID select a.RndNumber).FirstOrDefault();
                Response.Write(rndNum);
                Response.End();
            }
        }

        else if (Request["qType"] == "49") //get user phone contacts
        {
            var users = new List<ContactListUser>();
            var usersGoodPhoneNumber = new List<string>();
            var usersInDB = new List<Users>();
            //take users that exist in contact phone list
            if (domainProperties.IsAddultApp == 0 && domainProperties.ExtractUserPhoneContacts == 1)
            {
                string json;//use this when post via raw
                using (var reader = new StreamReader(Request.InputStream))
                {
                    json = reader.ReadToEnd();
                }
                json = Server.HtmlDecode(json);
                users = JsonConvert.DeserializeObject<List<ContactListUser>>(json);
                if (users.Any())
                {
                    foreach (var userContact in users)
                    {
                        if (userContact.Phone.StartsWith("0"))
                        {
                            userContact.Phone = user.CountryCode + userContact.Phone.Substring(1, userContact.Phone.Length - 1);
                        }
                        if (userContact.Phone.StartsWith("+"))
                        {
                            userContact.Phone = userContact.Phone.Substring(1, userContact.Phone.Length - 1);
                        }
                        usersGoodPhoneNumber.Add(userContact.Phone);
                    }
                }
                using (var db = new Entities())
                {
                    usersInDB = (from a1 in db.Users
                                 join a2 in db.DomainIDToUsers on a1.ID equals a2.UserID
                                 where usersGoodPhoneNumber.Contains(a1.Phone) && a1.DomainID == domain.ID
                                 && a1.ID != user.ID
                                 select a1).ToList();
                }
            }
            else if (domainProperties.IsAddultApp == 1 && domainProperties.ExtractUserPhoneContacts == 0)
            {
                using (var db = new Entities())
                {
                    var isUserOrSupplier = from a in db.DomainIDToUsers where a.UserID == user.ID select a;
                    if (isUserOrSupplier.Any())
                    {
                        // take users that are not suppliers
                        usersInDB = db.Users.Where(u => !db.DomainIDToUsers.Select(du => du.UserID).Contains(u.ID) && u.DomainID == user.DomainID).ToList();
                    }
                    else
                    {
                        //take users that are suppliers
                        usersInDB = db.Users.Where(u => db.DomainIDToUsers.Where(du => du.DomainID == user.DomainID).Select(du => du.UserID).Contains(u.ID)).ToList();
                    }
                }
            }
            users.Clear();
            foreach (var item in usersInDB)
            {
                var contactListUser = new ContactListUser
                {
                    City = item.City,
                    Phone = item.Phone,
                    CountryCode = item.CountryCode,
                    GeneratedNumber = item.GenerateNumber,
                    IsPublicUser = item.IsPublicUser,
                    Name = item.Name,
                    Pic1 = item.Pic1,
                    SupplierID = item.ID
                };
                users.Add(contactListUser);
            }
            Response.Write(JsonConvert.SerializeObject(users, Formatting.Indented));
            Response.End();
        }

        else if (Request["qType"] == "50") //set user account properties
        {
            var action = Request["action"];
            var propertyName = Request["propertyName"];
            using (var db = new Entities())
            {
                var userAccountPrperty = new UserAccountProperties();
                var isUserProperty = from a in db.UsersProperties where a.UserID == user.ID && a.PropertyName == propertyName select a;
                if (isUserProperty.Any())
                {
                    var userProperty = isUserProperty.FirstOrDefault();
                    if (action.ToLower() == "hide")
                    {
                        userProperty.IsPublic = 0;
                    }
                    else if (action.ToLower() == "show")
                    {
                        userProperty.IsPublic = 1;
                    }
                    db.Entry(userProperty).State = System.Data.Entity.EntityState.Modified;
                    db.SaveChanges();

                    userAccountPrperty = new UserAccountProperties
                    {
                        PropertyName = userProperty.PropertyName,
                        DateIn = userProperty.DateIn,
                        IsPublic = userProperty.IsPublic,
                        UserID = userProperty.UserID
                    };
                }

                else
                {
                    var userProperty = new UsersProperties
                    {
                        DateIn = DateTime.Now,
                        UserID = user.ID,
                        PropertyName = propertyName
                    };
                    if (action.ToLower() == "hide")
                    {
                        userProperty.IsPublic = 0;
                    }
                    else if (action.ToLower() == "show")
                    {
                        userProperty.IsPublic = 1;
                    }
                    db.UsersProperties.Add(userProperty);
                    db.SaveChanges();
                    userAccountPrperty = new UserAccountProperties
                    {
                        PropertyName = userProperty.PropertyName,
                        DateIn = userProperty.DateIn,
                        IsPublic = userProperty.IsPublic,
                        UserID = userProperty.UserID
                    };
                }
                Response.Write(JsonConvert.SerializeObject(userAccountPrperty, Formatting.Indented));
            }
            Response.End();
        }

        else if (Request["qType"] == "51") //get user account properties
        {
            var userID = int.Parse(Request["mainModelNumber"]);
            using (var db = new Entities())
            {
                var userProperties = from a in db.UsersProperties where a.UserID == userID select a;
                var listOfAccountProperties = new List<UserAccountProperties>();
                foreach (var item in userProperties)
                {
                    var userAccountProperty = new UserAccountProperties
                    {
                        UserID = item.UserID,
                        DateIn = item.DateIn,
                        IsPublic = item.IsPublic,
                        PropertyName = item.PropertyName
                    };
                    listOfAccountProperties.Add(userAccountProperty);
                }

                Response.Write(JsonConvert.SerializeObject(listOfAccountProperties, Formatting.Indented));
            }
            Response.End();

        }

        else if (Request["qType"] == "52") //get user payments
        {
            using (var db = new Entities())
            {
                var date = DateTime.Now.AddYears(-1);
                var userPayments = from a in db.CardCam where a.UserID == user.ID && a.OrderDay >= date select a;
                var userPaymentsList = new List<UserPayments>();

                foreach (var item in userPayments)
                {
                    var userPayment = new UserPayments
                    {
                        DateIn = item.OrderDay,
                        LastDigits = item.Lastdigits,
                        Price = item.PriceInDollar,
                        SupplierID = item.UserID
                    };
                    userPaymentsList.Add(userPayment);
                }
                Response.Write(JsonConvert.SerializeObject(userPaymentsList, Formatting.Indented));
            }
            Response.End();
        }

        else if (Request["qType"] == "53") //get user services
        {
            using (var db = new Entities())
            {
                var date = DateTime.Now.AddYears(-1);
                var userServices = from a in db.UsersToUsersServicesPayments where a.CustomerID == user.ID select a;
                var userServicesList = new List<UserToUserServicePayments>();

                foreach (var item in userServices)
                {
                    var supplierID = (from a in db.SupplierToServicePrice where a.ID == item.SupplierToServicePriceID select a.SupplierID).FirstOrDefault();
                    var userService = new UserToUserServicePayments();
                    userService.CustomerID = user.ID;
                    userService.SupplierID = supplierID;
                    userService.TotalPriceInDollar = item.TotalPriceInDollar;
                    if (item.ChatTimeUseID == 0)
                    {
                        userService.ChatTimeUseGuid = "0";
                        userService.UsersToUsersMessagesGuid = (from a in db.UsersToUsersMessages where a.ID == item.UsersToUsersMessagesID select a.MessageGuid).FirstOrDefault();
                    }
                    else
                    {
                        userService.UsersToUsersMessagesGuid = "0";
                        userService.ChatTimeUseGuid = (from a in db.ChatTimeUse where a.ID == item.ChatTimeUseID select a.RndNum).FirstOrDefault().ToString();
                    }

                    userServicesList.Add(userService);
                }
                Response.Write(JsonConvert.SerializeObject(userServicesList, Formatting.Indented));
            }
            Response.End();
        }

        else if (Request["qType"] == "54") // save payment json
        {
            string json;//use this when post via raw
            using (var reader = new StreamReader(Request.InputStream))
            {
                json = reader.ReadToEnd();
            }
            json = Server.HtmlDecode(json);

            using (var db = new Entities())
            {
                var paymentString = new PaymentStrings
                {
                    Active = 1,
                    DateIn = DateTime.Now,
                    PaymentString = "VERIFIED",
                    PaymentTX = json,
                    UserID = user.ID,
                    TxnType = "Google Play Card",
                    PaymentPlayerID = "AskMe"
                };
                db.PaymentStrings.Add(paymentString);
                db.SaveChanges();
            }
        }



        //else if (Request["qType"] == "47")//SupplierToServicePriceGuid
        //{
        //    using (var db = new Entities())
        //    {
        //        int UserGiveService = int.Parse(Request["UserGiveService"]);
        //        float sumUserBalanceInDollar = userClass.getCustomerBalanceInDollar(user.ID);
        //        var SupplierToServicePrice2= (from a in db.SupplierToServicePrice where a.SupplierID == sumUserBalanceInDollar orderby a.ID descending select a).First();
        //        float SumUserTimeCustomerToSupplier = userClass.getSumUserTimeCustomerToSupplier(UserGiveService, sumUserBalanceInDollar, SupplierToServicePrice2.ID);

        //        //Response.Write("SupplierToServicePriceGuid=" + (from a in db.SupplierToServicePrice where a.SupplierID == user.ID orderby a.ID descending select a).First());

        //        var SupplierToServicePrice_ = new
        //        {
        //            PricePerMinute = SupplierToServicePrice2.PricePerMinute,
        //            SupplierToServicePriceGuid = SupplierToServicePrice2.SupplierToServicePriceGuid,
        //            SumUserTimeCustomerToSupplier = SumUserTimeCustomerToSupplier


        //        };


        //        Response.Write(JsonConvert.SerializeObject(SupplierToServicePrice_, Formatting.Indented));

        //    }

        //    Response.End();
        //}
        else if (Request["qType"] == "55") //upload gallery image file
        {
            //MainModels user = SupplierAPI.getMainModelsByGuid(Guid.Parse(Request["MainModelGuid"]));
            string fileName = Request["imageName"];
            //string imageName=
            foreach (string upload in Request.Files)
            {
                var path = AppDomain.CurrentDomain.BaseDirectory + "/media/Suppliers/gallery/big";
                var file = Request.Files[upload];
                if (file == null) continue;
                //fileName = Guid.NewGuid().ToString() + Path.GetExtension(file.FileName);
                file.SaveAs(Path.Combine(path, fileName));
            }
            UsersPhotos UsersPhotos_ = new UsersPhotos();
            UsersPhotos_.DateIn = DateTime.Now;
            UsersPhotos_.PhotoGuid = fileName;
            UsersPhotos_.UserID = user.ID;
            using (var db = new Entities())
            {
                db.UsersPhotos.Add(UsersPhotos_);
                db.SaveChanges();
            }
            Response.End();
        }
        else if (Request["qType"] == "56") //get user gallery
        {
            using (var db = new Entities())
            {
                var userPhotos = new List<UsersPhotos>();
                if (Request["mainModelNumber"] == null)
                {
                    userPhotos = (from a in db.UsersPhotos where a.UserID == user.ID select a).ToList();
                }
                else
                {
                    var userID = int.Parse(Request["mainModelNumber"]);
                    userPhotos = (from a in db.UsersPhotos where a.UserID == userID select a).ToList();
                }
                var userPhotoList = new List<UserGallery>();
                foreach (var item in userPhotos)
                {
                    var userPhoto = new UserGallery
                    {
                        ImageName = item.PhotoGuid,
                        SupplierID = item.UserID
                    };
                    userPhotoList.Add(userPhoto);
                }
                Response.Write(JsonConvert.SerializeObject(userPhotoList, Formatting.Indented));
            }
            Response.End();
        }

        else if (Request["qType"] == "57") //get usersToDomain
        {
            var domainID = int.Parse(Request["DomainID"]);
            using (var db = new Entities())
            {
                var usersToDomain = from a1 in db.DomainIDToUsers join a2 in db.Users on a1.UserID equals a2.ID where a1.DomainID == domainID && a1.UserID != user.ID select a2;
                var userList = new List<ContactListUser>();
                foreach (var item in usersToDomain)
                {
                    var userP = new ContactListUser
                    {
                        Name = item.Name,
                        SupplierID = item.ID,
                        Pic1 = item.Pic1,
                        AditionalInfo = item.ExtraDetails
                    };
                    userList.Add(userP);
                }
                Response.Write(JsonConvert.SerializeObject(userList, Formatting.Indented));
            }
            Response.End();
        }

        else if (Request["qType"] == "58") // delete user image
        {
            var fileName = Request["fileName"];
            if (!fileName.Contains(".jpg"))
            {
                fileName += ".jpg";
            }
            using (var db = new Entities())
            {
                var file = from a in db.UsersPhotos where a.PhotoGuid == fileName && a.UserID == user.ID select a;

                if (file.Any())
                {
                    db.UsersPhotos.Remove(file.FirstOrDefault());
                    db.SaveChanges();
                }
            }

            var filePath = Server.MapPath("/media/Suppliers/gallery/big/" + fileName);
            if (File.Exists(filePath))
            {
                File.Delete(filePath);
            }
            Response.End();
        }

        else if (Request["qType"] == "59") // get languages
        {
            using (var db = new Entities())
            {
                var languages = from a in db.Languages orderby a.Language select a;
                var languagesList = new List<LanguagePartial>();

                foreach (var item in languages)
                {
                    var languagePartial = new LanguagePartial
                    {
                        Language = item.Language
                    };
                    languagesList.Add(languagePartial);
                }
                Response.Write(JsonConvert.SerializeObject(languagesList, Formatting.Indented));
            }
            Response.End();
        }

        else if (Request["qType"] == "60") // get user languages
        {
            using (var db = new Entities())
            {
                if (Request["SupplierID"] == null)
                {
                    var languages = from a in db.SupplierToLanguages where a.UserID == user.ID orderby a.Languages.Language select a;
                    var languagesList = new List<LanguagePartial>();

                    foreach (var item in languages)
                    {
                        var languagePartial = new LanguagePartial
                        {
                            ID = item.Languages.ID,
                            Language = item.Languages.Language
                        };
                        languagesList.Add(languagePartial);
                    }
                    Response.Write(JsonConvert.SerializeObject(languagesList, Formatting.Indented));
                }
                else
                {
                    var supplierID = int.Parse(Request["SupplierID"]);
                    var languages = from a in db.SupplierToLanguages where a.UserID == supplierID orderby a.Languages.Language select a;
                    var languagesList = new List<LanguagePartial>();

                    foreach (var item in languages)
                    {
                        var languagePartial = new LanguagePartial
                        {
                            ID = item.Languages.ID,
                            Language = item.Languages.Language
                        };
                        languagesList.Add(languagePartial);
                    }
                    Response.Write(JsonConvert.SerializeObject(languagesList, Formatting.Indented));
                }
            }
            Response.End();
        }

        else if (Request["qType"] == "61") // save user languages
        {
            using (var db = new Entities())
            {
                var languageName = Request["language"];
                var language = (from a in db.Languages where a.Language == languageName select a).FirstOrDefault();

                var userLanguage = from a in db.SupplierToLanguages where a.UserID == user.ID && a.LanguageID == language.ID select a;
                if (!userLanguage.Any())
                {
                    if (Request["action"] == "add")
                    {
                        var userLng = new SupplierToLanguages
                        {
                            DateIn = DateTime.Now,
                            LanguageID = language.ID,
                            UserID = user.ID
                        };
                        db.SupplierToLanguages.Add(userLng);
                        db.SaveChanges();
                    }
                }
                else
                {
                    if (Request["action"] == "delete")
                    {
                        db.SupplierToLanguages.Remove(userLanguage.FirstOrDefault());
                        db.SaveChanges();
                    }
                }
            }
            Response.End();
        }
        else if (Request["qType"] == "62") // filter users
        {
            var domainID = int.Parse(Request["DomainID"]);
            var range = int.Parse(Request["range"]);
            var languages = Request["languages"].Split(',').ToList();
            var lat = float.Parse(Request["lat"]);
            var lng = float.Parse(Request["lng"]);
            SqlDataReader result;
            var usersIDs = new List<int>();
            using (var con = databaseCon.create_sql_con())
            {
                SqlCommand cmd = new SqlCommand("Search", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@custLat", SqlDbType.Float).Value = lat;
                cmd.Parameters.Add("@custLng", SqlDbType.Float).Value = lng;
                cmd.Parameters.Add("@range", SqlDbType.Int).Value = range;
                cmd.Parameters.Add("@userID", SqlDbType.Int).Value = user.ID;
                result = cmd.ExecuteReader();
                while (result.Read())
                {
                    usersIDs.Add(int.Parse(result["ID"].ToString()));
                }
            }
            using (var db = new Entities())
            {
                var users = from a in db.Users
                            join a2 in db.DomainIDToUsers on a.ID equals a2.UserID
                            join a3 in db.SupplierToLanguages on a.ID equals a3.UserID
                            where usersIDs.Contains(a.ID) && a2.DomainID == domainID
                            && languages.Contains(a3.Languages.Language)
                            select a;
                users = users.Distinct();

                var userList = new List<ContactListUser>();
                foreach (var item in users)
                {
                    var userP = new ContactListUser
                    {
                        Name = item.Name,
                        SupplierID = item.ID,
                        Pic1 = item.Pic1,
                        AditionalInfo = item.ExtraDetails
                    };
                    userList.Add(userP);
                }
                Response.Write(JsonConvert.SerializeObject(userList, Formatting.Indented));
            }
            Response.End();
        }
        else if (Request["qType"] == "63")
        {
            var DomainsListForApp_ = new DomainsListForApp
            {
                MainAPPActivity = domainProperties.MainAPPActivity,
                AppBackgroundColor = domainProperties.AppBackgroundColor,
                AppBarBackgroundColor = domainProperties.AppBarBackgroundColor,
                RealPhoneView = (int)domainProperties.RealPhoneView,
                ExtractUserPhoneContacts = (int)domainProperties.ExtractUserPhoneContacts,
                AppButtonColor = domainProperties.AppButtonColor,
                AppSplashImage = domainProperties.AppSplashImage,
                IsAddultApp = (int)domainProperties.IsAddultApp,
                AppButtonTextColor = domainProperties.AppButtonTextColor,
                AppSplashIcon = domainProperties.AppSplashIcon
            };
            Response.Write(JsonConvert.SerializeObject(DomainsListForApp_, Formatting.Indented));
            Response.End();
        }
        else if (Request["qType"] == "64") //save rating points
        {
            var supplierID = int.Parse(Request["userNum"]);
            var points = float.Parse(Request["points"]);
            var ratingText = Request["ratingText"];


            using (var con = databaseCon.create_sql_con())
            {
                SqlCommand cmd = new SqlCommand("InsertUserReview", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@customerID", SqlDbType.Int).Value = user.ID;
                cmd.Parameters.Add("@supplierID", SqlDbType.Int).Value = supplierID;
                cmd.Parameters.Add("@points", SqlDbType.Float).Value = points;
                cmd.Parameters.Add("@ratingText", SqlDbType.NVarChar).Value = ratingText;
                cmd.Parameters.Add("@ipAddress", SqlDbType.NVarChar).Value = userClass.extractUserIp();
                cmd.ExecuteNonQuery();
            }

            Response.End();
        }

        else if (Request["qType"] == "65") //get user rating review
        {
            var supplierID = int.Parse(Request["SupplierID"]);
            using (var db = new Entities())
            {
                var userReviews = (from a in db.UsersReview where a.SupplierID == supplierID orderby a.DateIn descending select a).ToList();
                var userReviewList = new List<UserReviewPartial>();
                for (int i = 0; i < userReviews.Count(); i++)
                {
                    var userreview = new UserReviewPartial
                    {
                        ReviewText = userReviews[i].FreeText,
                        Date = userReviews[i].DateIn.ToString("yyyy/MM/dd HH:mm:ss")
                    };
                    userReviewList.Add(userreview);
                }
                Response.Write(JsonConvert.SerializeObject(userReviewList, Formatting.Indented));
            }
            Response.End();
        }
        else if (Request["qType"] == "66") //get user list partial
        {
            var supplierID = int.Parse(Request["SupplierID"]);
            var supplier = populateClassFromDB.getUsers(supplierID);
            var status = populateClassFromDB.getOnlineUsers(supplierID).Online;
            using (var db = new Entities())
            {
                var userListPartial = new UserListPartial
                {
                    LanguageID = (from a in db.SupplierToLanguages where a.UserID == supplierID select a.LanguageID).ToList(),
                    Status = status,
                    SupplierRating = (double)supplier.UsersScore,
                    SupplierToServicePriceGuid = (from a in db.SupplierToServicePrice where a.ID == supplier.SupplierToServicePriceID select a.SupplierToServicePriceGuid).FirstOrDefault().ToString()
                };
                Response.Write(JsonConvert.SerializeObject(userListPartial, Formatting.Indented));
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

    private string GetGirlNameFromNumber(int SupplierID)
    {
        string girlName = "";

        using (var con = databaseCon.create_sql_con())
        {
            var cmd = new SqlCommand("select Name from MainModels where SupplierID=@SupplierID", con);
            cmd.Parameters.Add("@SupplierID", SqlDbType.Int).Value = SupplierID;
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
                var cmd = new SqlCommand("select distinct MainModelGuid as girl_guid from MainModels inner join messages on MainModels.SupplierID = messages.SupplierID  where who_send=0 and isMessageReadInApp=0 and girl_delete = 0 ", con);
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

