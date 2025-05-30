﻿using Entities;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;

/// <summary>
/// Summary description for inChat
/// </summary>
public class inChat
{
    public inChat()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public static string convertToHebrewDate(object obj)
    {
        return DateTime.Parse(obj.ToString()).ToString("dd/MM/yy HH:mm");
    }

    //public static string SendNotification(Users User, string data, int CustomerID)
    //{
    //    //Users User = null;
    //    using (var db = new Entities.Entities())
    //    {
    //        Guid RndNumber = (from a in db.OnlineUsers where a.SupplierID == User.ID select a.RndNumber).FirstOrDefault();
    //        return sendNotifications(User.FToken, data, RndNumber, User, CustomerID);
    //    }
    //    //var main_modelFToken = databaseCon.scalerSql("select ftoken from Users where MainModelGuid='" + MainModelGuid + "'");
    //    //string RndNum= databaseCon.scalerSql("select RndNumber from OnlineUsers where SupplierID='" + SupplierID + "'");

    //}

    public static string SendNotification(Users User, string data, Guid RndNum, int CustomerID)
    {
        //Users User = null;
        using (var db = new Entities.Entities())
        {
            return sendNotifications(User.FToken, data, RndNum, User, CustomerID);
        }
        //var main_modelFToken = databaseCon.scalerSql("select ftoken from Users where MainModelGuid='" + MainModelGuid + "'");
        //string RndNum= databaseCon.scalerSql("select RndNumber from OnlineUsers where SupplierID='" + SupplierID + "'");

    }
    public static string sendNotifications(string fTokens, string data, Guid RndNum, Users User, int CustomerID)
    {
        StringBuilder sb = new StringBuilder();
        sb.Append("{\"to\": \"" + fTokens + "\",");
        sb.Append("\"priority\": \"high\",");
        sb.Append("\"message_id\": \"" + RndNum + "\",");
        sb.Append("\"data\": {");
        sb.Append("\"body\": \"" + data + "\",");
        sb.Append("\"SupplierID\": \"" + User.ID + "\",");
        sb.Append("\"CustomerID\": \"" + CustomerID + "\",");
        sb.Append("\"id\": \"" + Tools.RandomNumber(1, 1000000) + "\",");
        sb.Append("\"title\": \"new message\",");
        sb.Append("\"RndNum\": \"" + RndNum.ToString() + "\",");
        sb.Append("\"icon\": \"myicon\",");
        sb.Append("\"sound\": \"mySound\"}}");
        return webRequestPostToFirebase(sb.ToString());
    }

    public static string webRequestPostToFirebase(string postData)
    {
        // Try
        string Url = "https://fcm.googleapis.com/fcm/send";
        HttpWebRequest httpWReq = (HttpWebRequest)WebRequest.Create(Url);
        Encoding encoding = new UTF8Encoding();
        byte[] data = encoding.GetBytes(postData);
        httpWReq.ProtocolVersion = HttpVersion.Version11;
        httpWReq.Method = "POST";
        httpWReq.ContentType = "application/json";
        httpWReq.Headers.Add(HttpRequestHeader.Authorization, "key=AAAA77y-NYU:APA91bH0tOY-tjGn_vkPDu4GftRtuCdkUjAUxpUMtkWx7l13fAbDN4AmxkXrw8LqD2FIs-uDy3BVx0gCoCPgBBAIiXS_EwNkB8fi77lEIT3GU_RzJ4ZZD1pICOj3fBLhrc_5BSiS3M5J");
        httpWReq.ContentLength = data.Length;
        Stream stream = httpWReq.GetRequestStream();
        stream.Write(data, 0, data.Length);
        stream.Close();
        HttpWebResponse response = (HttpWebResponse)httpWReq.GetResponse();
        string s = response.ToString();
        StreamReader reader = new StreamReader(response.GetResponseStream());
        string jsonresponse = "";
        string temp = null;
        jsonresponse = reader.ReadLine();


        return jsonresponse;
    }

}