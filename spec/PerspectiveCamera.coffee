noflo = require 'noflo'
unless noflo.isBrowser()
  chai = require 'chai' unless chai
  PerspectiveCamera = require '../components/PerspectiveCamera.coffee'
else
  PerspectiveCamera = require 'noflo-three/components/PerspectiveCamera.js'

describe 'PerspectiveCamera component', ->
  c = null
  position = null
  out = null
  beforeEach ->
    c = PerspectiveCamera.getComponent()
    position = noflo.internalSocket.createSocket()
    out = noflo.internalSocket.createSocket()
    c.inPorts.position.attach position
    c.outPorts.out.attach out

  describe 'when instantiated', ->
    it 'should have needed input ports', ->
      chai.expect(c.inPorts.position).to.be.an 'object'
    it 'should have an output port', ->
      chai.expect(c.outPorts.out).to.be.an 'object'
    it 'should output the three object', (done) ->
      out.once 'data', (res) ->
        chai.expect(res.fov).to.equal 75
        done()
      position.send 1
