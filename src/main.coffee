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

    appliances = @appliances
    @appliances = {}

    for appliance in appliances
      {Controller} = @require "#{appliance}/controller"

      if not Controller
        continue

      controller = new Controller
        application: @

      @appliances[appliance].controller = new Router

      {Router} = @require "#{appliance}/router"

      if not Router
        continue

      @appliances[appliance].router = new Router
        controller: controller

    @trigger 'appliances:initialized'


Marionette.ApplianceManager = ApplianceManager
