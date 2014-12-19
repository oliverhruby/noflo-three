noflo = require 'noflo'
THREE = require '../vendor/three.min.js'

exports.getComponent = ->
  c = new noflo.Component
  c.icon = 'cube'
  c.description = 'JSON Loader'

  c.inPorts.add 'url',
    datatype: 'string'
    process: (event, payload) ->
      return unless event is 'data'
      loader = new THREE.JSONLoader()
      loader.load payload, (geometry, materials) ->
        c.geometry = geometry
        c.materials = materials
        c.compute()
        return
      return

  c.outPorts.add 'geometry',
    datatype: 'object'

  c.outPorts.add 'materials',
    datatype: 'object'

  c.compute = ->
    return unless c.materials? and c.geometry?
    if c.outPorts.geometry.isAttached()
      c.outPorts.geometry.send c.geometry 
    if c.outPorts.materials.isAttached()
      c.outPorts.materials.send c.materials

  c
