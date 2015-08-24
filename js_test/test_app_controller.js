describe('EmployeeLocation directive', function() {

  describe('parseIntoBubbles parses data into bubble objects', function() {
    var compile, scope, empLocationElem;

    beforeEach(function(){
      module('simpleApp');
      
      inject(function ($compile, $rootScope) {
        compile=$compile;
        scope=$rootScope.$new();
        scope.mapData = [{}];
        scope.notify = true;
        scope.onChange = jasmine.createSpy('onChange');
      });
      empLocationElem = getCompiledElement();
    });

    function getCompiledElement(){
      var element = angular.element('<div emp-location info="work_locations"></div>');
      var compiledElement = compile(element)(scope);
      scope.$digest();
      return compiledElement;
    }

    it("isolated scope should be two way bound", function(){
      var isolatedScope = empLocationElem.isolateScope();
      isolatedScope.mapData.prop = "test";
      expect(scope.work_locations.prop).toEqual('test');
    });

    it("parses out map bubbles from data", function(){
      var isolatedScope = empLocationElem.isolateScope();
      isolatedScope.mapData = [{id: '123', lat: 1.2, lon: 3.4, employee_count: 2}];
      scope.$compile();
      expect(scope.bubbles).toEqual([{name: '123', radius: 2, borderColor: 'red', borderWidth: '4px',
        latitude: 1.2, longitude: 3.4, employee_count: 2}]);
    });
  });
});
