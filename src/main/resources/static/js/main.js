'use strict';

document.write("<script\n" +
	"  src=\"https://code.jquery.com/jquery-3.6.1.min.js\"\n" +
	"  integrity=\"sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=\"\n" +
	"  crossorigin=\"anonymous\"></script>")

var usernamePage = document.querySelector('#username-page');
var chatPage = document.querySelector('#chat-page');
var usernameForm = document.querySelector('#usernameForm');
var messageForm = document.querySelector('#messageForm');
var messageInput = document.querySelector('#message');
var messageArea = document.querySelector('#messageArea');
var connectingElement = document.querySelector('.connecting');

var stompClient = null;
var username = null;

var colors = [
	'#2196F3', '#32c787', '#00BCD4', '#ff5652',
	'#ffc107', '#ff85af', '#FF9800', '#39bbb0'
];

// roomId 파라미터 가져오기
const url = new URL(location.href).searchParams;
const roomId = url.get('roomId');

function connect(event) {
	username = document.querySelector('#name').value.trim();

	isDuplicateName();

    usernamePage.classList.add('hidden');
    chatPage.classList.remove('hidden');

    // 연결하고자하는 Socket 의 endPoint
    var socket = new SockJS('/ws-stomp');
    stompClient = Stomp.over(socket);

    stompClient.connect({}, onConnected, onError);

	event.preventDefault();
}


function onConnected() {
	// Subscribe to the Public Topic
	stompClient.subscribe('/sub/chat/room/' + roomId, onMessageReceived);

	// Tell your username to the server
	stompClient.send("/pub/chat/enterUser",
		{},
		JSON.stringify({
			"roomId": roomId,
			sender: username,
			type: 'ENTER'
		})
	)

	connectingElement.classList.add('hidden');
}

// 유저 닉네임 중복 확인
function isDuplicateName() {

    $.ajax({
        type: "GET",
        url: "/chat/duplicateName",
        data: {
            "username": username,
            "roomId": roomId
        },
        success: function (data) {
            console.log("함수 동작 확인 : " + data);

            username = data;
        }
    })

}

// 유저 리스트 받기
function getUserList() {
    const $list = $("#list");

    $.ajax({
        type: "GET",
        url: "/chat/userlist",
        data: {
            "roomId": roomId
        },
        success: function (data) {
            var users = "";
            for (let i = 0; i < data.length; i++) {
                //console.log("data[i] : "+data[i]);
                users += "<li class='dropdown-item'>" + data[i] + "</li>"
            }
            $list.html(users);
        }
    })
}

function onError(error) {
	connectingElement.textContent = 'Could not connect to WebSocket server. Please refresh this page to try again!';
	connectingElement.style.color = 'red';
}


function sendMessage(event) {
	var messageContent = messageInput.value.trim();

	if (messageContent && stompClient) {
		var chatMessage = {
			"roomId": roomId,
			sender: username,
			message: messageInput.value,
			type: 'TALK'
		};

		stompClient.send("/pub/chat/sendMessage", {}, JSON.stringify(chatMessage));
		messageInput.value = '';
	}
	event.preventDefault();
}


function onMessageReceived(payload) {
	var chat = JSON.parse(payload.body);

	var messageElement = document.createElement('li');

	if (chat.type === 'ENTER') {
		messageElement.classList.add('event-message');
		chat.content = chat.sender + chat.message;
		getUserList();

	} else if (chat.type === 'LEAVE') {
		messageElement.classList.add('event-message');
		chat.content = chat.sender + chat.message;
		getUserList();

	} else {
		messageElement.classList.add('chat-message');

		var avatarElement = document.createElement('i');
		var avatarText = document.createTextNode(chat.sender[0]);
		avatarElement.appendChild(avatarText);
		avatarElement.style['background-color'] = getAvatarColor(chat.sender);

		messageElement.appendChild(avatarElement);

		var usernameElement = document.createElement('span');
		var usernameText = document.createTextNode(chat.sender);
		usernameElement.appendChild(usernameText);
		messageElement.appendChild(usernameElement);
	}

	var contentElement = document.createElement('p');
	
	// 만약 s3DataUrl 의 값이 null 이 아니라면
    // img 를 채팅에 보여주는 작업
    if(chat.s3DataUrl != null){
        var imgElement = document.createElement('img');
        imgElement.setAttribute("src", chat.s3DataUrl);
        imgElement.setAttribute("width", "300");
        imgElement.setAttribute("height", "300");

        contentElement.appendChild(imgElement);

    }else{
        // 만약 s3DataUrl 의 값이 null 이라면
        // 이전에 넘어온 채팅 내용 보여주기기
       var messageText = document.createTextNode(chat.message);
        contentElement.appendChild(messageText);
    }
    
	textElement.appendChild(contentElement);

	if (chat.sender === username) {
		messageElement.classList.add('own-message');
	} else {
		messageElement.classList.add('other-message');
	}

	messageElement.appendChild(textElement);

	messageArea.appendChild(messageElement);
	messageArea.scrollTop = messageArea.scrollHeight;
}


function getAvatarColor(messageSender) {
	var hash = 0;
	for (var i = 0; i < messageSender.length; i++) {
		hash = 31 * hash + messageSender.charCodeAt(i);
	}

	var index = Math.abs(hash % colors.length);
	return colors[index];
}

usernameForm.addEventListener('submit', connect, true)
messageForm.addEventListener('submit', sendMessage, true)

/// 파일 업로드 부분 ////
function uploadFile(){
    var file = $("#file")[0].files[0];
    var formData = new FormData();
    formData.append("file",file);
    formData.append("roomId", roomId);

    // ajax 로 multipart/form-data 를 넘겨줄 때는
    //         processData: false,
    //         contentType: false
    // 처럼 설정해주어야 한다.
    $.ajax({
        type : 'POST',
        url : '/s3/file',
        data : formData,
        processData: false,
        contentType: false
    }).done(function (data){
        console.log("업로드 성공")

        var chatMessage = {
            "roomId": roomId,
            sender: username,
            message: username+"님의 파일 업로드",
            type: 'TALK',
            s3DataUrl : data
        };

        stompClient.send("/pub/chat/sendMessage", {}, JSON.stringify(chatMessage));
    }).fail(function (error){
        alert(error);
    })
}