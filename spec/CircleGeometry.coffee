noflo = require 'noflo'
unless noflo.isBrowser()
  chai = require 'chai' unless chai
  CircleGeometry = require '../components/CircleGeometry.coffee'
else
  CircleGeometry = require 'noflo-three/components/CircleGeometry.js'

describe 'CircleGeometry component', ->
  c = null
  radius = null
  segments = null
  thetastart = null
  thetalength = null
  out = null
  beforeEach ->
    c = CircleGeometry.getComponent()
    radius = noflo.internalSocket.createSocket()
    segments = noflo.internalSocket.createSocket()
    thetastart = noflo.internalSocket.createSocket()
    thetalength = noflo.internalSocket.createSocket()
    out = noflo.internalSocket.createSocket()
    c.inPorts.radius.attach radius
    c.inPorts.segments.attach segments
    c.inPorts.thetastart.attach thetastart
    c.inPorts.thetalength.attach thetalength
    c.outPorts.out.attach out

  describe 'when instantiated', ->
    it 'should have needed input ports', ->
      chai.expect(c.inPorts.radius).to.be.an 'object'
      chai.expect(c.inPorts.segments).to.be.an 'object'
      chai.expect(c.inPorts.thetastart).to.be.an 'object'
      chai.expect(c.inPorts.thetalength).to.be.an 'object'
    it 'should have an output port', ->
      chai.expect(c.outPorts.out).to.be.an 'object'
    it 'should output the three object', (done) ->
      out.once 'data', (res) ->
        chai.expect(res.parameters.radius).to.equal 1
        chai.expect(res.parameters.segments).to.equal 8
        chai.expect(res.parameters.thetaStart).to.equal 0
        chai.expect(res.parameters.thetaLength).to.equal 2*Math.PI
        done()
      radius.send 1
