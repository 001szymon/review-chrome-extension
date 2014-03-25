JS.Test.describe "OptionsStorage", ->

  @before ->
    @storage = new OptionsStorage()

  @after ->
    localStorage.clear()

  @it "stores and retrieves app token", ->
    @storage.setAppToken 'deadbeef'
    @assertEqual 'deadbeef', @storage.appToken()

  @it "stores and retrieves app url", ->
    @storage.setAppUrl 'http://example.com/'
    @assertEqual 'http://example.com/', @storage.appUrl()

  @it "adds backslash to the end of url if missing", ->
    @storage.setAppUrl 'http://example.com'
    @assertEqual 'http://example.com/', @storage.appUrl()
