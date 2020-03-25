#' Send new chat message
#'
#' The difference between chat.postMessage and chat.sendMessage is that chat.sendMessage allows. for passing a value for _id and the other one doesn’t. Also, chat.sendMessage only sends it to. one channel whereas the other one allows for sending to more than one channel at a time.
#'
#' @param token The token to connect to the app.
#' @param message_id The _id of message. Required
#' @param message_rid The room id of where the message is to be sent. Required
#' @param message_tmid The message’s id to create a thread. Optional
#' @param message_msg The text of the message to send, is optional because of attachments. Optional
#' @param message_alias This will cause the message’s name to appear as the given alias, but your username will still display. Optional
#' @param message_emoji If provided, this will make the avatar on this message be an emoji. Emoji Cheetsheet Optional
#' @param message_avatar If provided, this will make the avatar use the provided image url. Optional
#' @param message_attachments See the below section, Attachments Detail, for details. Optional
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
chat_send_new_chat_message <- function(tok,
                                       message_id,
                                       message_rid,
                                       message_tmid = NULL,
                                       message_msg = NULL,
                                       message_alias = NULL,
                                       message_emoji = NULL,
                                       message_avatar = NULL,
                                       message_attachments = NULL) {
  params <- list(
    message_id = message_id,
    message_rid = message_rid,
    message_tmid = message_tmid,
    message_msg = message_msg,
    message_alias = message_alias,
    message_emoji = message_emoji,
    message_avatar = message_avatar,
    message_attachments = message_attachments
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::POST(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/chat.sendMessage"),
    body = params
  )

  stop_for_status(res)
  content(res)
}
