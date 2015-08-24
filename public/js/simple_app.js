var app = angular.module("simpleApp", []).controller('AppCtrl', ["$scope",'$http',function($scope,$http){
  $http.get('/work_locations').success(function(data) {
    $scope.work_locations = data;
  });
  $http.get('/invoiced_customers').success(function(data) {
    $scope.invoiced_customers = data;
  });
}]);

app.directive("empLocation", function(){
  var bubbles, map;
  return {
  	restrict: 'E',
    scope: {
      mapData: '=info'
    },
    template: '<div id="emp-location" style="position: relative; width: 900px; height: 500px;"></div>',
    link: function(scope, element, attrs) {
      scope.$watch(function(){return scope.mapData}, function(mapData){
        if(typeof(mapData) == 'undefined'){
          return false;
        }
        map = new Datamap({element: document.getElementById('emp-location'), fills: {defaultFill: '#1f77b4'}});
        bubbles = [];
        mapData.forEach(function(mapLoc){
          bubbles.push({
            name: mapLoc.id,
            radius: mapLoc.employee_count,
            borderColor: 'red',
            borderWidth: '4px',
            latitude: mapLoc.lat,
            longitude: mapLoc.lon,
            employee_count: mapLoc.employee_count
          });
        });
        map.bubbles(bubbles, {
          popupTemplate: function(geo, data) {
          return ['<div class="hoverinfo"><span>Location ID:' +  data.name, '</span><br/>',
            '<span>Employee Count:'+ data.employee_count +'</span><br/></div>'].join('');
          }
        });
      });
    }
  }
});

app.directive("salesFlow", function(){
  return {
    restrict: 'E',
    scope: {
      mapData: '=info'
    },
    template: '<div id="sales-flow" style="position: relative; width: 900px; height: 500px;"></div>',
    link: function(scope, element, attrs) {
      scope.$watch(function(){return scope.mapData}, function(mapData){
        if(typeof(mapData) == 'undefined'){
          return false;
        }
        countryData = {'US': 0, '-': 0, 'IN': 0, 'AU': 0}
        mapData.forEach(function(mapD){
          previoudInvoiced = countryData[mapD.country];
          if(typeof(previoudInvoiced) == 'undefined'){
            countryData[mapD.country] = mapD.total_invoiced;
          } else {
            countryData[mapD.country] = previoudInvoiced + mapD.total_invoiced;
          }
        });
        var map = new Datamap({
          element: document.getElementById('sales-flow'), 
          fills: { IND: 'blue', USA: 'green', AUS: 'yellow', defaultFill: '#1f77b4' },
          data: { 
            USA: { fillKey: 'USA', total_invoiced: countryData['US'] }, 
            AUS: {fillKey: 'AUS', total_invoiced: countryData['AU'] }, 
            IND: {fillKey: 'IND', total_invoiced: countryData['IN'] } 
          },
          geographyConfig: {
              popupTemplate: function(geo, data) {
                  return ['<div class="hoverinfo">', 'Total invoiced in this country:' + geo.properties.name,
                          ': ' + data.total_invoiced, '</div>'].join('');
              }
          }
        });
        map.legend();
      });
    }
  }
});