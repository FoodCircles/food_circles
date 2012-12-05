//= require ../../../vendor/assets/javascripts/gmaps.js

var socket, map, rooms = {}, name, p;

$(function() {
    $.getScript('http://localhost:8080/socket.io/socket.io.js', function(data, textStatus, jqxhr) {
	socket = io.connect('http://localhost:8080');
	setupSockets();
	socket.emit('gethistory');
    });

    if (localStorage["located"] === "true") locate();

    $('#data').keypress(function(e) {
	if(e.which == 13) {
	    socket.emit('sendchat', $(this).val());
	    $('#data').val('');
	}
    });

    map = new GMaps({
	div: '#map',
	lat: 42.9664115905762,
	lng: -85.6711807250977
    });
    $.getJSON('http://foodcircles.net/api/venues?format=jsonp&callback=?', function(data) {
	$.each(data, function(i,v) {
	    map.addMarker({
		lat: v.lon,
		lng: v.lat,
		title: v.name,
		infoWindow: {
		    content: '<p><h5>'+v.name+'</h5><img src="http://foodcircles.net'+v.image+'"/></p>'
		}
	    });
	});
    });

    $.ajax({url: '/chat/venues'});

    $('#map').height($('#map').parent().height());

});

function setupSockets() {
    if(localStorage['name'] == "null") {
	while(name == "null") {
	    name = prompt("What's your name?");
	}
	localStorage['name'] = name;
    }
    socket.on('connect', function(){socket.emit('adduser', localStorage['name']);});
    socket.on('showhistory', function(data) {
	$.each(data, function(i,v) {
	    $('#conversation').append(v.content);
	});
    });
    socket.on('updatechat', function (username, data) {$('#conversation').append('<b>'+username + ':</b> '+data+'<br>');});
    socket.on('updateusers', function(usernames) {
	$('.participant').remove();
	$.each(usernames, function(i,v) {
	    $('#participants').append('<div class="participant" id="'+v+'-considering"><h6>'+v+'</h6><span class="considering"> is considering...</span><div class="restaurant_name">Nothing at the moment</div>');
	});
    });
    socket.on('setRooms', function(roomlist) {rooms = roomlist;});
    socket.on('setConsidering', function(username, venue) {
	$('#'+username+'-considering .restaurant_name').html(venue);
    });
    socket.on('vote', function(username, id) {
	var r = $('.restaurant:[data-id='+id+']');
	var v = r.find('.vote');
	var c = (v.length > 0 ? parseInt(v.html()) : 0);
	r.find('.vote').remove();
	r.append('<span class="vote">'+(c+1)+'</span>');
    });
}

function setName() {
    name = prompt("What's your name?");
    if(name !== null){
	localStorage['name'] = name;
	socket.emit('changename', localStorage['name']);
    }
}

function showRooms() {
    var count = 0;
    $('#overlay').css({'display':'block'})
	.animate({'opacity': '1'}, 500);
    $('#roomlist > ul > li').remove();
    for (var key in rooms) {
	if (rooms.hasOwnProperty(key)){
	    $('#roomlist > ul').prepend('<li>'+(key == '' ? '/Main Room' : key)+'</li>');
	    count++;
	}
    }
    $('#roomlist > h1').text(count+' rooms');
    $('#roomlist').css({
	'top':($(window).height()/2-$('#roomlist').outerHeight()/2)+'px',
	'left':($(window).width()/2-$('#roomlist').outerWidth()/2)+'px'
    });
    $('#roomlist input').off().on('keypress', function(e) {
	if(e.which == 13) {
	    socket.emit('joinroom', $(this).val());
	    $(this).val('');
	    $('#overlay').css({'opacity':'0','display':'none'});
	}
    });
}

function closeModal() {
    $('#overlay').css({'opacity':'0','display':'none'});
}

function locate() {
    $('#locate').slideUp();
    GMaps.geolocate({
	success: function(position) {
	    localStorage["located"] = "true";
	    p = position;
	    map.setCenter(position.coords.latitude, position.coords.longitude);
	},
	error: function(error) {
	    alert('Geolocation failed: '+error.message);
	},
	not_supported: function() {
	    alert("Your browser does not support geolocation");
	}
    });
}