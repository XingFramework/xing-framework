
beforeEach(function () {
    jasmine.addMatchers({
        toEqualData: function () {
            return {
                compare: function(actual, expected) {
                    return {
                        pass: angular.equals(actual, expected)
                    };
                }
            };
        },
        toBeFunction: function () {
            return {
                compare: function(actual) {
                    return {
                        pass: angular.isFunction(actual)
                    };
                }
            };
        },
        toBeInstanceOf: function () {
            return {
                compare: function(actual, expected) {
                    return {
                        pass: actual instanceof expected
                    };
                }
            };
        }

    });
});