class Person
  constructor: (@first, @last) ->

  fullname: ->  @first + ' ' + @last

module.exports.Person = Person
