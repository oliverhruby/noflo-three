noflo = require 'noflo'
unless noflo.isBrowser()
  chai = require 'chai' unless chai
  PlaneGeometry = require '../components/PlaneGeometry.coffee'
else
  PlaneGeometry = require 'noflo-three/components/PlaneGeometry.js'

describe 'PlaneGeometry component', ->
  c = null
  width = null
  height = null
  out = null
  beforeEach ->
    c = PlaneGeometry.getComponent()
    width = noflo.internalSocket.createSocket()
    height = noflo.internalSocket.createSocket()
    out = noflo.internalSocket.createSocket()
    c.inPorts.width.attach width
    c.inPorts.height.attach height
    c.outPorts.out.attach out

  describe 'when instantiated', ->
    it 'should have needed input ports', ->
      chai.expect(c.inPorts.width).to.be.an 'object'
      chai.expect(c.inPorts.height).to.be.an 'object'
    it 'should have an output port', ->
      chai.expect(c.outPorts.out).to.be.an 'object'
    it 'should output the three object', (done) ->
      out.once 'data', (res) ->
        chai.expect(res.parameters.width).to.equal 1
        chai.expect(res.parameters.height).to.equal 1
        done()
      width.send 1
      height.send 1
