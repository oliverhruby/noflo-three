noflo = require 'noflo'
THREE = require '../vendor/three.min.js'

exports.getComponent = ->
  c = new noflo.Component
  c.icon = 'cube'
  c.description = 'Create a circle geometry'

  c.radius = 50
  c.segments = 8
  c.thetastart = 0
  c.thetalength = 2 * Math.PI

  c.inPorts.add 'radius',
    datatype: 'number'
    process: (event, payload) ->
      return unless event is 'data'
      c.radius = payload
      c.compute()

  c.inPorts.add 'segments',
    datatype: 'number'
    process: (event, payload) ->
      return unless event is 'data'
      c.segments = payload
      c.compute()

  c.inPorts.add 'thetastart',
    datatype: 'number'
    process: (event, payload) ->
      return unless event is 'data'
      c.thetastart = payload
      c.compute()

  c.inPorts.add 'thetalength',
    datatype: 'number'
    process: (event, payload) ->
      return unless event is 'data'
      c.thetalength = payload
      c.compute()

  c.outPorts.add 'out',
    datatype: 'object'

  c.compute = ->
    c.obj = new THREE.CircleGeometry c.radius, c.segments, c.thetastart, c.thetalength
    return unless c.outPorts.out.isAttached()
    c.outPorts.out.send c.obj

  c
