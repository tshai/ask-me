<%@ Page Language="C#" Inherits="ApiBase" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="Newtonsoft.Json" %>
<%@ OutputCache Duration="100" Location="Server" VaryByParam="*" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {

        if(Request["qType"] == "28") //upload image from chat
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


        int OnlineStatus = populateClassFromDB.getOnlineUsers(int.Parse(Request["SupplierID"])).Online;

        using (var db = new Entities())
        {
            int UserGetMessage = int.Parse(Request["SupplierID"]);
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
                SupplierRating = UserGetMessage_.UsersScore,
                OnlineStatus=OnlineStatus
            };

            Response.Write(JsonConvert.SerializeObject(SupplierToServicePrice_, Formatting.Indented));

        }


    }
</script>


