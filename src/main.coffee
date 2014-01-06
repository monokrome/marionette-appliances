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

  loadAppliance: (appliance) ->
    @appliances[appliance] = @module appliance

    {Controller} = @getComponent appliance, 'controller'

    return unless Controller?

    controller = new Controller
      application: @

    @appliances[appliance].controller = controller

    {Router} = @getComponent appliance, 'router'

    return unless Router?

    @appliances[appliance].router = new Router
      controller: controller

  initializeAppliances: ->
    @trigger 'appliances:initialized:before'

    for appliance in @appliances
      @loadAppliance appliance

    @trigger 'appliances:initialized'


Backbone.Marionette.ApplianceManager = ApplianceManager
