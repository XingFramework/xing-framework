The Xing Framework
===
***To learn more about the Xing Framework, read the [Xing Book](https://xingframework.gitbooks.io/the-xing-framework/content/).***

The Xing Framework is a cutting edge web and mobile development platform by
Logical Reality Design, Inc.  It is designed to provide a completely modern
(and even somewhat future-proofed) API + SPA web development platform with
sensible defaults, solid conventions, and ease of rapid development. Xing uses
Rails (4.2) on the backend and AngularJS (1.4) on the frontend.  Most of the
problems inherent in getting these two frameworks to talk to each other cleanly
have been pre-solved in Xing.

This gem is the command line tool for xing to generate new projects.

[![Code Climate](https://codeclimate.com/github/XingFramework/xing-framework/badges/gpa.svg)](https://codeclimate.com/github/XingFramework/xing-framework)
[![Test Coverage](https://codeclimate.com/github/XingFramework/xing-framework/badges/coverage.svg)](https://codeclimate.com/github/XingFramework/xing-framework/coverage)
[![Build Status](https://travis-ci.org/XingFramework/xing-framework.svg?branch=master)](https://travis-ci.org/XingFramework/xing-framework)
[![Dependency Status](https://gemnasium.com/XingFramework/xing-framework.svg)](https://gemnasium.com/XingFramework/xing-framework)

Purpose
---

The xing-framework gem itself is only used for code generation.  Once you have set up your project, you can keep it around
for the other code generators (scaffolds etc.). Alternatively, feel free to uninstall it entirely. Xing does not otherwise
need it to run.

Starting a Project
-----------

The command:

```xing new <project_name>```

will generate an empty Xing project with the basic directory structure, including Gemfile(s) and package.json file(s) to bring in all the necessary rubygems and npm modules for a Xing Framework project.

Generating Scaffolds
-------

TODO:  Xing will soon have Rails-like scaffold generation.

Authors
-------

* Evan Dorn

Version
-------

Untagged version, not yet ready for release

The Xing Framework strives to be an open and inclusive project. All Contributors to the Xing Framework must abide by our [Code Of Conduct](CODE_OF_CONDUCT.md)
