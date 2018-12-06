let MapModule = (function() {

  let map;
  let stations = [];
  let stationMarkers = [];
  let stations_by_abbr = {};

  function setStations() {
    stations = $("#station-data").data().stations;

    for(var station of stations){
      stations_by_abbr[station.abbr] = station;
    }
  }

  function initMap() {
    setStations();
    setMap();
    placeStationMarkers();
    drawMapLines();
  }

  function placeStationMarkers(){
    const circle = {
      path: google.maps.SymbolPath.CIRCLE,
      fillColor: '#00F',
      // fillOpacity: 0.6,
      strokeColor: '#00A',
      // strokeOpacity: 0.9,
      strokeWeight: 2,
      scale: 4
    };

    for (let station of stations){
      let marker = new google.maps.Marker({
        position: {lat: parseFloat(station.gtfs_latitude), lng: parseFloat(station.gtfs_longitude)},
        map: map,
        title: station.name,
        icon: circle
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

  function drawMapLines(){
    let routes = $("#route-data").data().routes;
    let stationMap = [];

    for(let route of routes){
      let routeCoordinates = [];
      stations = route["config"]["station"]
      for(let station of stations){
        routeCoordinates.push({
          lat: parseFloat(stations_by_abbr[station].gtfs_latitude),
          lng: parseFloat(stations_by_abbr[station].gtfs_longitude),
        });
      }
      stationMap.push(routeCoordinates);
    }

    for(let route of stationMap){
      let routePath = new google.maps.Polyline({
        path: route,
        geodesic: true,
        strokeColor: "#3397d5",
        strokeOpacity: 1.0,
        strokeWeight: 8
      });

      routePath.setMap(map);
    }
  }

  return {
    initMap: initMap
  };

})();