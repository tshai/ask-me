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
	public static int? AddNewSupplier(string Phone, string countryCode)
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
				// HttpContext.Current.Response.Write(FullPhone)
				// HttpContext.Current.Response.End()

                var generateNumber = countryCode + Tools.RandomNumber(100000, 999999);
                while (GenerateNumber(generateNumber, countryCode) == "") {
                    generateNumber = countryCode + Tools.RandomNumber(100000, 999999);
                }
                
                user.Phone = FullPhone;
				user.DateIn = DateTime.Now;
				user.Active = 0;
				user.Pic1 = "0";
				user.Name = "Empty";
				user.ExtraDetails = "";
				user.YearBirth = 2000;
				user.Gender = 4;
				user.MinSessionLength = 0;
				user.PricePerMinute = 0;
				user.CurrencyID = 1;


				user.SmsCode = Tools.RandomNumber(111111, 999999);
				user.CountryCode = countryCode;
				user.MainModelGuid = Guid.NewGuid();
				user.Password = user.SmsCode.ToString();
                user.GenerateNumber = generateNumber;
                db.Users.Add(user);
			}
			else
			{
				user = q.First();
                user.NeedUpdate = 1;
				user.SmsCode = Tools.RandomNumber(111111, 999999);
				db.Entry(user).State = EntityState.Modified;
			}
			db.SaveChanges();
			string Answer = Tools.twiloSms(FullPhone, "Ask me password:" + user.SmsCode);
			databaseCon.ExecuteNonQuerySql("INSERT INTO SMSLogs (PhoneNumber,Answer,Processor)VALUES('" + Phone + "', '" + Answer + "' ,'twilio')");
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
