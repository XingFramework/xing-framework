/**
 * This file/module contains all configuration for the build process.
 */
module.exports = {
  /**
   * The `build_dir` folder is where our projects are compiled during
   * development and the `compile_dir` folder is where our app resides once it's
   * completely built.
   */
  build_dirs: {
    root: 'build',
    stylesheets: '<%= build_dirs.root %>/stylesheets',
    js: '<%= build_dirs.root %>/javascripts',
    assets: '<%= build_dirs.root %>/assets',
    test: '<%= build_dirs.root%>/test'
  },
  build_dir: '<%= build_dirs.root %>',
  compile_dir: 'bin',
  //compile_dir: '../server/public',
  tmp_dir: 'tmp',

  compile_targets: {
    js: '<%= compile_dir %>/assets/<%= pkg.name %>-<%= pkg.version %>.js',
    vendor_js: '<%= compile_dir %>/assets/vendor.js',
    css: '<%= compile_dir %>/assets/<%= pkg.name %>-<%= pkg.version %>.css',
    map: '<%= compile_dir %>/assets/<%= pkg.name %>-<%= pkg.version %>.map',
  },

  /**
   * This is a collection of file patterns that refer to our app code (the
   * stuff in `src/`). These file paths are used in the configuration of
   * build tasks. `js` is all project javascript, less tests. `ctpl` contains
   * our reusable components' (`src/common`) template HTML files, while
   * `atpl` contains the same, but for our app's code. `html` is just our
   * main HTML file, `less` is our main stylesheet, and `unit` contains our
   * app's unit tests.
   */
  app_files: {
    js_roots: [ 'src/app/app.js' ],
    js_dir: 'src',
    js: [ 'src/**/*.js', '!src/**/*.spec.js', '!src/assets/**/*.js' ],
    js_es6: [ 'build/src-es6/**/*.js', '!build/src-es6/**/*.spec.js', '!build/src-es6/assets/**/*.js' ],
    jsunit: [ 'test/**/*.js' ],
    jstest: [ 'test/**/*.js', 'test-help/**/*.js' ],
    jstest_es6: [ 'build/test-es6/**/*.js', 'build/test-help-es6/**/*.js' ],
    test_dir: 'test',
    test_help_dir: 'test-help',
    coffee: [ 'src/**/*.coffee', '!src/**/*.spec.coffee' ],
    coffeeunit: [ 'test/**/*.coffee' ],

    atpl: [ 'src/app/**/*.tpl.html' ],
    ctpl: [ 'src/common/**/*.tpl.html' ],
    ttpl: [ 'test/**/*.json', 'test/**/*.tpl.html' ],
    html: [ 'src/index.html' ],
    stylesheets: 'src/styles'
  },


  /**
   * This is a collection of files used during testing only.
   */
  test_files: {
    js: [
      'vendor/angular-mocks/angular-mocks.js'
    ]
  },

  /**
   * This is the same as `app_files`, except it contains patterns that
   * reference vendor code (`vendor/`) that we need to place into the build
   * process somewhere. While the `app_files` property ensures all
   * standardized files are collected for compilation, it is the user's job
   * to ensure non-standardized (i.e. vendor-related) files are handled
   * appropriately in `vendor_files.js`.
   *
   * The `vendor_files.js` property holds files to be automatically
   * concatenated and minified with our project source files.
   *
   * The `vendor_files.css` property holds any CSS files to be automatically
   * included in our app.
   *
   * The `vendor_files.assets` property holds any assets to be copied along
   * with our app's assets. This structure is flattened, so it is not
   * recommended that you use wildcards.
   *
   * If stray files make it into vendor, the solution is *not* to change this config
   * We need to change the Gruntfile.js or bower.json to export only the files we want.
   *
   */
  vendor_files: {
    js: [
      'node_modules/jquery/dist/jquery.js',
      'node_modules/lodash/dist/lodash.js',
      'node_modules/angular/angular.js',
      'node_modules/angular-cookies/angular-cookies.js',
      'node_modules/angular-fontawesome/dist/angular-fontawesome.js',
      'node_modules/angular-ui-router/release/angular-ui-router.js',
      'node_modules/xing-frontend-token-auth/src/xing-frontend-token-auth.js',
      'node_modules/responsive-nav/responsive-nav.js',
      'node_modules/hammerjs/hammer.js',
      'node_modules/uri-templates/uri-templates.js'
    ],
    css: [
      'node_modules/froala-editor/css/font-awesome.min.css'
    ],
    assets: [
      'node_modules/font-awesome/fonts/fontawesome-webfont.*'
    ]
  },
};
