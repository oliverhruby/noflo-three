noflo = require 'noflo'
THREE = require '../vendor/three.min.js'

exports.getComponent = ->
  c = new noflo.Component
  c.icon = 'lightbulb-o'
  c.description = 'Point light'

  c.inPorts.add 'color',
    datatype: 'string'
    process: (event, payload) ->
      return unless event is 'data'
      c.obj = new THREE.PointLight(payload)
      return unless c.outPorts.out.isAttached()
      c.outPorts.out.send c.obj

  c.outPorts.add 'out',
    datatype: 'object'

  c
