
EventsCollection = Space.cqrs.EventsCollection

describe "#{EventsCollection}", ->

  # System under test (EventsCollection)
  sut = null

  beforeEach ->
    # simulate meteor collection api
    @mongoCollection =
      findOne: sinon.stub()
      find: sinon.stub()
      insert: sinon.stub()
      _ensureIndex: sinon.spy()

    # simulate meteor Mongo api
    @mongo = Collection: sinon.stub().returns @mongoCollection

    sut = new EventsCollection()
    sut.mongo = @mongo

  it 'defines Mongo as its dependency', ->
    expect(EventsCollection::Dependencies.mongo).to.equal 'Mongo'


  describe '#onDependenciesReady', ->

    it 'creates a meteor collection for the events', ->

      sut.onDependenciesReady()
      expect(@mongo.Collection).to.have.been.calledWithNew

    it 'ensures a unique compound index', ->

      sut.onDependenciesReady()
      expect(@mongoCollection._ensureIndex).to.have.been.calledWithMatch(
        { "aggregateId": 1, "version": 1 }, unique: true
      )


  describe '#findOne', ->

    it 'delegates to the meteor collection and returns the result', ->

      sut.onDependenciesReady()

      selector = {}
      options = {}

      result = sut.findOne selector, options

      expect(@mongoCollection.findOne).to.have.been.calledWith selector, options
      expect(@mongoCollection.findOne).to.have.been.calledOn @mongoCollection


  describe '#find', ->

    it 'delegates to the meteor collection and returns the result', ->

      sut.onDependenciesReady()

      selector = {}
      options = {}

      result = sut.find selector, options

      expect(@mongoCollection.find).to.have.been.calledWith selector, options
      expect(@mongoCollection.find).to.have.been.calledOn @mongoCollection


  describe '#insert', ->

    it 'delegates to the meteor collection and returns the result', ->

      sut.onDependenciesReady()

      doc = {}
      callback = ->

      result = sut.insert doc, callback

      expect(@mongoCollection.insert).to.have.been.calledWith doc, callback
      expect(@mongoCollection.insert).to.have.been.calledOn @mongoCollection