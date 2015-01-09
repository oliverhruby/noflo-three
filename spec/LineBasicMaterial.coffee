noflo = require 'noflo'
unless noflo.isBrowser()
  chai = require 'chai' unless chai
  LineBasicMaterial = require '../components/LineBasicMaterial.coffee'
else
  LineBasicMaterial = require 'noflo-three/components/LineBasicMaterial.js'

describe 'LineBasicMaterial component', ->
  c = null
  color = null
  out = null
  beforeEach ->
    c = LineBasicMaterial.getComponent()
    color = noflo.internalSocket.createSocket()
    out = noflo.internalSocket.createSocket()
    c.inPorts.color.attach color
    c.outPorts.out.attach out

  describe 'when instantiated', ->
    it 'should have needed input ports', ->
      chai.expect(c.inPorts.color).to.be.an 'object'
    it 'should have an output port', ->
      chai.expect(c.outPorts.out).to.be.an 'object'
    it 'should output the three object', (done) ->
      out.once 'data', (res) ->
        chai.expect(res.color.r).to.equal 0
        chai.expect(res.color.g).to.equal 1
        chai.expect(res.color.b).to.equal 0
        done()
      color.send 1
