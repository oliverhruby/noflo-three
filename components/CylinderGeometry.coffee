noflo = require 'noflo'
THREE = require '../vendor/three.min.js'

exports.getComponent = ->
  c = new noflo.Component
  c.icon = 'cube'
  c.description = 'Create a cylinder geometry'

  c.radiustop = 20
  c.radiusbottom = 20
  c.height = 100
  c.radialsegments = 8
  c.heightsegments = 1
  c.openended = false

  c.inPorts.add 'radiustop',
    datatype: 'number'
    process: (event, payload) ->
      return unless event is 'data'
      c.radiustop = payload
      c.compute()

  c.inPorts.add 'radiusbottom',
    datatype: 'number'
    process: (event, payload) ->
      return unless event is 'data'
      c.radiusbottom = payload
      c.compute()

  c.inPorts.add 'height',
    datatype: 'number'
    process: (event, payload) ->
      return unless event is 'data'
      c.height = payload
      c.compute()

  c.inPorts.add 'radialsegments',
    datatype: 'number'
    process: (event, payload) ->
      return unless event is 'data'
      c.radialsegments = payload
      c.compute()

  c.inPorts.add 'heightsegments',
    datatype: 'number'
    process: (event, payload) ->
      return unless event is 'data'
      c.heightsegments = payload
      c.compute()

  c.inPorts.add 'openended',
    datatype: 'boolean'
    process: (event, payload) ->
      return unless event is 'data'
      c.openended = payload
      c.compute()

  c.outPorts.add 'out',
    datatype: 'object'

  c.compute = ->
    c.obj = new THREE.CylinderGeometry c.radiustop, c.radiusbottom, c.height, c.radialsegments, c.heightsegments, c.openended
    return unless c.outPorts.out.isAttached()
    c.outPorts.out.send c.obj

  c
