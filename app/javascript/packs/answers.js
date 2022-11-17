$(document).on('turbolinks:load', function() {
  $('.answers').on('click', '.edit-answer-link', function(e) {
    e.preventDefault()
    $(this).hide()
    var answerId = $(this).data('answerId')
    $('form#edit-answer-' + answerId).removeClass('hidden')
  })

  $('.answers').on('click', '.answer-like', function(e) {
    var answerId = $(this).data('answerId')
    $('.answer-like').on('ajax:success', function(e) {
      $('.answer-' + answerId + '-rating').html(e.detail[0])
    })
  })

  $('.answers').on('click', '.answer-unlike', function(e) {
    var answerId = $(this).data('answerId')
    $('.answer-unlike').on('ajax:success', function(e) {
      $('.answer-' + answerId + '-rating').html(e.detail[0])
    })
  })
})
