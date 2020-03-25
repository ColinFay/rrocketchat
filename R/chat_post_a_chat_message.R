#' Post a chat message
#'
#' You only can send alias and avatar properties if your user has the bot role. We implement this rule to avoid users to impersonate other users.
#'
#' @param token The token to connect to the app.
#' @param roomid_channel The room id of where the message is to be sent.  The channel name with the prefix in front of it. Required
#' @param text The text of the message to send, is optional because of attachments. Optional
#' @param alias This will cause the message’s name to appear as the given alias, but your username will still display. Optional
#' @param emoji If provided, this will make the avatar on this message be an emoji. Emoji Cheetsheet Optional
#' @param avatar If provided, this will make the avatar use the provided image url. Optional
#' @param attachments See the below section, Attachments Detail, for details. Optional
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
chat_post_a_chat_message <- function(tok,
                                     roomid_channel,
                                     text = NULL,
                                     alias = NULL,
                                     emoji = NULL,
                                     avatar = NULL,
                                     attachments = NULL) {
  params <- list(
    roomid_channel = roomid_channel,
    text = text,
    alias = alias,
    emoji = emoji,
    avatar = avatar,
    attachments = attachments
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::POST(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/chat.postMessage"),
    body = params
  )

  stop_for_status(res)
  content(res)
}
