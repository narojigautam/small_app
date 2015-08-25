describe('parseIntoBubbles parses data into bubble objects', function() {
  var $compile, $rootscope, empLocationElem;

  beforeEach(module('simpleApp'));
    
  beforeEach(inject(function (_$compile_, _$rootScope_) {
      $compile=_$compile_;
      $rootscope=_$rootScope_;
      $rootscope.work_locations = [{id: '123', lat: 1.2, lon: 3.4, employee_count: 2}]
      empLocationElem = angular.element('<div emp-location info="work_locations"></div>');
      $compile(empLocationElem)($rootscope);
      $rootscope.$digest();
    })
  );

  it("parses out map bubbles from data", function(){
    console.log(empLocationElem.scope());
    expect($rootscope.bubbles).toEqual([{name: '123', radius: 2, borderColor: 'red', borderWidth: '4px',
      latitude: 1.2, longitude: 3.4, employee_count: 2}]);
  });
});
