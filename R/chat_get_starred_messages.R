#' Get Starred Messages
#'
#' Retrieve starred messages. It supports the Offset, Count, and Sort Query Parameters.
#'
#' @param token The token to connect to the app.
#' @param roomid The room id Required
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
chat_get_starred_messages <- function(tok,
                                      roomid) {
  params <- list(
    roomid = roomid
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::GET(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/chat.getStarredMessages")
  )

  stop_for_status(res)
  content(res)
}
