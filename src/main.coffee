class ApplianceManager extends Backbone.Marionette.Application
  constructor: ->
    super

    @on 'initialize:before', @initializeAppliances

  require: (module) ->
    try
      result = require module
      return result

    catch err
      return false

  initializeAppliances: ->
    @trigger 'appliances:initialized:before'

    routers = {}

    for appliance in @appliances
      {Controller} = @require "#{appliance}/controller"

      if not Controller
        continue

      controller = new Controller
        application: @

      {Router} = @require "#{appliance}/router"

      if not Router
        continue

      router = routers[appliance] = new Router
        controller: controller

    @appliances.routers = routers
    @trigger 'appliances:initialized'


Marionette.ApplianceManager = ApplianceManager
