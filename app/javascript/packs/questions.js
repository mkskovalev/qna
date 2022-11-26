$(document).on('turbolinks:load', function() {
  $('.question').on('click', '.edit-question-link', function(e) {
    e.preventDefault()
    $(this).hide()
    $('#edit-question-form').removeClass('hidden')
  })

  $('.question-like').on('ajax:success', function(e) {
    $('.question-rating').html(e.detail[0])
  })

  $('.question-unlike').on('ajax:success', function(e) {
    $('.question-rating').html(e.detail[0])
  })

  $('.new-question-comment').on('ajax:success', function(e) {
    $('.question-comments-list').append(e.detail[2].response)
    $('.new-question-comment #comment_body').val('')
  })
})
