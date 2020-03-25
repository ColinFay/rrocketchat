#' Get a Single Chat Message
#'
#' Retrieves a single chat message by the provided id. Callee must have permission to access the room where the message resides.
#'
#' @param token The token to connect to the app.
#' @param msgid The id of the message to get. Required
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
chat_get_a_single_chat_message <- function(tok,
                                           msgid) {
  params <- list(
    msgid = msgid
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::GET(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/chat.getMessage")
  )

  stop_for_status(res)
  content(res)
}
