using Mailjet.Client;
using Mailjet.Client.Resources;
using Newtonsoft.Json.Linq;
using SendGrid;
using SendGrid.Helpers.Mail;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.Threading.Tasks;
using System.Web;

/// <summary>
/// Summary description for Mailing
/// </summary>
public class Mailing
{
    public Mailing()
    {
    }

    public static bool addUserToSentMail(int userID, string siteName, int postEmailID)
    {
        bool added = true;
        using (var con = databaseCon.create_sql_con())
        {
            SqlCommand com = new SqlCommand("insert into usersMails (user_num,domianName,PoestEmailId)  values (@user_num,@domianName,@PoestEmailId)", con);
            com.Parameters.Add("@PoestEmailId", SqlDbType.Int).Value = postEmailID;
            com.Parameters.Add("@user_num", SqlDbType.Int).Value = userID;
            com.Parameters.Add("@domianName", SqlDbType.VarChar).Value = siteName;
            try
            {
                com.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                added = false;
            }
        }

        return added;
    }

    public static string EmailSectionShared(string headerMessage, string bodyMessage, string bodyButton, string footerMessage)
    {
        StringBuilder sb = new StringBuilder();
        sb.Append("<html><body ><table style='width:100%;background-image: url(https://www.live-interview.com/media/images/email-back.png);background-repeat:repeat;padding-top:30px;padding-bottom:30px;'><tr><td><table style='text-align:left;direction:left;margin: auto;background-color: #fdfdfd;width: 80%;height: 400px;text-align: center;display: table;border-top: 7px solid #26ae61;border-bottom: 7px solid #26ae61;box-shadow: 3px 3px 8px 0px #e4e4e4;'>");

        sb.Append("<tr><td><div style='width:100%;height:60px;line-height:60px;text-align:center;font-size:30px;font-weight: bold;font-family: sans-serif;color: #666;'>Live-interview.com</div></td></tr>");
        sb.Append("<tr><td><div style='width:100%;height:300px;text-align:center;font-size:30px;font-weight:bold;'><table style='margin:auto'><tr><td style='border-radius:10px;opacity:0.5;background-image:url(https://www.live-interview.com/media/images/emailImage.jpg);width:300px;height:226px'></td></tr></table></div></td></tr>");
        // sb.Append("<tr><td style='width:100%;height: 226px;background-image: url(https://www.live-interview.com/media/images/emailImage.jpg);background-size: 300px 229px;background-repeat:no-repeat;border-bottom: 3px solid #26ae61;display:block'></td></tr>")
        sb.Append("<tr><td style='margin-top:20px;margin-bottom:20px;margin-right:auto;margin-left:auto;text-align:center;font-size:16px;padding-left:16px; padding-right:16px'>" + headerMessage + "</td></tr>");
        sb.Append("<tr><td style='width: 200px;padding: 10px;border-bottom: 1px solid #e6e6e6;text-align:center;font-size: 12px;'>");
        sb.Append(bodyMessage);
        sb.Append("</td></tr>");
        sb.Append("<tr><td><div style='width:200px;margin:20px auto;background-color:#26ae61;padding: 10px;text-decoration:none;color:white;border-radius:5px;;text-align:center;'>");
        sb.Append(bodyButton);
        sb.Append("</div></td></tr>");
        sb.Append("<tr><td style='padding: 5px;;text-align:center;font-size:12px'>");
        sb.Append(footerMessage);
        sb.Append("</td></tr>");
        sb.Append("<tr><td style='border-top: 1px solid #ececec;'>");
        sb.Append("<div style ='width:100%;height:60px;text-align:center;font-size:30px;font-family: sans-serif;color: #666;'>" + populateClassFromDB.GetSiteMessagesByKey("companyAddressData") + "</div>");
        sb.Append("<div style ='width:100%;line-height:40px;text-align:center;font-size:30px;font-weight: bold;font-family: sans-serif;color: #666;'><ul style='list-style-type: none;display: table;width: 40%;margin: auto;opacity: 0.5;margin-top: 30px;'><li style='float:left;width:33%;opacity:0.6;margin: 0;'><a href='https://www.facebook.com/videointerview1'><img src='https://www.live-interview.com/media/images/facebook.png'></a></li><li style='float:left;width:33%;opacity:0.6;margin: 0;'><a href='https://www.linkedin.com/company/live-interview/'><img src='https://www.live-interview.com/media/images/linkedin.png'></a></li><li style='float:left;width:33%;opacity:0.6;margin: 0;'><a href='https://www.youtube.com/channel/UCqHCb6tpjUA9MUz_G40yuqg'><img src='https://www.live-interview.com/media/images/googleplus.png'></a></li></ul></div></td></tr>");
        sb.Append("</table></td></tr></table></body></html>");
        // HttpContext.Current.Response.Write(sb.ToString())
        // HttpContext.Current.Response.End()
        return sb.ToString();
    }

    public static void emailTicket(string emailTo, string serverName, string message, string sGuid, string imageName, Guid employeeGuid, string domainName)
    {
        StringBuilder sbHeader = new StringBuilder();
        sbHeader.Append("<div style='font-size: 15px;text-decoration: underline;'>" + populateClassFromDB.GetSiteMessagesByKey("SupportCorresponding") + ": </div><br/><br/>");
        sbHeader.Append("<div style='unicode-bidi: plaintext;'>" + message + "</div><br>");
        if (imageName != "0")
            sbHeader.Append("<br><img src='https://" + HttpContext.Current.Request.Url.Host + "/media/customersTickets/" + imageName + "'>");
        var emailHeader = sbHeader.ToString();
        var emailBody = "<div></div>";
        var emailButton = "<a href='https://" + HttpContext.Current.Request.Url.DnsSafeHost + "/"
                 + domainName + "/main/readCorrespondenceHistory.aspx?sGuid=" + sGuid.ToString() + "&employeeGuid=" + employeeGuid.ToString() + "&action=read' style='text-decoration:none;color:white;font-weight:bold'>" + populateClassFromDB.GetSiteMessagesByKey("ClickToReply") + "</a>";
        var emailFooter = "<div style='margin-bottom:10px;'>" + populateClassFromDB.GetSiteMessagesByKey("dontAnswerHere") + "</div><div style='background-color: #dcd7db;padding: 5px;'>" + populateClassFromDB.GetSiteMessagesByKey("liveInterviewContacts") + "</div>";
        dbClass.Email email_ = new dbClass.Email();
        email_.body = EmailSectionShared(emailHeader, emailBody, emailButton, emailFooter);
        email_.subject = HttpContext.Current.Server.HtmlDecode(populateClassFromDB.GetSiteMessagesByKey("mailTicketTitle")) + sGuid.ToString();
        email_.from = "support@" + serverName;
        email_.to = emailTo.Trim();
        try
        {
            Mailing.SendEmailClass(email_);
        }
        catch (Exception ex)
        {
            errors.insertErrors(ex);
        }
    }
   
   
    public static void employeeForgetPassword(string emailTo, string serverName, Guid forgetPasswordGuid)
    {
        StringBuilder sbHeader = new StringBuilder();
        sbHeader.Append(populateClassFromDB.GetSiteMessagesByKey("greeting") + "<br/><br/>");
        sbHeader.Append(populateClassFromDB.GetSiteMessagesByKey("RestorePasswordToInterviewerHeader"));
        var emailHeader = sbHeader.ToString();
        var emailBody = "";
        var emailButton = "<a href='https://" + HttpContext.Current.Request.Url.DnsSafeHost + "/" + HttpContext.Current.Session["domainName"] + "/companies/createNewPassword.aspx?forgetPasswordGuid=" + forgetPasswordGuid.ToString() + "' style='text-decoration:none;color:white'>" + populateClassFromDB.GetSiteMessagesByKey("changePasswordButton") + "</a>";
        var emailFooter = "<div style='background-color: #dcd7db;padding: 5px;'>" + populateClassFromDB.GetSiteMessagesByKey("liveInterviewContacts") + "</div>";
        dbClass.Email email_ = new dbClass.Email();
        email_.body = EmailSectionShared(emailHeader, emailBody, emailButton, emailFooter);
        email_.subject = HttpContext.Current.Server.HtmlDecode(populateClassFromDB.GetSiteMessagesByKey("RestorePasswordToInterviewer")) + " - " + serverName;
        email_.from = "no-reply@" + serverName;
        email_.to = emailTo.Trim();
        try
        {
            Mailing.SendEmailClass(email_);
        }
        catch (Exception ex)
        {
            errors.insertErrors(ex.InnerException);
        }
    }
    public static void customerForgetPassword(string emailTo, string serverName, Guid forgetPasswordGuid)
    {
        StringBuilder sbHeader = new StringBuilder();
        sbHeader.Append(populateClassFromDB.GetSiteMessagesByKey("greeting") + "<br/><br/>");
        sbHeader.Append(populateClassFromDB.GetSiteMessagesByKey("RestorePasswordToInterviewerHeader"));
        var emailHeader = sbHeader.ToString();
        var emailBody = "";
        var emailButton = "<a href='https://" + HttpContext.Current.Request.Url.DnsSafeHost + "/" + HttpContext.Current.Session["domainName"] + "/customers/createNewPassword.aspx?forgetPasswordGuid=" + forgetPasswordGuid.ToString() + "'style='text-decoration:none;color:white'>" + populateClassFromDB.GetSiteMessagesByKey("changePasswordButton") + "</a>";
        var emailFooter = "<div style='background-color: #dcd7db;padding: 5px;'>" + populateClassFromDB.GetSiteMessagesByKey("liveInterviewContacts") + "</div>";
        dbClass.Email email_ = new dbClass.Email();
        email_.body = EmailSectionShared(emailHeader, emailBody, emailButton, emailFooter);
        email_.subject = HttpContext.Current.Server.HtmlDecode(populateClassFromDB.GetSiteMessagesByKey("RestorePasswordToInterviewer")) + " - " + serverName;
        email_.from = "no-reply@" + serverName;
        email_.to = emailTo.Trim();
        try
        {
            Mailing.SendEmailClass(email_);
        }
        catch (Exception ex)
        {
            errors.insertErrors(ex);
        }
    }
    
   
    public static void messageTOEmployee(string emailTo, string serverName,string CustomerEmail, string message, string messagesubject, string link)
    {
        dbClass.Email email_ = new dbClass.Email();
        var emailHeader = message;
        var emailBody = "";
        var emailButton = "<a href='https://" + HttpContext.Current.Request.Url.DnsSafeHost + "/" + HttpContext.Current.Session["domainName"] + "/" + link + "' style='text-decoration:none;color:white'>" + populateClassFromDB.GetSiteMessagesByKey("PressToEnter") + "</a>";
        var emailFooter = "<div style='background-color: #dcd7db;padding: 5px;'>" + populateClassFromDB.GetSiteMessagesByKey("liveInterviewContacts") + "</div>";
        email_.body = EmailSectionShared(emailHeader, emailBody, emailButton, emailFooter);
        email_.subject = HttpContext.Current.Server.HtmlDecode(messagesubject);
        email_.from = "no-reply@" + serverName;
        email_.to = emailTo.Trim();
        try
        {
            Mailing.SendEmailClass(email_);
        }
        catch (Exception ex)
        {
            HttpContext.Current.Response.Write(ex.StackTrace);
            errors.insertErrors(ex);
        }
    }
   
   
    public static void companyEmailActivation(string emailTo, string serverName, Guid employeeGuid)
    {
        StringBuilder sbHeader = new StringBuilder();
        sbHeader.Append(populateClassFromDB.GetSiteMessagesByKey("greeting") + "<br/><br/>");
        sbHeader.Append("<div style='unicode-bidi: plaintext;'>" + populateClassFromDB.GetSiteMessagesByKey("WelcomeToTheSite") + " live-interview.com." + "</div><br>");
        sbHeader.Append(populateClassFromDB.GetSiteMessagesByKey("activateAccount"));
        var emailHeader = sbHeader.ToString();
        var emailBody = "";
        var emailButton = "<a href='https://" + HttpContext.Current.Request.Url.DnsSafeHost + "/" + HttpContext.Current.Session["domainName"] + "/companies/companyClass1.login.aspx?employeeGuid=" + employeeGuid.ToString() + "' style='text-decoration:none;color:white'>" + populateClassFromDB.GetSiteMessagesByKey("PressToActivate") + "</a>";
        var emailFooter = "<div style='background-color: #dcd7db;padding: 5px;'>" + populateClassFromDB.GetSiteMessagesByKey("liveInterviewContacts") + " </div>";
        dbClass.Email email_ = new dbClass.Email();
        email_.body = EmailSectionShared(emailHeader, emailBody, emailButton, emailFooter);
        email_.subject = HttpContext.Current.Server.HtmlDecode(populateClassFromDB.GetSiteMessagesByKey("LinkToActivateYourAccount")) + " - " + serverName;
        email_.from = "no-reply@" + serverName;
        email_.to = emailTo.Trim();
        try
        {
            Mailing.SendEmailClass(email_);
        }
        catch (Exception ex)
        {
            errors.insertErrors(ex);
        }
    }
    public static void CustomerEmailActivation(string emailTo, string serverName, Guid customerGuid)
    {
        StringBuilder sbHeader = new StringBuilder();
        sbHeader.Append(populateClassFromDB.GetSiteMessagesByKey("greeting") + "<br/><br/>");
        sbHeader.Append("<div style='unicode-bidi: plaintext;'>" + populateClassFromDB.GetSiteMessagesByKey("WelcomeToTheSite") + " live-interview.com." + "</div><br>");
        sbHeader.Append(populateClassFromDB.GetSiteMessagesByKey("activateAccount"));
        var emailHeader = sbHeader.ToString();
        var emailBody = "";
        var emailButton = "<a href='https://" + HttpContext.Current.Request.Url.DnsSafeHost + "/" + HttpContext.Current.Session["domainName"] + "/customers/customerClass1.login.aspx?customerGuid=" + customerGuid.ToString() + "' style='text-decoration:none;color:white'>" + populateClassFromDB.GetSiteMessagesByKey("PressToActivate") + "</a>";
        var emailFooter = "<div style='background-color: #dcd7db;padding: 5px;'>" + populateClassFromDB.GetSiteMessagesByKey("liveInterviewContacts") + " </div>";
        dbClass.Email email_ = new dbClass.Email();
        email_.body = EmailSectionShared(emailHeader, emailBody, emailFooter, emailFooter);
        email_.subject = HttpContext.Current.Server.HtmlDecode(populateClassFromDB.GetSiteMessagesByKey("LinkToActivateYourAccount")) + "-" + serverName;
        email_.from = "no-reply@" + serverName;
        email_.to = emailTo.Trim();
        try
        {
            Mailing.SendEmailClass(email_);
        }
        catch (Exception ex)
        {
            errors.insertErrors(ex);
        }
    }
    
    private static async void RunAsync(dbClass.Email email)
    {
        MailjetClient client = new MailjetClient("9b222624bc43aa9bf6ca7bdfc17df47b", "1447564692a9539122c8a5be2ee3658b")
        {
            Version = ApiVersion.V3_1
        };
        MailjetRequest request = new MailjetRequest()
        {
            Resource = Send.Resource
        }.Property(Send.Messages, new JArray()
    {
        new JObject()
        {
            {
                "From",
                new JObject()
                {
                    {
                        "Email",
                        "pilot@mailjet.com"
                    },
                    {
                        "Name",
                        "Mailjet Pilot"
                    }
                }
            },
            {
                "To",
                new JArray()
                {
                    new JObject()
                    {
                        {
                            "Email",
                            "raiifert@gmail.com"
                        },
                        {
                            "Name",
                            "passenger 1"
                        }
                    }
                }
            },
            {
                "Subject",
                "Your  dbClass.Emailflight plan!"
            },
            {
                "TextPart",
                "Dear passenger 1, welcome to Mailjet! May the delivery force be with you!"
            },
            {
                "HTMLPart",
                "<h3>Dear passenger 1, welcome to Mailjet!</h3><br />May the delivery force be with you!"
            }
        }
    });
        // Dim response As MailjetResponse = Await client.PostAsync(request)
        var response = await client.PostAsync(request);
        HttpContext.Current.Response.Write(response.GetErrorMessage());
        HttpContext.Current.Response.End();
        if (response.IsSuccessStatusCode)
        {
            errors.addErrorString(string.Format(@"Total: {0}, Count: {1}\n", response.GetTotal(), response.GetCount()));
            errors.addErrorString(response.GetData().ToString());
        }
        else
        {
            errors.addErrorString(string.Format(@"StatusCode: {0}\n", response.StatusCode));
            errors.addErrorString(string.Format(@"ErrorInfo: {0}\n", response.GetErrorInfo()));
            errors.addErrorString(response.GetData().ToString());
            errors.addErrorString(string.Format(@"ErrorMessage: {0}\n", response.GetErrorMessage()));
        }
    }

    public static string SendEmailClass(dbClass.Email email)
    {
        MailMessage msg = new MailMessage(email.from, email.to);
        msg.Subject = email.subject;
        msg.IsBodyHtml = true;
        msg.Body = email.body;
        msg.From = new MailAddress(email.from);
        msg.To.Add(email.to);
        SmtpClient smtp = new SmtpClient("in-v3.mailjet.com");
        smtp.Port = 25;
        smtp.Port = 587;
        smtp.Credentials = new NetworkCredential("9b222624bc43aa9bf6ca7bdfc17df47b", "1447564692a9539122c8a5be2ee3658b");
        //smtp.Send(msg);

        return "mail Sent";
    }
}