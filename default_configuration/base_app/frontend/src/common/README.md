# The `src/common/` Directory

The `src/common/` directory is reusable components that serve as the business logic of the application. They may be specific to this application, but should be organized so that they can be easily copied and reused in another application. In general user visible components like directives, controllers, states, and templates should not live here.

```
src/
  |- common/
  |  |- resources
  |  |- components
  |  |- config.js
  |  |- environment.js
  |  |- AppBackend.js
```

- `resources` - this houses sub-classes of BackendResource which provide an object oriented interface to backend data
- `components` - reusuable UI components, usually directives, that do not make up an entire new view on the page that would change the URL
- config.js - contains important configuration variables used throughout the app
- environment.js - DON'T EDIT THIS FILE. it gets regenerated. instead, edit the individual environment files in frontend/config
- AppBackend.js provides app specific endpoints to the backend
