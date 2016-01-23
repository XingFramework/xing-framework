0.0.19 / 2015-10-07
========
  * Use APP_MODULE consistently in backend, eliminate references to LrdCms and LrdCms2 modules.
  * Use $appName consistently in frontend, eliminate literals & references to LRD-CMS2 in code
  * Create xng-unimplemented directive to mark visual features that are not yet built
  * Fix loading of FontAwesome icons
  * Make Froala editor toolbar show by default in CMS rich text editor
  * Clean up and improve sample_data task and seeds.rb.
  * update relayer to 0.1.0

0.0.18  / 2015-09-27
========
  * Add error fallback condition to break infinite state redirect loops, with default error page
  * Update angular 1.3.x to 1.4.15, and Relayer to 0.0.9

0.0.17 / 2015-06-29
========
  * extraction of the xing-traceur task
  * extraction of the xing-inflector
  * And the relayer library (not actually used here though -- just available as importable file)
  * Converted most bower files to node_modules, removed from repository

0.0.16 / 2015-06-29
========
  * Update xing-backend to 0.0.16

0.0.15 / 2015-06-29
========
  * Update xing-backend to 0.0.15

0.0.14 / 2015-06-29
========
  * Modify traceur-es6 task to handle files in batches, to avoid crashes due to too many files open simultaneously.
  * Update xing-backend to 0.0.14

0.0.13 / 2015-06-19
========
  * Update Rails to 4.2.2 and Rack to 1.6.4
  * Fix bug with latest chromedriver and mobile browser size in E2E tests
  * xing-backend 0.0.13 includes list serializers
  * Fix sidekiq ... again

0.0.12 / 2015-06-18
===================
  * Update to match version of xing-backend gem that includes paginated list resources.

0.0.11 / 2015-06-18
===================
  * BREAKING: references to old JsonController and BaseController MUST be replaced by
    Xing::Controllers::Base.  Deprecation warnings will NOT be emitted.

  * BREAKING: references to ResourcesController MUST be replaced by Xing::Controllers::RootResourcesController.
    Deprecation warnings will NOT be emitted.

  * Update to Rails 4.2 in backend
  * Set depenency for mappers/serializers/controllers to extracted xing-backend gem
  * Set dependecy for token authn to xing_backend_token_auth gem (replacing the a git fork
    of devise_token_auth)
  * Sass updates, including making flexbox available
  * Replace all constants deprecated by the new xing-backend gem


0.0.8 / 2015-06-09
==================
  * Update to Rails 4.2.0
  * Extract back-end framework code to backend/framework
  * Fixes to saving/displaying per-page CSS in CMS pages
  * Fixes to styling of inline <i> and <b> tags in CMS pages
  * Update to A1Atscript 0.2.0

0.0.7 / 2015-03-18
==================
  * Update to Rails 4.1.9
  * BREAKING: All non state based components moved to src/common/components
  * BREAKING: Many front-end classes are moved to frontend/src/framework
  * Loggable browser console:  front-end JS shim/console wrapper + Waterpig version bump logs
    browser console to backend/log/test_browser_console.log during feature specs
  * BREAKING: Updated traceur -- means all import statements now include .js in the title

0.0.6 / 2015-02-20
==================
  * BREAKING: Reorganization of stylesheets directory. Default styles provided by framework are now located in the styles/framework, with app-specific overrides in styles/partials or styles/states.

0.0.5 / 2015-02-17
==================
  * Move compass:watch function out of grunt and into rake develop.

0.0.4 / 2015-02-03
==================

  * Change to the rakelibs to only require files as tasks need them - was breaking Capistrano deploys
  * Updated A1AtScript and refactored several directives to use the
    A1AtScript's new DirectiveObject annotation pattern. Note: the old
    Directive annotation is still present so this is not a breaking change

0.0.3 / 2015-01-29
==================

  * BREAKING: AtScript Refactor -- while this should generally not affect
    existing code, merges to app.js may have conflicts that need resolution.
    All regular angular modules of projects should be added as dependencies of
    the main module in app.js as strings. Also, it may be important to check
    appConfig.js and rootController.js to make sure all changes are moved over.
  * Compass watch moved to top level, out of frontend

0.0.2 / 2015-01-26
==================

  * BREAKING: Split the frontend assets and backend API servers, with support for development
    (breaking because deployments will need config changes to support)
  * Changed clearfix styles to match Compass's clearfix
  * BREAKING CHANGE: Traceur updated. All calls to super() in ES6 classes must
    be updated to call super.instanceMethod() unless in a constructor
  * Menus are now retreived as a list from the server. backend.menu(name)
    searches that list and GETs the matching Menu if any. Note that
    backend.menu(name) returns a Promise of the Menu to be retrieved.
  * Changelog wrapped at 76 characters.

0.0.1 / 2015-01-19
==================

  * Initial Release
