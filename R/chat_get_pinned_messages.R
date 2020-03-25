#' Get Pinned Messages
#'
#' Retrieve pinned messages from a room. It supports ONLY the Offset and Count Query Parameters
#'
#' @param token The token to connect to the app.
#' @param roomid The room id Required
#' @param offset See Offset Parameter Optional
#' @param count See Count Parameter Optional
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
chat_get_pinned_messages <- function(tok,
                                     roomid,
                                     offset = NULL,
                                     count = NULL) {
  params <- list(
    roomid = roomid,
    offset = offset,
    count = count
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::GET(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/chat.getPinnedMessages")
  )

  stop_for_status(res)
  content(res)
}
