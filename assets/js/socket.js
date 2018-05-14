import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})

socket.connect()

const createSocket = (topicId) => {
  let channel = socket.channel(`comments:${topicId}`, {})

  channel.join()
    .receive("ok", resp => {
      renderComments(resp.comments)
    })
    .receive("error", resp => { console.log("Unable to join", resp) })

  channel.on(`comments:${topicId}:new`, renderComment)

  document.querySelector('button').addEventListener('click', function () {
    const content = document.querySelector('textarea').value

    channel.push('comment:add', { content })
  })
}

const renderComments = (comments) => {
  const renderedComments = comments.map(commentTemplate)

  document.querySelector('.collection').innerHTML = renderedComments.join('')
}

const renderComment = (event) => {
  const renderedComment = commentTemplate(event.comment)
  document.querySelector('.collection').innerHTML += renderedComment
}

const commentTemplate = (comment) => {
  const email = comment.user ? comment.user.email : 'Anonymous'

  return `
    <li class="collection-item">
      ${comment.content}
      <div class="secondary-content">
        ${email}
      </div>
    </li>
  `
}

window.createSocket = createSocket
