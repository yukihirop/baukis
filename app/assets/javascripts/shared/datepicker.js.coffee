$(document).on 'page:change', ->
#  今日の日付
  d = new Date()
  $.datepicker.setDefaults({
    dateFormat: 'yy-mm-dd'
    minDate: new Date(2000, 1, 1)
    maxDate: new Date(d.getFullYear() + 1, d.getMonth(), d.getDate() - 1)
  })
#  class属性にdatepickerが指定されたすべての要素に対して
  $('.datepicker').datepicker()

