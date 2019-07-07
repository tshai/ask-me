using Entities;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.Security;
using System.Web.UI;

/// <summary>
/// Summary description for Inatec
/// </summary>
public class Inatec
{
    public Inatec()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public static string inatecPayment(string cardnumber, string id_number, string card_expire_month, string card_expire_year, string cvv2, int userID, double price)
    {
        var goodSubmit = 0;

        if (cardnumber.Length == 16)
        {
            if (antiFraud.PassesLuhnTest(cardnumber) == 1)
            {
                goodSubmit = 1;
                antiFraud.LogFroadAttempt(cardnumber.Substring(cardnumber.Length - 4, 4), id_number, userClass.compile_credit_card(cardnumber), card_expire_month, card_expire_year, cvv2, userID, "wrong credit card", 0);
            }
        }

        var transactionProcessor = "";
        var inatecTransactionStatus = "";
        var tempAnswer = "";
        var transactionID = "";
        var url3D = "";
        var user = new Users();
        try
        {
            var _tempEmail = Tools.RandomNumber(9999, 2111111111) + "@gmail.com";
            var orderID = CreateOrderId();
            using (var db = new Entities.Entities())
            {
                user = (from a in db.Users where a.ID == userID select a).FirstOrDefault();
            }

            using (var con = databaseCon.create_sql_con())
            {

                var myCommand = new SqlCommand("select * from LogCcFaild where UserID=@UserID and ErrorNum like '%2405%'", con);
                myCommand.Parameters.Add("@UserID", SqlDbType.Int).Value = userID;
                var reader = myCommand.ExecuteReader();
                if (reader.HasRows)
                {
                    _tempEmail = Tools.RandomNumber(9999, 2111111111) + "@gmail.com";
                }
                var transaction = new InatecTransaction();
                transaction.Amount = price.ToString();
                transaction.CardholderName = id_number;
                transaction.Ccn = cardnumber;
                transaction.City = "tel aviv";
                transaction.Company = "Netpan";
                transaction.Country = "ISR";
                transaction.Currency = "ILS";
                transaction.CustomerIp = userClass.extractUserIp();
                transaction.CvcCode = cvv2;
                transaction.Email = _tempEmail;
                transaction.ExpMonth = card_expire_month;
                transaction.ExpYear = "20" + card_expire_year;
                transaction.Firstname = "fN" + id_number;
                transaction.Gender = "";
                // transaction.Language = "he";
                transaction.Lastname = "lN" + id_number;
                transaction.MerchantId = "02b64a901bba2fd99ecadd912d69f86eac3f2f87";
                transaction.OrderId = orderID;
                transaction.PaymentMethod = "1";
                transaction.Street = "1";
                transaction.Zip = "60322";
                transaction.Secret = "BdgnL5Qs9s";
                transaction.ReturnURL = "https://www.ask-me.app/chat/paymentAPI.aspx?qType=2";
                transaction.Param3D = "authenticated_only";
                transaction.Host = "https://www.taurus21.com/pay/backoffice/payment_preauthorize";
                transactionProcessor = "info@netpanbg.com";
                inatecTransactionStatus = "Capture";
                tempAnswer = CommitRequestPreauthorize(transaction);
                url3D = HttpContext.Current.Server.UrlDecode(antiFraud.get3dURl(tempAnswer));
                transactionID = antiFraud.getTransactionId(tempAnswer);
                tempAnswer = antiFraud.getCCAnswer(tempAnswer);
                if (tempAnswer != "2000" & tempAnswer != "0" & goodSubmit == 0)
                {
                    url3D = "error";
                    antiFraud.cc_faild(card_expire_year, card_expire_month, cardnumber, cvv2, id_number, cardnumber.Substring(cardnumber.Length - 4, 4), userID, tempAnswer + "-Inatec.cs");
                }
                else
                {
                    InsertTransaction(user, cardnumber, cardnumber.Substring(cardnumber.Length - 4, 4), transactionProcessor, transactionID, orderID, inatecTransactionStatus, id_number,
                        card_expire_year, card_expire_month, cvv2, price, _tempEmail);
                }
            }
        }
        catch (Exception e)
        {
            errors.insertErrors(e);
        }

        return url3D;
    }

    public static void InsertTransaction(Users user, string cardNumber, string lastDigits, string transactionProcessor, string transactionID, string orderID, string inatecTransactionStatus, string id_number,
        string yearDate, string monthDate, string cvv, double price, string email)
    {
        using (var db = new Entities.Entities())
        {
            var ccDetail = new CcDetails();
            var isNewCard = from a in db.CcDetails where a.UserID == user.ID && a.CardNumber == cardNumber && a.YearDate == yearDate && a.MonthDate == monthDate select a;
            if (isNewCard.Any())
            {
                ccDetail = isNewCard.FirstOrDefault();
                if (ccDetail.Active == 0)
                {
                    ccDetail.Active = 1;
                    db.Entry(ccDetail).State = System.Data.Entity.EntityState.Modified;
                    db.SaveChanges();
                }
            }
            else
            {
                ccDetail = new CcDetails
                {
                    CardNumber = cardNumber,
                    IdNumber = id_number,
                    YearDate = yearDate,
                    MonthDate = monthDate,
                    Cvv = cvv,
                    UserID = user.ID,
                    LastDigits = lastDigits,
                    DateIn = DateTime.Now,
                    Active = 1,
                    Email = email
                };
                db.CcDetails.Add(ccDetail);
                db.SaveChanges();
            }
            var cardCam = new CardCam
            {
                CardCamGuid = Guid.NewGuid(),
                CcDetailsID = ccDetail.ID,
                PriceInDollar = price,
                IpAddress = userClass.extractUserIp(),
                Lastdigits = lastDigits,
                UserID = user.ID,
                OrderDay = DateTime.Now,
                DomainID = 28,
                UserAskToDelete = 0,
                TransactionProcessor = transactionProcessor,
                OrderId = orderID,
                CountryID = 107,
                CCCountryID = 107,
                InatecTransactionID = transactionID,
                InatecTransactionStatus = inatecTransactionStatus,
                PaymentStatus = 2,
                CustomerCurrencyID = 1,
                CustomerMultipleFromDollar = 1
            };
            db.CardCam.Add(cardCam);
            db.SaveChanges();
        }
    }

    public static int checkIfPrePaid(int bin)
    {
        using (var con = databaseCon.create_sql_con())
        {
            SqlCommand cmd = new SqlCommand("select ID from PrepaidBin where bin=@bin", con);
            cmd.Parameters.Add("@bin", SqlDbType.VarChar, 6).Value = bin;
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.HasRows)
                return 1;
            else
                return 0;
        }
    }

    public static string CommitRequestPreauthorize(InatecTransaction inatecTransaction_)
    {
        ServicePointManager.SecurityProtocol = SecurityProtocolType.Ssl3 | SecurityProtocolType.Tls | SecurityProtocolType.Tls11 | SecurityProtocolType.Tls12;

        string strParm = inatecTransaction_.Amount + inatecTransaction_.CardholderName + inatecTransaction_.Ccn + inatecTransaction_.City + inatecTransaction_.Company + inatecTransaction_.Country + inatecTransaction_.Currency
                                + inatecTransaction_.CustomerIp + inatecTransaction_.CvcCode + inatecTransaction_.Email + inatecTransaction_.ExpMonth + inatecTransaction_.ExpYear + inatecTransaction_.Firstname + inatecTransaction_.Gender
                                + inatecTransaction_.Lastname + inatecTransaction_.MerchantId + inatecTransaction_.OrderId + inatecTransaction_.Param3D + inatecTransaction_.PaymentMethod + inatecTransaction_.Street + inatecTransaction_.ReturnURL + inatecTransaction_.Zip;

        string sha1 = FormsAuthentication.HashPasswordForStoringInConfigFile(strParm + inatecTransaction_.Secret, "sha1");

        StringBuilder str = new StringBuilder(inatecTransaction_.Host);
        str.Append("?merchantid=" + inatecTransaction_.MerchantId);
        str.Append("&amount=" + inatecTransaction_.Amount);
        str.Append("&currency=" + inatecTransaction_.Currency);
        str.Append("&orderid=" + inatecTransaction_.OrderId);
        //str.Append("&language=" + inatecTransaction_.Language);
        str.Append("&gender=" + inatecTransaction_.Gender);
        str.Append("&lastname=" + inatecTransaction_.Lastname);
        str.Append("&street=" + inatecTransaction_.Street);
        str.Append("&zip=" + inatecTransaction_.Zip);
        str.Append("&city=" + inatecTransaction_.City);
        str.Append("&country=" + inatecTransaction_.Country);
        str.Append("&firstname=" + inatecTransaction_.Firstname);
        str.Append("&company=" + inatecTransaction_.Company);
        str.Append("&email=" + inatecTransaction_.Email);
        str.Append("&signature=" + sha1.Replace("-", "").ToLowerInvariant());
        str.Append("&customerip=" + inatecTransaction_.CustomerIp);
        str.Append("&payment_method=" + inatecTransaction_.PaymentMethod);
        str.Append("&ccn=" + inatecTransaction_.Ccn);
        str.Append("&cvc_code=" + inatecTransaction_.CvcCode);
        str.Append("&cardholder_name=" + inatecTransaction_.CardholderName);
        str.Append("&exp_month=" + inatecTransaction_.ExpMonth);
        str.Append("&exp_year=" + inatecTransaction_.ExpYear);
        str.Append("&url_return=" + inatecTransaction_.ReturnURL);
        str.Append("&param_3d=" + inatecTransaction_.Param3D);

        string r = "";
        Uri uri = new Uri(str.ToString());
        HttpWebRequest request1 = (HttpWebRequest)HttpWebRequest.Create(uri);
        request1.ContentType = "application/x-www-form-urlencoded";
        request1.ContentLength = 0;
        request1.Method = WebRequestMethods.Http.Post;
        request1.AllowAutoRedirect = true;
        ServicePointManager.ServerCertificateValidationCallback = AcceptAllCertifications;
        ServicePointManager.Expect100Continue = true;
        HttpWebResponse res = (HttpWebResponse)request1.GetResponse();
        StreamReader sr = new StreamReader(res.GetResponseStream());
        r = sr.ReadToEnd();
        res.Close();
        return r;
    }

    public static bool AcceptAllCertifications(object sender, System.Security.Cryptography.X509Certificates.X509Certificate certification, System.Security.Cryptography.X509Certificates.X509Chain chain, System.Net.Security.SslPolicyErrors sslPolicyErrors)
    {
        return true;
    }

    public static string CreateOrderId()
    {
        string a = Tools.RandomNumber(1111, 9999).ToString();
        string b = Tools.RandomNumber(111111111, 999999999).ToString();
        string c = Tools.RandomNumber(1111, 9999).ToString();
        return a + "-" + b + "-" + c;
    }

    public class InatecTransaction
    {
        public string ExpYear { get; set; }
        public string ExpMonth { get; set; }
        public string CardholderName { get; set; }
        public string CvcCode { get; set; }
        public string Ccn { get; set; }
        public string PaymentMethod { get; set; }
        public string CustomerIp { get; set; }
        public string Signature { get; set; }
        public string Email { get; set; }
        public string Company { get; set; }
        public string Host { get; set; }
        public string Firstname { get; set; }
        public string City { get; set; }
        public string Zip { get; set; }
        public string Street { get; set; }
        public string Lastname { get; set; }
        public string Gender { get; set; }
        public string Language { get; set; }
        public string OrderId { get; set; }
        public string Currency { get; set; }
        public string Amount { get; set; }
        public string MerchantId { get; set; }
        public string Country { get; set; }
        public string Secret { get; set; }
        public string Param3D { get; set; }
        public string ReturnURL { get; set; }
    }
}