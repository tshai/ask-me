var stream;
var configuration = {
	"iceServers": [
		{ url: "stun:stun.l.google.com:19302" },
		{ url: "turn:116.203.70.128:80?transport=udp", username: "test", credential: "test" },
		{ url: "turn:116.203.70.128:80?transport=tcp", username: "test", credential: "test" }

	]
};
function IsJsonString(str) {
    try {
        JSON.parse(str);
    } catch (e) {
        return false;
    }
    return true;
}
function hasUserMedia() {
	//check if the browser supports the WebRTC 
	return !!(navigator.getUserMedia || navigator.webkitGetUserMedia ||
		navigator.mozGetUserMedia || navigator.mediaDevices);
}
function getCookie(cname) {
	var name = cname + "=";
	var decodedCookie = decodeURIComponent(document.cookie);
	var ca = decodedCookie.split(';');
	for (var i = 0; i < ca.length; i++) {
		var c = ca[i];
		while (c.charAt(0) == ' ') {
			c = c.substring(1);
		}
		if (c.indexOf(name) == 0) {
			return c.substring(name.length, c.length);
		}
	}
	return "";
}

function attachSinkId(element, sinkId) {
	if (typeof element.sinkId !== 'undefined') {
		element.setSinkId(sinkId)
			.then(function () {
				console.log('Success, audio output device attached: ' + sinkId);
			})
			.catch(function (error) {
				var errorMessage = error;
				if (error.name === 'SecurityError') {
					errorMessage = 'You need to use HTTPS for selecting audio output ' +
						'device: ' + error;
				}
				console.error(errorMessage);
				// Jump back to first output device in the list as it's the default.
				audioOutputSelect.selectedIndex = 0;
			});
	} else {
		console.warn('Browser does not support output device selection.');
	}
}
function logError(ex) {
	alert(ex);
}
function sendErrorToDB(m, isError) {
    $.ajax({
        async: false,
        url: "camClientBackground.aspx?qType=6&err=" + m + "&isError=" + isError, success: function (result) {

        }
    });
}