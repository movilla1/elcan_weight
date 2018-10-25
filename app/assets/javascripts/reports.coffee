# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$("#truck_id_select2").select2
  theme: 'bootstrap'
  ajax:
    data: (term, page) ->
      term: term
      page: page

    dataType: "json"
    quietMillis: 100
    results: (data, page) ->
      results: data
    url: $("#dropdown_select2").data("url")
  initSelection: (item, callback)->
    id = item.val()
    text = item.data('option')
    data = { id: id, text: text }
    callback(data)
  createSearchChoice: (term, data) ->
    if $(data).filter(->
      @text.localeCompare(term) is 0
    ).length is 0
      id: term
      text: term