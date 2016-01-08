export default function mockDirective(directiveName, innerContent) {
  module(function($compileProvider) {
    $compileProvider.directive(directiveName, function() {
      var mockDir = {
        priority: 9999,
        terminal: true,
        restrict: 'EAC',
        template: `<div class='mock'>${innerContent}</div>`
      };
      return mockDir;
    });
  });
}
