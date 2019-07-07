<%@ Page Language="C#" %>

<script runat="server">

    Users user;
    Users supplier;
    String SupplierChatGuid;
    protected void Page_Load(object sender, EventArgs e)
    {
        // support account that receive the call
        supplier = SupplierAPI.getMainModelsByChatGuid(Guid.Parse(Request["SupplierChatGuid"].ToString()));
        SupplierChatGuid = Request["SupplierChatGuid"].ToString();
        //public free user - change this value when user what personal account from witch his users to make the call to support
        //user = SupplierAPI.getMainModelsByNum(1001);
    }

    public string checkIfUserHasPicture(string picture)
    {
        if (picture != "0" && !string.IsNullOrEmpty(picture))
        {
            return "<img src='https://www.ask-me.app/media/suppliers/" + picture + "'/>";

        }
        return "<i class='fas fa-user-circle'></i>";
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <title></title>
    <style>
        .main {
            position: absolute;
            z-index: 2147483647;
            height: auto;
            width: 100%;
            color: var(--main-gray-extra-dark);
            font-size: 16px;
            overflow: hidden;
            position: absolute;
            bottom: 0;
            display: -ms-flexbox;
            display: flex;
            -ms-flex-pack: end;
            justify-content: flex-end;
            -ms-flex-align: end;
            align-items: flex-end;
            -ms-flex-direction: column;
            flex-direction: column;
        }

        #popUp {
            border: none;
            display: block;
            height: 50px !important;
            width: 50px !important;
            position: fixed;
            top: auto;
            left: auto;
            bottom: 24px;
            right: 30px;
            visibility: visible;
            z-index: 2147483647;
            max-height: 100vh;
            max-width: 100vw;
            transition: none 0s ease 0s;
            background: none transparent;
        }

            #popUp i {
                font-size: 50;
                cursor: pointer;
            }

        #popUpMain {
            width: 400px;
            height: auto;
            border: 1px solid #dcd8d8;
            display: -ms-flexbox;
            -ms-flex-direction: column;
            position: relative;
            right: 35px;
            margin-bottom: 35px;
            border-radius: 5px;
            display: none;
        }

        .popUpTop {
            padding: 20px;
            display: -webkit-box;
            background: darkorange;
        }

            .popUpTop img {
                width: 50px;
                height: 50px;
                border-radius: 50%;
            }

            .popUpTop p {
                padding: 10px;
            }

        .popUpContent {
            padding: 20px;
            display: -webkit-box;
        }

        .calling {
            padding: 10px;
        }

        .iconPulse {
            padding-left: 15px;
            padding-right: 15px;
            padding-top: 10px;
            padding-bottom: 10px;
            background: #5da4ed;
            border-radius: 50%;
        }

        .fa-pulse {
            display: inline-block;
            -moz-animation: pulse 2s infinite linear;
            -o-animation: pulse 2s infinite linear;
            -webkit-animation: pulse 2s infinite linear;
            animation: pulse 2s infinite linear;
        }

        @-webkit-keyframes pulse {
            0% {
                opacity: 1;
            }

            50% {
                opacity: 0;
            }

            100% {
                opacity: 1;
            }
        }

        @-moz-keyframes pulse {
            0% {
                opacity: 1;
            }

            50% {
                opacity: 0;
            }

            100% {
                opacity: 1;
            }
        }

        @-o-keyframes pulse {
            0% {
                opacity: 1;
            }

            50% {
                opacity: 0;
            }

            100% {
                opacity: 1;
            }
        }

        @-ms-keyframes pulse {
            0% {
                opacity: 1;
            }

            50% {
                opacity: 0;
            }

            100% {
                opacity: 1;
            }
        }

        @keyframes pulse {
            0% {
                opacity: 1;
            }

            50% {
                opacity: 0;
            }

            100% {
                opacity: 1;
            }
        }
    </style>
</head>
<body>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#popUp').click(function () {
                if ($('#popUpMain').css("display") == "none") {
                    $('#popUpMain').css("display", "block");
                    $('#popUp').css("position", "relative");
                    $('#callPhone').removeClass('fa-phone-square').addClass('fa-times-circle');
                  <%--  var targetUrl = "https://www.ask-me.app/chat/userCore.aspx?userguid=<%=user.UserChatGuid%>&SupplierChatGuid=<%=SupplierChatGuid%>";
                    $.ajax({
                        crossDomain: true,
                        type: 'POST',
                        url: targetUrl, success: function (result) {
                            $("#status").text("Connected");
                        }
                    });--%>
                    $('#frameDiv').html('<iframe src="https://www.ask-me.app/chat/userCore.aspx?UserChatGuid=BCAC1F8D-2A27-40CD-9E6E-F6A1F63BDD31&SupplierChatGuid=<%=SupplierChatGuid%>" style="width:1px;height:1px"></iframe>');
                }
                else {
                    $('#popUpMain').css("display", "none");
                    $('#popUp').css("position", "fixed");
                    $('#callPhone').removeClass('fa-times-circle').addClass('fa-phone-square');
                }
            });
        });
    </script>
    <div class="main">
        <div id="popUpMain">
            <div id="frameDiv"></div>
            <div class="popUpTop">
                <%=checkIfUserHasPicture(supplier.Pic1) %>
                <span><%=supplier.Name %></span>
            </div>
            <div class="popUpContent">
                <div class="calling">
                    <span id="status">Calling...</span>
                </div>
                <div class="iconPulse">
                    <i class="fas fa-microphone fa-pulse"></i>
                </div>
            </div>
        </div>
        <div id="popUp" title="Call">
            <i id="callPhone" class="fas fa-phone-square"></i>
        </div>
    </div>
</body>
</html>
