App.comments = App.cable.subscriptions.create('CommentsChannel', {
  received: function(data) {
  const new_comment = data.comment;
  document.getElementById('message-board-public').insertAdjacentHTML('afterbegin', new_comment );
  }
  });
