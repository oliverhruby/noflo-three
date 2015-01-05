noflo = require 'noflo'
THREE = require '../vendor/three.min.js'

exports.getComponent = ->
  c = new noflo.Component
  c.icon = 'cube'
  c.description = 'Orthographic camera'

  c.inPorts.add 'position',
    datatype: 'object'
    process: (event, payload) ->
      return unless event is 'data'
      #c.obj.position = payload
      c.obj = new THREE.OrthographicCamera window.innerWidth/ - 2, window.innerWidth / 2, window.innerHeight / 2, window.innerHeight / - 2, 1, 1000
      
      return unless c.outPorts.out.isAttached()
      c.outPorts.out.send c.obj

  c.outPorts.add 'out',
    datatype: 'object'

  c
