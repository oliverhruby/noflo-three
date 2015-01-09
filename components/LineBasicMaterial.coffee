noflo = require 'noflo'
THREE = require '../vendor/three.min.js'

exports.getComponent = ->
  c = new noflo.Component
  c.icon = 'cube'
  c.description = 'Create line basic material'

  c.inPorts.add 'color',
    datatype: 'object'
    process: (event, payload) ->
      return unless event is 'data'
      c.obj = new THREE.LineBasicMaterial({color: 0x00ff00})
      return unless c.outPorts.out.isAttached()
      c.outPorts.out.send c.obj

  c.outPorts.add 'out',
    datatype: 'object'

  c
