noflo = require 'noflo'
unless noflo.isBrowser()
  chai = require 'chai' unless chai
  Vector3 = require '../components/Vector3.coffee'
else
  Vector3 = require 'noflo-three/components/Vector3.js'

describe 'Vector3 component', ->
  c = null
  x = null
  y = null
  z = null
  out = null
  beforeEach ->
    c = Vector3.getComponent()
    x = noflo.internalSocket.createSocket()
    y = noflo.internalSocket.createSocket()
    z = noflo.internalSocket.createSocket()
    out = noflo.internalSocket.createSocket()
    c.inPorts.x.attach x
    c.inPorts.y.attach y
    c.inPorts.z.attach z
    c.outPorts.out.attach out

  describe 'when instantiated', ->
    it 'should have needed input ports', ->
      chai.expect(c.inPorts.x).to.be.an 'object'
      chai.expect(c.inPorts.y).to.be.an 'object'
      chai.expect(c.inPorts.z).to.be.an 'object'
    it 'should have an output port', ->
      chai.expect(c.outPorts.out).to.be.an 'object'
    it 'should output the three object', (done) ->
      out.once 'data', (res) ->
        chai.expect(res.x).to.equal 1
        chai.expect(res.y).to.equal 2
        chai.expect(res.z).to.equal 3
        done()
      x.send 1
      y.send 2
      z.send 3
