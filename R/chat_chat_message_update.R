#' Chat Message Update
#'
#' @param token The token to connect to the app.
#' @param roomid The room id of where the message is. Required
#' @param msgid The message id to update. Required
#' @param text Updated text for the message. Required
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
chat_chat_message_update <- function(tok,
                                     roomid,
                                     msgid,
                                     text) {
  params <- list(
    roomid = roomid,
    msgid = msgid,
    text = text
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::POST(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/chat.update"),
    body = params
  )

  stop_for_status(res)
  content(res)
}
