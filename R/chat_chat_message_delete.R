#' Chat Message Delete
#'
#' @param token The token to connect to the app.
#' @param roomid The room id of where the message is to delete. Required
#' @param msgid The message id to delete. Required
#' @param asuser Whether the message should be deleted as the user who sent it. Optional  Default: false
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
chat_chat_message_delete <- function(tok,
                                     roomid,
                                     msgid,
                                     asuser = NULL) {
  params <- list(
    roomid = roomid,
    msgid = msgid,
    asuser = asuser
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::POST(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/chat.delete"),
    body = params
  )

  stop_for_status(res)
  content(res)
}
