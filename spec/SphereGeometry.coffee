noflo = require 'noflo'
unless noflo.isBrowser()
  chai = require 'chai' unless chai
  SphereGeometry = require '../components/SphereGeometry.coffee'
else
  SphereGeometry = require 'noflo-three/components/SphereGeometry.js'

describe 'SphereGeometry component', ->
  c = null
  radius = null
  out = null
  beforeEach ->
    c = SphereGeometry.getComponent()
    radius = noflo.internalSocket.createSocket()
    out = noflo.internalSocket.createSocket()
    c.inPorts.radius.attach radius
    c.outPorts.out.attach out

  describe 'when instantiated', ->
    it 'should have needed input ports', ->
      chai.expect(c.inPorts.radius).to.be.an 'object'
    it 'should have an output port', ->
      chai.expect(c.outPorts.out).to.be.an 'object'
    it 'should output the three object', (done) ->
      out.once 'data', (res) ->
        chai.expect(res.parameters.radius).to.equal 1
        #chai.expect(res.type).to.equal "SphereGeometry"
        done()
      radius.send 1
