noflo = require 'noflo'
unless noflo.isBrowser()
  chai = require 'chai' unless chai
  WebGLRenderer = require '../components/WebGLRenderer.coffee'
else
  WebGLRenderer = require 'noflo-three/components/WebGLRenderer.js'

describe 'WebGLRenderer component', ->
  c = null
  tick = null
  width = null
  height = null
  beforeEach ->
    c = WebGLRenderer.getComponent()
    tick = noflo.internalSocket.createSocket()
    width = noflo.internalSocket.createSocket()
    height = noflo.internalSocket.createSocket()
    c.inPorts.tick.attach tick
    c.inPorts.width.attach width
    c.inPorts.height.attach height
    # c.outPorts.out.attach out

  describe 'when instantiated', ->
    it 'should have needed input ports', ->
      chai.expect(c.inPorts.tick).to.be.an 'object'
      chai.expect(c.inPorts.width).to.be.an 'object'
      chai.expect(c.inPorts.height).to.be.an 'object'
    # it 'should have an output port', ->
    #   chai.expect(c.outPorts.out).to.be.an 'object'
