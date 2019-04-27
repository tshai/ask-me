var name = 'בחורה';
var chat = $.connection.chatHub2019;
$.connection.hub.qs = 'name=' + name + '&RndNumber=5BF05FF5-A8AF-46A9-9B1C-D075F02B1FC3&customerID=0&supplierID=' + SupplierID.trim() + '&whoSend=749&gid=' + supplierGuid.trim() + '&guid=' + supplierGuid.trim() + '';
var localVideo;
var remoteVideo;
var yourConn;
//var stream;
$(document).ready(function () {
    localVideo = document.querySelector("video#video");
    remoteVideo = document.querySelector("video#their-video");
    
    //handleLeave();
    

    chat.client.newMessage = function (message) {
        //console.log(message);
        if (IsJsonString(message) === true) {
            var data = JSON.parse(message);

            switch (data.type) {

                //when somebody wants to call us 
                case "offer":
                    console.log("GET-offer", data.offer);
                    handleOffer(data.offer, data.name);
                    break;
                case "answer":
                    console.log("GET-answer", data.answer);
                    handleAnswer(data.answer);
                    break;
                //when a remote peer sends an ice candidate to us 
                case "cOVAC":
                    console.log("GET-cOVAC", data.answer);
                    connectChat();
                    break;
                case "candidate":
                    console.log("GET-candidate", data.candidate);
                    handleCandidate(data.candidate);
                    break;
                default:
                    break;
            }
            return;
        }
        if (message === "Login") {//just after all signalr happen
            //handleLogin("true", function (x) {

            //    return;
            //});
        }
        else if (message.toString().substring(0, 15) === "updateStatus742")//DATA ABOUT THE CUSTOMER
        {
            //console.log("updateStatus742");
            var tempUserData = message.toString();
            var tempUserDataArray = tempUserData.split("-");
            var var1 = tempUserDataArray[0].split("=");
            var var2 = tempUserDataArray[1].split("=");
            var user_num = var1[1];
            var sumUserTime = var2[1];
            document.getElementById("clientTimeTxt").value = sumUserTime;
            document.getElementById("clientNumTxt").value = user_num;
        }
        //if (message === "newUser98541") {
        //    $("#waitForSuppliers").show();// remove fro test 26/1/2019
        //    return;
        //}
        
    };
    $.connection.hub.start().done(function () {//signal service
        chat.server.generic("Initialize", "Initialize").catch(function (err) {//signal service
            return console.error(err.toString());
        }).then(() => {
            chat.server.generic("Login", "Login").catch(function (err) {//signal service
                
                return console.error(err.toString());
            });
        }).then(() => {
            buildConnection();
        });
      
       
    });






    
});
function closeChat() {
    $.ajax({
        async: false,
        url: "chatApiForApp.aspx?qType=4&girlGuid=" + supplierGuid, success: function (result) {
            if (result == "true") {
                window.close();
            }
            else {
                alert("error");
            }
        }
    });
}
function buildConnection() {
    try {
        window.RTCPeerConnection = window.RTCPeerConnection || window.mozRTCPeerConnection || window.webkitRTCPeerConnection;
        yourConn = new RTCPeerConnection(configuration);//webrtc con
        //yourConn = new RTCPeerConnection({ configuration, sdpSemantics: 'unified-plan' });
    }
    catch (err) {
        logError("er1-" + err.message);
        console.log("er1-" + err.message);
    }
    yourConn.ontrack = function (event) {//event listener
        remoteVideo.srcObject = event.streams[0];
        remoteVideo.onloadedmetadata = function () {
            remoteVideo.play();
        };
    };
    // Setup ice handling 
    yourConn.onicecandidate = function (event) {
        if (event.candidate) {
            chat.server.generic("wrtc", JSON.stringify({
                type: "candidate",
                candidate: event.candidate
            })).catch(function (err) {
                //alert(err.toString());
                console.error(err.toString());
            });
        }
    };
    yourConn.onconnectionstatechange = function (event) {
        switch (yourConn.connectionState) {
            case "connected":
                console.log("The connection has become fully connected");
                break;
            case "disconnected":
                console.log("The connection disconnected");
                //alert("aa")
                ReconnectChat();
                break;
            case "failed":
                console.log("The connection failed");
                break;
            case "closed":
                console.log("The connection closed");
                break;
        }
    };
    handleLogin("true", function (x) {
        startChat();
        return;
    });
}
function connectChat() {
    //connectedUser = 'ss';
    yourConn.createOffer(function (offer) {

        chat.server.generic("wrtc", JSON.stringify({//send offer to the customer
            type: "offer",
            offer: offer
        })).catch(function (err) {
            return console.error(err.toString());
        });
        console.log("offer:" + offer);
        yourConn.setLocalDescription(offer);
    }, function (error) {
        console.log("Error when creating an offer");
    });
}
function ReconnectChat() {
    buildConnection();
    connectChat();
   
}
function sendConnectToUser() { //after user enter chat and supplier accept we send message to user using webscoket
    chat.server.generic("wrtc", JSON.stringify({
        type: "supplierAcceptChat",
        answer: "ok"
    })).catch(function (err) {
        return console.error(err.toString());
    });
}


//when we got an answer from a remote user
function handleAnswer(answer) {
    try {
        window.RTCSessionDescription = window.RTCSessionDescription || window.mozRTCSessionDescription || window.webkitRTCSessionDescription;
        yourConn.setRemoteDescription(new window.RTCSessionDescription(answer));
    }
    catch (err) {
        logError(err.message);
    }
}

//when we got an ice candidate from a remote user 
function handleCandidate(candidate) {
    try {
        window.RTCIceCandidate = window.RTCIceCandidate || window.mozRTCIceCandidate || window.webkitRTCIceCandidate;
        yourConn.addIceCandidate(new window.RTCIceCandidate(candidate));
    }
    catch (err) {
        logError(err.message);
    }
}

function handleLogin(success,callback) {//this return from pjs
    if (success === false) {
        console.log("Ooops...try a different username");
    } else {

        navigator.mediaDevices.getUserMedia({ video: true, audio: true })
            .then(function (myStream) {
                localVideo.srcObject = myStream;
                myStream.getTracks().forEach(track => yourConn.addTrack(track, myStream));
                callback('true');
            })
            .catch(function (err) {
                console.log(err.message);
            });

    }
}
function myTimer() {
    chat.server.generic("update", "update257-1").catch(function (err) {
        return console.error(err.toString());
    });
}