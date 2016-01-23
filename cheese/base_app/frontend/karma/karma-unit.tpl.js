module.exports = function ( config ) {

  var portOffset = function() {
    return ((1*process.env.PORT_OFFSET) || 0)
  }
  var karmaPort       = 9018 + portOffset();
  var karmaRunnerPort = 9100 + portOffset();

  config.set({

    /**
     * From where to look for files, starting with the location of this file.
     */
    basePath: '..',

    /**
     * This is the list of file patterns to load into the browser during testing.
     */
    files: [
      'bin/assets/vendor.js',
      'bin/assets/traceur-runtime.js',
      'node_modules/angular-mocks/angular-mocks.js',
      'build/test/test-main.js',
      'node_modules/xing-traceur/node_modules/traceur/bin/traceur-runtime.js',
      {pattern: 'build/test/test-main.js.map', included: false}
    ],
    exclude: [
      'src/assets/**/*.js'
    ],
    frameworks: [ 'jasmine' ],
    plugins: [
      'karma-jasmine',
      'karma-firefox-launcher',
      'karma-chrome-launcher',
      'karma-sourcemap-loader'
      //'karma-coffee-preprocessor',
    ],
    preprocessors: {
      '**/*.js': ['sourcemap']
    },

    /**
     * How to report, by default.
     */
    //reporters: 'dots',
    /**
     * On which port should the browser connect, on which port is the test runner
     * operating, and what is the URL path for the browser to use.
     */


    port:       karmaPort,
    runnerPort: karmaRunnerPort,
    urlRoot: '/',
    browserDisconnectTimeout: 20000,
    browserNoActivityTimeout: 20000,

    /**
     * Disable file watching by default.
     */
    //autoWatch: false,

    /**
     * The list of browsers to launch to test on. This includes only "Firefox" by
     * default, but other browser names include:
     * Chrome, ChromeCanary, Firefox, Opera, Safari, PhantomJS
     *
     * Note that you can also use the executable name of the browser, like "chromium"
     * or "firefox", but that these vary based on your operating system.
     *
     * You may also leave this blank and manually navigate your browser to
     * http://localhost:9018/ when you're running tests. The window/tab can be left
     * open and the tests will automatically occur there during the build. This has
     * the aesthetic advantage of not launching a browser every time you save.
     */
    browsers: [
      'Chrome'
    ]
  });
};
