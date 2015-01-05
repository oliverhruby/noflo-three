noflo = require 'noflo'
unless noflo.isBrowser()
  chai = require 'chai' unless chai
  OrthographicCamera = require '../components/OrthographicCamera.coffee'
else
  OrthographicCamera = require 'noflo-three/components/OrthographicCamera.js'

describe 'OrthographicCamera component', ->
  c = null
  position = null
  out = null
  beforeEach ->
    c = OrthographicCamera.getComponent()
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
        chai.expect(res.near).to.equal 1
        chai.expect(res.far).to.equal 1000
        done()
      position.send 1
