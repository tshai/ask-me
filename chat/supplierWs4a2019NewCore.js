var name = 'בחורה';
//var chat = $.connection.chatHub2019Test;
var connection = new signalR.HubConnectionBuilder().withUrl("https://www.ask-me.app/Core/ChatHub2019V2").build();
var localVideo;
var remoteVideo;
var yourConn;
//var stream;
$(document).ready(function () {
    localVideo = document.querySelector("video#video");
    remoteVideo = document.querySelector("video#their-video");

    //handleLeave();



    connection.on("SendMessage", function (message) {
        //console.log(message);
        if (IsJsonString(message) === true) {
            var data = JSON.parse(message);

            switch (data.type) {

                //when somebody wants to call us 
                //case "offer":
                //    console.log("GET-offer", data.offer);
                //    handleOffer(data.offer, data.name);
                //    break;
                case "answer":
                    console.log("GET-answer", data.answer);
                    handleAnswer(data);
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
        };
        //if (message === "newUser98541") {
        //    $("#waitForSuppliers").show();// remove fro test 26/1/2019
        //    return;
        //}

    });
    connection.start().catch(function (err) {
        return console.error(err.toString());
    }).then(() => {
        connection.invoke("Generic", "Initialize", "testMessage", supplierGuid, "0", SupplierID, "749",supplierGuid).catch(function (err) {
            return console.log(err.message);
        });
    }).then(() => {
        connection.invoke("Generic", "Login", "Login", supplierGuid, "0", SupplierID, "749", supplierGuid).catch(function (err) {
            return console.log(err.message);
        });
    }).then(() => {
        buildConnection();
    });
});


    //$.connection.hub.start().done(function () {//signal service
    //    chat.server.Generic("Initialize", "Initialize").catch(function (err) {//signal service
    //        return console.error(err.toString());
    //    }).then(() => {
    //        chat.server.Generic("Login", "Login").catch(function (err) {//signal service

    //            return console.error(err.toString());
    //        });
    //    }).then(() => {
    //        buildConnection();
    //    });


    //});






    

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
            connection.invoke("Generic", "Wrtc", JSON.stringify({
                type: "candidate",
                candidate: event.candidate
            }), supplierGuid, "0", SupplierID, "749", supplierGuid).catch(function (err) {
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
        connection.invoke("Generic", "Wrtc", JSON.stringify({
            type: "offer",
            "sdp": offer.sdp
        }), supplierGuid, "0", SupplierID, "749", supplierGuid).catch(function (err) {
            return console.log(err.message);
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
    //chat.server.Generic("Wrtc", JSON.stringify({
    //    type: "supplierAcceptChat",
    //    answer: "ok"
    //})).catch(function (err) {
    //    return console.error(err.toString());
    //    });
    connection.invoke("Generic", "Wrtc", JSON.stringify({
        type: "supplierAcceptChat",
        answer: "ok"
    }), supplierGuid, "0", SupplierID, "749", supplierGuid).catch(function (err) {
        return console.log(err.message);
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

function handleLogin(success, callback) {//this return from pjs
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
var myVar = setTimeout(setInterval(myTimer, 3000), 3000);

function myTimer() {
    console.log("162" + Date());
    connection.invoke("Generic", "Update", "update257", supplierGuid, "0", SupplierID, "749", supplierGuid).catch(function (err) {
        return console.log(err.message);
    });
}