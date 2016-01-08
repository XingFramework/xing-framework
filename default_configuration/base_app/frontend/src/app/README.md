# The `src/app` Directory

## Overview

```
src/
  |- app/
  |  |- auth/
  |  |- pages/
  |  |- homepage/
  |  |- app.js
  |  |- appConfig.js
  |  |- rootController.js
```

The `src/app` directory contains all code specific to this application. Apart
from `app.js` , this directory is
filled with subdirectories corresponding to high-level sections of the
application, often corresponding to top-level routes. Each directory can have as
many subdirectories as it needs, and the build system will understand what to
do. For example, a top-level route might be "products", which would be a folder
within the `src/app` directory that conceptually corresponds to the top-level
route `/products`, though this is in no way enforced. Products may then have
subdirectories for "create", "view", "search", etc. The "view" submodule may
then define a route of `/products/:id`, ad infinitum.

## `app.js`

This is our main app configuration file. It kickstarts the whole process by
requiring all the modules from `src/app` that we need. We must load these now to
ensure the routes are loaded. If as in our "products" example there are
subroutes, we only require the top-level module, and allow the submodules to
require their own submodules.

As a matter of course, we also require the template modules that are generated
during the build.

However, the modules from `src/common` should be required by the app
submodules that need them to ensure proper dependency handling. These are
app-wide dependencies that are required to assemble your app.

```js
var app = new Module(appName, [
  'templates-app', 'templates-common', 'ui.router',
  'picardy.fontawesome',
  StateAttrs,
  UIRouteLogger,
  Menus,
  Homepage,
  Auth,
  Admin,
  ResponsiveMenu,
  Metadata,
  ExampleForm,
  SessionLinks,
  Toast,
  Pages,
  Backend,
  NavigationBar,
  appConfig,
  RootCtrl
]);
```

With app modules broken down in this way, all routing is performed by the
submodules we include, as that is where our app's functionality is really
defined.  So all we need to do in `app.js` is specify a default route to follow,
which route of course is defined in a submodule.
