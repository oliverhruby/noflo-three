noflo = require 'noflo'
unless noflo.isBrowser()
  chai = require 'chai' unless chai
  PointLight = require '../components/PointLight.coffee'
else
  PointLight = require 'noflo-three/components/PointLight.js'

describe 'PointLight component', ->
  c = null
  color = null
  out = null
  beforeEach ->
    c = PointLight.getComponent()
    color = noflo.internalSocket.createSocket()
    out = noflo.internalSocket.createSocket()
    c.inPorts.color.attach color
    c.outPorts.out.attach out

  describe 'when instantiated', ->
    it 'should have needed input ports', ->
      chai.expect(c.inPorts.color).to.be.an 'object'
    it 'should have an output port', ->
      chai.expect(c.outPorts.out).to.be.an 'object'
