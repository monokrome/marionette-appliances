class ApplianceManager extends Backbone.Marionette.Application
  constructor: ->
    super

    @on 'initialize:before', @initializeAppliances

  getComponent: (appliance, type) ->
    try
      result = require appliance + '/' + type
      return result

    catch err
      return false

  getAppliance: (appliance) ->
    @appliances[appliance] = @module appliance

    {Controller} = @require appliance, 'controller'

    unless Controller?
      continue

    controller = new Controller
      application: @

    @appliances[appliance].controller = controller

    {Router} = @require appliance, 'router'

    unless Router?
      continue

    @appliances[appliance].router = new Router
      controller: controller

  initializeAppliances: ->
    @trigger 'appliances:initialized:before'

    @appliances = {}

    for appliance in appliances
      @loadAppliance appliance

    @trigger 'appliances:initialized'


Backbone.Marionette.ApplianceManager = ApplianceManager
