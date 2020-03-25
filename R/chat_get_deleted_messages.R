#' Get Deleted Messages
#'
#' Retrieve message read receipts. It supports ONLY the Offset and Count Query Parameters
#'
#' @param token The token to connect to the app.
#' @param roomid The room id Required
#' @param since The date (ISODate) to search deleted messages Required
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
chat_get_deleted_messages <- function(tok,
                                      roomid,
                                      since) {
  params <- list(
    roomid = roomid,
    since = since
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::GET(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/chat.getDeletedMessages")
  )

  stop_for_status(res)
  content(res)
}
