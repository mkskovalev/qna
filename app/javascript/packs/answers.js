$(document).on('turbolinks:load', function() {
  $('.answers').on('click', '.edit-answer-link', function(e) {
    e.preventDefault()
    $(this).hide()
    var answerId = $(this).data('answerId')
    $('form#edit-answer-' + answerId).removeClass('hidden')
  })

  $('.answer-votes').on('click', '.answer-like', function(e) {
    $('.answer-like').on('ajax:success', function(e) {
      var answerId = $(this).data('answerId')
      $('.answer-' + answerId + '-rating').html(e.detail[0])
    })
  })

  $('.answer-votes').on('click', '.answer-unlike', function(e) {
    $('.answer-unlike').on('ajax:success', function(e) {
      var answerId = $(this).data('answerId')
      $('.answer-' + answerId + '-rating').html(e.detail[0])
    })
  })

  $('.new-answer-comment').on('ajax:success', function(e) {
    var answerId = $(this).data('answerId')
    $('#answer-' + answerId + ' .answer-comments').append(e.detail[2].response)
    $('.new-answer-comment #comment_body').val('')
  })
})
