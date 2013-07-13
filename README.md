marionette-appliances
=====================

Adds the concept of small modular appliances to MarionetteJS.

Usage
-----

In a simple case where you have a function called require() that can require
JavaScript models, you should be able to simply do the following:

  class ExampleApplication extends Marionette.ApplianceManager
    appliances: [
      'example'
    ]

After loading your application, it will attempt the following process:

1) Call `require("example/controller")` and expect it to export an object
called `Controller` which extends `Marionette.AppRouter`. If a controller is
found, it will be instantiated and pass your `Application` instance as the
`application' option to the controller. This allows `this.options.application`
to refer to the current application instance for every appliance controller.

If the Controller does not exist, then the next step will be skipped.

2) Since we have found a `Controller`, attempt to `require("example/router")`
and expect this to export an object called `Router` which extends
`Marionette.AppRouter`. If the object exists, it will instantiate the provided
`Router` passing the controller instance as the `controller` option.

3) Restart this process with the next appliance until all appliances have been
created.

4) Assign all routers to application.routers[applianceName], so that appliances
can communicate with eachother via events or function calls if necessary.

This seems very simple, but the structure implied by it provides a set of
conventions which make working with large apps very simple.

Why not use Marionette's modules?
---------------------------------

They solve a different problem. You could use modules along with this if you
wanted sub-appliancemanagers. However, the authors of this library do not
recommend using Marionette's modules, because the problem which they solve
is solved poorly and therefore represents an anti-pattern in Marionette itself.

