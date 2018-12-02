let MapModule = (function() {

  let map;
  let stations = [];
  let stationMarkers = [];

  const lines = {
    dublin_pleasanton: [],
    richmond: [],
    antioch: [],
    fremont: []
  }

  function setStations() {
    stations = $("#station-data").data().stations;
  }

  function initMap() {
    
    setStations();
    setMap();
    placeStationMarkers();

  
  }

  function placeStationMarkers(){

    for (var station of stations){

      var marker = new google.maps.Marker({
        position: {lat: parseFloat(station.gtfs_latitude), lng: parseFloat(station.gtfs_longitude)},
        map: map,
        title: station.name
      });
        
      stationMarkers.push(marker);
    }

  }

  function setMap(){
    map = new google.maps.Map(document.getElementById('map'), {
      center: {lat: 37.7868953, lng: -122.4134453},
      zoom: 14,
      mapTypeControl: false
    });
  }

  function drawPath(){
     var flightPlanCoordinates = [
      {lat: 37.772, lng: -122.214},
      {lat: 21.291, lng: -157.821},
      {lat: -18.142, lng: 178.431},
      {lat: -27.467, lng: 153.027}
    ];

    var flightPath = new google.maps.Polyline({
      path: flightPlanCoordinates,
      geodesic: true,
      strokeColor: '#FF0000',
      strokeOpacity: 1.0,
      strokeWeight: 2
    });

    flightPath.setMap(map);
  }


  return {
    initMap: initMap
  };

})();