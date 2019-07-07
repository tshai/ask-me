using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.SqlClient;
using System.Linq;
using Entities;
using Newtonsoft.Json;

public class SupplierAPI
{
    public static int? AddNewSupplier(string Phone, string countryCode,int DomainID)
    {
        if (Phone.Substring(0, 1) == "0")
            Phone = Phone.Substring(1, Phone.Length - 1);
        var FullPhone = countryCode + Phone;
        FullPhone = FullPhone.Trim();
        using (Entities.Entities db = new Entities.Entities())
        {
            var q = (from a in db.Users
                     where a.Phone == FullPhone
                     select a);
            Users user = new Users();
            if (q.Any() == false)
            {
                var generateNumber = countryCode + Tools.RandomNumber(100000, 999999);
                while (GenerateNumber(generateNumber, countryCode) == "")
                {
                    generateNumber = countryCode + Tools.RandomNumber(100000, 999999);
                }

                user.Phone = FullPhone;
                user.DateIn = DateTime.Now;
                user.Active = 0;
                user.Pic1 = "0";
                user.Name = "Empty";
                user.ExtraDetails = "";
                user.YearBirth = 1900; //not selected
                user.Gender = 4;//not selected
                user.CustomerCurrencyID = 1;
                user.SmsCode = 111111;
                //user.SmsCode = Tools.RandomNumber(111111, 999999);
                user.CountryCode = countryCode;
                user.MainModelGuid = Guid.NewGuid();
                user.Password = user.SmsCode.ToString();
                user.GenerateNumber = generateNumber;
                user.UserChatGuid = Guid.NewGuid();
                user.IsSupplier = 0;
                user.SubscriptionIsActive = 0;
                user.SubscriptionType = 0;
                user.CustomerCurrencyID = (from a1 in db.DomainsList where a1.ID == 28 select a1.CountryList.CurrencyID).First();
                user.DomainID = DomainID;
                db.Users.Add(user);
                db.SaveChanges();

                SupplierToServicePrice SupplierToServicePrice_ = new SupplierToServicePrice();
                SupplierToServicePrice_.DateIn = DateTime.Now;
                SupplierToServicePrice_.PricePerMessage = 0;
                SupplierToServicePrice_.PricePerMinute = 0;
                SupplierToServicePrice_.SupplierID = user.ID;
                SupplierToServicePrice_.SupplierToServicePriceGuid = Guid.NewGuid();
                SupplierToServicePrice_.CurrencyID = user.CustomerCurrencyID;
                db.SupplierToServicePrice.Add(SupplierToServicePrice_);
                db.SaveChanges();

                user.SupplierToServicePriceID = SupplierToServicePrice_.ID;
                db.Entry(user).State = EntityState.Modified;
                db.SaveChanges();

                OnlineUsers OnlineUsers_ = new OnlineUsers();
                OnlineUsers_.SupplierID = user.ID;
                OnlineUsers_.CustomerID = 1;
                OnlineUsers_.FreeChat = 0;
                OnlineUsers_.LastCustomerID = 1;
                OnlineUsers_.SupplierGettingCustomer = 0;
                OnlineUsers_.LastStatusChange = DateTime.Now;
                OnlineUsers_.SupplierLastVisit = DateTime.Now;
                OnlineUsers_.Online = 0;
                OnlineUsers_.RndNumber = Guid.NewGuid();
                OnlineUsers_.SumUserTime = 0;
                OnlineUsers_.LiveMessage = 0;
                OnlineUsers_.IsQA = 0;
                OnlineUsers_.TimeTheChatStart = DateTime.Now;
                OnlineUsers_.CustomerLastVisit = DateTime.Now;

                db.OnlineUsers.Add(OnlineUsers_);
                db.SaveChanges();

            }
            else
            {
                user = q.First();
                user.NeedUpdate = 1;
                //user.SmsCode = Tools.RandomNumber(111111, 999999);
                user.SmsCode = 111111;
                db.Entry(user).State = EntityState.Modified;
                db.SaveChanges();
            }

            if (Phone != "879274757")
            {
                //string Answer = Tools.twiloSms(FullPhone, "Ask me password:" + user.SmsCode);
                //databaseCon.ExecuteNonQuerySql("INSERT INTO SMSLogs (PhoneNumber,Answer,Processor)VALUES('" + Phone + "', '" + Answer + "' ,'twilio')");
            }
            return user.SmsCode;
        }
    }

    public static string GenerateNumber(string number, string countryCode)
    {
        using (var db = new Entities.Entities())
        {
            var c = from a in db.Users where a.GenerateNumber == number select a;
            if (c.Any() == false)
            {
                return number;
            }
        }
        return "";
    }

    public static string ValidateSMSPassword(string Phone, string countryCode, int password)
    {
        if (Phone.Substring(0, 1) == "0")
            Phone = Phone.Substring(1, Phone.Length - 1);
        var FullPhone = countryCode + Phone;
        FullPhone = FullPhone.Trim();
        using (Entities.Entities db = new Entities.Entities())
        {
            var q = (from a in db.Users
                     where a.Phone == FullPhone & a.SmsCode == password
                     select a);
            Users user = new Users();
            if (q.Any() == false)
                return "0";
            else
            {
                user = q.First();
                user.Password = user.SmsCode.ToString();
                user.SmsActivation = 1;
                db.Entry(user).State = EntityState.Modified;
                db.SaveChanges();
                return user.MainModelGuid.ToString();
            }
        }
    }
    public static Users getMainModelsByGuid(Guid MainModelGuid)
    {
        using (Entities.Entities db = new Entities.Entities())
        {
            return (from a in db.Users
                    where a.MainModelGuid == MainModelGuid
                    select a).FirstOrDefault();
        }
    }

    public static Users getMainModelsByChatGuid(Guid MainModelGuid)
    {
        using (Entities.Entities db = new Entities.Entities())
        {
            return (from a in db.Users
                    where a.UserChatGuid == MainModelGuid
                    select a).FirstOrDefault();
        }
    }

    public static Users getMainModelsByNum(int SupplierID)
    {
        using (Entities.Entities db = new Entities.Entities())
        {
            return (from a in db.Users
                    where a.ID == SupplierID
                    select a).FirstOrDefault();
        }
    }

    public static int CheckIfSupplierActive(Guid MainModelGuid)
    {
        using (Entities.Entities db = new Entities.Entities())
        {
            Users user = getMainModelsByGuid(MainModelGuid);
            if (user.IsSupplier == 1 && user.Active == 0 && user.AdminApprovedCard == 0)
            {
                return 0;
            }
            return 1;
        }
    }

    public static string CreateNewModels(Guid MainModelGuid)
    {
        using (var con = databaseCon.create_sql_con())
        {
            SqlCommand cmd = new SqlCommand("admin1", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@SupplierID", SqlDbType.Int).Value = getMainModelsByGuid(MainModelGuid).ID;
            cmd.Parameters.Add("@q_type", SqlDbType.Int).Value = 42;
            try
            {
                cmd.ExecuteNonQuery();
                return "1";
            }
            catch (Exception ex)
            {
                errors.insertErrors(ex);
                return "0";
            }
        }
    }


    public static string ReverseGeocoding(string Longitude, string Latitude)
    {
        string Url = "https://eu1.locationiq.com/v1/reverse.php?key=797c56623a5364&lat=" + Latitude + "&lon=" + Longitude + "&format=json";
        var address = Tools.webRequest(Url);
        RootObject m = JsonConvert.DeserializeObject<RootObject>(address);
        return m.address.city;
    }


    //public static string getOnlineBySupplierID(int SupplierID)
    //{
    //    using (var con = databaseCon.create_sql_con())
    //    {
    //        var cmd = new SqlCommand("select Online from OnlineUsers where SupplierID=@SupplierID", con);
    //        cmd.Parameters.Add("@SupplierID", SqlDbType.Int).Value = SupplierID;
    //        return cmd.ExecuteScalar().ToString();

    //    }
    //}
}

public class Address
{
    public string garden { get; set; }
    public string road { get; set; }
    public string suburb { get; set; }
    public string city { get; set; }
    public string state { get; set; }
    public string postcode { get; set; }
    public string country { get; set; }
    public string country_code { get; set; }
}

public class RootObject
{
    public string place_id { get; set; }
    public string licence { get; set; }
    public string osm_type { get; set; }
    public string osm_id { get; set; }
    public string lat { get; set; }
    public string lon { get; set; }
    public string display_name { get; set; }
    public Address address { get; set; }
    public List<string> boundingbox { get; set; }
}
