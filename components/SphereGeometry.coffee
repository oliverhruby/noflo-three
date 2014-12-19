noflo = require 'noflo'
THREE = require '../vendor/three.min.js'

exports.getComponent = ->
  c = new noflo.Component
  c.icon = 'cube'
  c.description = 'Create a sphere geometry'

  c.inPorts.add 'radius',
    datatype: 'number'
    process: (event, payload) ->
      return unless event is 'data'
      c.radius = payload
      c.compute()

  c.inPorts.add 'widthsegments',
    datatype: 'number'
    process: (event, payload) ->
      return unless event is 'data'
      c.widthsegments = payload
      c.compute()

  c.inPorts.add 'heightsegments',
    datatype: 'number'
    process: (event, payload) ->
      return unless event is 'data'
      c.heightsegments = payload
      c.compute()

  c.outPorts.add 'out',
    datatype: 'object'

  c.compute = ->
    return unless c.radius?
    c.obj = new THREE.SphereGeometry(c.radius)
    return unless c.outPorts.out.isAttached()
    c.outPorts.out.send c.obj

  c
