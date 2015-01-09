noflo = require 'noflo'
unless noflo.isBrowser()
  chai = require 'chai' unless chai
  SpotLight = require '../components/SpotLight.coffee'
else
  SpotLight = require 'noflo-three/components/SpotLight.js'

describe 'SpotLight component', ->
  c = null
  color = null
  out = null
  beforeEach ->
    c = SpotLight.getComponent()
    color = noflo.internalSocket.createSocket()
    out = noflo.internalSocket.createSocket()
    c.inPorts.color.attach color
    c.outPorts.out.attach out

  describe 'when instantiated', ->
    it 'should have needed input ports', ->
      chai.expect(c.inPorts.color).to.be.an 'object'
    it 'should have an output port', ->
      chai.expect(c.outPorts.out).to.be.an 'object'
