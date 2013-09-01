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
      @appliances[appliance] = {}

      {Controller} = @require "#{appliance}/controller"

      unless Controller?
        continue

      controller = new Controller
        application: @

      @appliances[appliance].controller = new Router

      {Router} = @require "#{appliance}/router"

      unless Router?
        continue

      @appliances[appliance].router = new Router
        controller: controller

    @trigger 'appliances:initialized'


Marionette.ApplianceManager = ApplianceManager
