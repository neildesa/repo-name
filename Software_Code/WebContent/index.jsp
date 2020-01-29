<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="JavaDatabaseCode.JavaFunctionsForJsp" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="/Web/style.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<meta charset="ISO-8859-1">
<title>Maps</title>

<script type='text/javascript' src='config.js'></script>


<style>
      #map {
		height: calc(100% - 75px);
		width: 70%;
		float: right;
      }
      
      html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
    </style>

</head>
<body>
	
       
  
	         
            <nav class="navbar navbar-expand-lg navbar-light bg-light" style="height: 75px">
                <a class="navbar-brand" href="#">Help! I'm a Fish</a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarText" aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarText">
                    <ul class="navbar-nav mr-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="Web/index.html">Home</a>
                        </li>
                        <li class="nav-item active">
                            <a class="nav-link" href="index.js">Find a Hospital<span class="sr-only">(current)</span></a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="Web/about.html">About us</a>
                        </li>
                    </ul>
                </div>
            </nav>
	      <div id="map"></div> 
            <div class="container-flex content-box">    
                <div class="row align-items-center">
                    <div class="col overflow-auto" style="height: calc(100vh - 75px)">
                        <table class="table table-hover table-borderless table-striped">
                            <thead>
                              <tr>
                                <th scope="col">Hospital</th>
                              </tr>
                            </thead>
                            <tbody>
                                <tr><td><% out.println(JavaFunctionsForJsp.returnMessage()); %>	</td></tr>
                                <tr><td>Mark</td></tr>
                                <tr><td>Jacob</td></tr>
                                <tr><td>Larry</td></tr>
                                <tr><td>Mark</td></tr>
                                <tr><td>Jacob</td></tr>
                                <tr><td>Larry</td></tr>
                                <tr><td>Mark</td></tr>
                                <tr><td>Jacob</td></tr>
                                <tr><td>Mark</td></tr>
                                <tr><td>Jacob</td></tr>
                                <tr><td>Larry</td></tr>
                                <tr><td>Mark</td></tr>
                                <tr><td>Jacob</td></tr>
                                <tr><td>Larry</td></tr>
                                <tr><td>Mark</td></tr>
                                <tr><td>Jacob</td></tr>
                                <tr><td>Larry</td></tr>
                                <tr><td id="HospitalName">Hospital Name</td></tr>
                            </tbody>
                          </table>
                   		</div>
                	</div>
            	</div>
    	<script>
	      var map;
	      var locations = [["619 SOUTH 19TH STREET, AL", "UNIVERSITY OF ALABAMA HOSPITAL"],["5777 EAST MAYO BOULEVARD", "MAYO CLINIC HOSPITAL"],["9601 INTERSTATE 630, EXIT 7", "BAPTIST HEALTH MEDICAL CENTER-LITTLE ROCK"]];
	      var origin = 'New York';
	      var distance = "Caclulating...";
	      
	      function initMap() {
	    	  //Dundee Location
	    	  var position = {lat: 56.46913, lng: -2.97489};
	    	  // The map, centered at Uluru
	    	  var map = new google.maps.Map(
	    	      document.getElementById('map'), {zoom: 4, center: position});
	    	  // The marker, positioned at Uluru
	    	  
	    	  var service = new google.maps.DistanceMatrixService();
	          geocoder = new google.maps.Geocoder();
	          
	          codeAddress(geocoder, map, origin, service, true);
	          
				for(var location in locations){
					codeAddress(geocoder, map, location, service, false);
				}
	      }
	      
	      function getDistance(distanceMatrix, map, address, result, distance){
	    	  dest = locations[address][0];
	    	  distanceMatrix.getDistanceMatrix(
            		  {
            			    origins: [origin],
            			    destinations: [dest],
            			    travelMode: 'DRIVING',
            			    unitSystem: google.maps.UnitSystem.IMPERIAL,
            		  }, function(response, status){
            	          	if (status == 'OK') {
            	          		var origins = response.originAddresses;
            	          	    var destinations = response.destinationAddresses;
            	          	    
            	          	  for (var i = 0; i < origins.length; i++) {
            	          	      var results = response.rows[i].elements;
            	          	      for (var j = 0; j < results.length; j++) {
            	          	        var element = results[j];
            	          	        distance = element.distance.text;
            	          	        var duration = element.duration.text;
            	          	        var from = origins[i];
            	          	        var to = destinations[j];
            	          	      	placeMarker(map, address, result, distance);
            	          	      }
            	          	    }
            	          	  }
            	          	if (status == 'NOT_FOUND') {
            	          		  alert("The origin and/or destination of this pairing could not be geocoded.");
            	          		  }
            				if (status == 'ZERO_RESULTS'){
            					alert("No route could be found between the origin and destination.");				
            					}
            				});    
	    }
	      	      
	      function codeAddress(geocoder, map, address, distanceMatrix, user) {
	    	  
	    	  if(user == true){
	    		  
	    		  geocoder.geocode({'address': address}, function(results, status) {
	    	          if (status === 'OK') { 
    	        		  placeMarkerUser(map, results[0].geometry.location);
    	        		  alert("TESTING");
    	  			}
	    	          else {
    		            alert('Geocode was not successful for the following reason: ' + status);
    		          }
	    	 	 });
	    	  }
	    	  else{
	    		  geocoder.geocode({'address': locations[address][0]}, function(results, status) {
	    	          if (status === 'OK') { 
	    	        	  getDistance(distanceMatrix, map, address, results[0].geometry.location, distance); 
	    		  } 
	    	          else {
	  	            	alert('Geocode was not successful for the following reason: ' + status);
	  	          }
	        	});
	      	}
	      }
	      
              
	    function placeMarker(map, address, result, distance){
	    	
	            var image = { url: 'https://cdn1.iconfinder.com/data/icons/medicine-pt-7/100/051_-_hospital_map_marker_pin_doctor-512.png',  scaledSize: new google.maps.Size(35,35) }
	            var marker = new google.maps.Marker({
	              map: map,
	              icon: image,
	              animation: google.maps.Animation.DROP,
	              position: result
	            });

	            var infowindow = new google.maps.InfoWindow({
	            	  content:'<div id="content">'+
	                  '<div id="siteNotice">'+
	                  '</div>'+
	                  '<h5 id="firstHeading" class="firstHeading">' + locations[address][1] + ' </h5>' + 'Distance: ' + distance +
	                  '<div id="bodyContent">'+
	                  '<p><b>Procedure:</b> 812 - RED BLOOD CELL DISORDERS <hr> <b>Address:</b>' + locations[address][0] + ' <br> <b>Cost:</b> $6,778.64 <br>' +
	                  '</div>'+
	                  '</div>'
	            	});

	            	google.maps.event.addListener(marker, 'click', function() {
               infowindow.open(map,marker)
               highlightClick()}                        
	            	);
	    }
	    
	    function placeMarkerUser(map, result){
	    	map.setCenter(result);
            var image = { url: 'https://cdn0.iconfinder.com/data/icons/real-estate-240/32/10_Location_home_house_pin_gps-512.png',  scaledSize: new google.maps.Size(35,35) }
            var marker = new google.maps.Marker({
              map: map,
              icon: image,
              animation: google.maps.Animation.DROP,
              position: result
            });
	    }
	      
        function highlightClick(){
          var elmnt = document.getElementById("HospitalName");
                  elmnt.scrollIntoView({behavior: "smooth"});
                  elmnt.style.backgroundColor = "#FDFF47";
        }

	      var key = config.API_KEY;
	      var srcText = 'https://maps.googleapis.com/maps/api/js?key=' + key + '&callback=initMap';
	      var script = document.createElement('script');
	      script.src = srcText
	      document.body.appendChild(script)
     </script>
    
   

</body>
</html>
