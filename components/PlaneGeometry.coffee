noflo = require 'noflo'
THREE = require '../vendor/three.min.js'

exports.getComponent = ->
  c = new noflo.Component
  c.icon = 'cube'
  c.description = 'Create a plane geometry'

  c.inPorts.add 'width',
    datatype: 'number'
    process: (event, payload) ->
      return unless event is 'data'
      c.width = payload
      c.compute()

  c.inPorts.add 'height',
    datatype: 'number'
    process: (event, payload) ->
      return unless event is 'data'
      c.height = payload
      c.compute()

  c.outPorts.add 'out',
    datatype: 'object'

  c.compute = ->
    return unless c.width? and c.height?
    c.obj = new THREE.PlaneGeometry(c.width, c.height, 1, 1)
    return unless c.outPorts.out.isAttached()
    c.outPorts.out.send c.obj

  c
