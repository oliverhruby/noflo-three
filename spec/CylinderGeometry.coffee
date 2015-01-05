noflo = require 'noflo'
unless noflo.isBrowser()
  chai = require 'chai' unless chai
  CylinderGeometry = require '../components/CylinderGeometry.coffee'
else
  CylinderGeometry = require 'noflo-three/components/CylinderGeometry.js'

describe 'CylinderGeometry component', ->
  c = null
  radiustop = null
  radiusbottom = null
  height = null
  radialsegments = null
  heightsegments = null
  openended = null
  out = null
  beforeEach ->
    c = CylinderGeometry.getComponent()
    radiustop = noflo.internalSocket.createSocket()
    radiusbottom = noflo.internalSocket.createSocket()
    height = noflo.internalSocket.createSocket()
    radialsegments = noflo.internalSocket.createSocket()
    heightsegments = noflo.internalSocket.createSocket()
    openended = noflo.internalSocket.createSocket()
    out = noflo.internalSocket.createSocket()
    c.inPorts.radiustop.attach radiustop
    c.inPorts.radiusbottom.attach radiusbottom
    c.inPorts.height.attach height
    c.inPorts.radialsegments.attach radialsegments
    c.inPorts.heightsegments.attach heightsegments
    c.inPorts.openended.attach openended
    c.outPorts.out.attach out

  describe 'when instantiated', ->
    it 'should have needed input ports', ->
      chai.expect(c.inPorts.radiustop).to.be.an 'object'
      chai.expect(c.inPorts.radiusbottom).to.be.an 'object'
      chai.expect(c.inPorts.height).to.be.an 'object'
      chai.expect(c.inPorts.radialsegments).to.be.an 'object'
      chai.expect(c.inPorts.heightsegments).to.be.an 'object'
      chai.expect(c.inPorts.openended).to.be.an 'object'
    it 'should have an output port', ->
      chai.expect(c.outPorts.out).to.be.an 'object'
    it 'should output the three object', (done) ->
      out.once 'data', (res) ->
        chai.expect(res.parameters.radiusTop).to.equal 1
        chai.expect(res.parameters.radiusBottom).to.equal 20
        chai.expect(res.parameters.height).to.equal 100
        chai.expect(res.parameters.radialSegments).to.equal 8
        chai.expect(res.parameters.heightSegments).to.equal 1
        chai.expect(res.parameters.openEnded).to.equal false
        done()
      radiustop.send 1
