noflo = require 'noflo'
THREE = require '../vendor/three.min.js'

exports.getComponent = ->
  c = new noflo.Component
  c.icon = 'cube'
  c.description = 'Create a text geometry'

  c.inPorts.add 'text',
    datatype: 'string'
    process: (event, payload) ->
      return unless event is 'data'
      c.text = payload
      c.compute()

  c.outPorts.add 'out',
    datatype: 'object'

  c.compute = ->
    return unless c.text?
    c.obj = new THREE.TextGeometry c.text
    return unless c.outPorts.out.isAttached()
    c.outPorts.out.send c.obj

  c
