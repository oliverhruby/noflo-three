noflo = require 'noflo'
unless noflo.isBrowser()
  chai = require 'chai' unless chai
  TextGeometry = require '../components/TextGeometry.coffee'
else
  TextGeometry = require 'noflo-three/components/TextGeometry.js'

describe 'TextGeometry component', ->
  c = null
  text = null
  out = null
  beforeEach ->
    c = TextGeometry.getComponent()
    text = noflo.internalSocket.createSocket()
    out = noflo.internalSocket.createSocket()
    c.inPorts.text.attach text
    c.outPorts.out.attach out

  describe 'when instantiated', ->
    it 'should have needed input ports', ->
      chai.expect(c.inPorts.text).to.be.an 'object'
    it 'should have an output port', ->
      chai.expect(c.outPorts.out).to.be.an 'object'
    it 'should output the three object', (done) ->
      out.once 'data', (res) ->
        chai.expect(res.parameters.text).to.equal "hello"
        done()
      text.send "hello"
