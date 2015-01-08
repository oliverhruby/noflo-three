noflo = require 'noflo'
unless noflo.isBrowser()
  chai = require 'chai' unless chai
  JSONLoader = require '../components/JSONLoader.coffee'
else
  JSONLoader = require 'noflo-three/components/JSONLoader.js'

describe 'JSONLoader component', ->
  c = null
  url = null
  geometry = null
  materials = null
  beforeEach ->
    c = JSONLoader.getComponent()
    url = noflo.internalSocket.createSocket()
    geometry = noflo.internalSocket.createSocket()
    materials = noflo.internalSocket.createSocket()
    c.inPorts.url.attach url
    c.outPorts.geometry.attach geometry
    c.outPorts.materials.attach materials

  describe 'when instantiated', ->
    it 'should have needed input ports', ->
      chai.expect(c.inPorts.url).to.be.an 'object'
    it 'should have needed output ports', ->
      chai.expect(c.outPorts.geometry).to.be.an 'object'
      chai.expect(c.outPorts.materials).to.be.an 'object'
    it 'should output the geometry', (done) ->
      geometry.once 'data', (res) ->
        chai.expect(res.vertices).to.be.an 'Array'
        done()
      url.send 'Model.json'
