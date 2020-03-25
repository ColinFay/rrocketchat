#' Get Discussions of A Room
#'
#' Retrieve the discussions of a room. It supports the Offset, Count, and Sort Query Parameters.
#'
#' @param token The token to connect to the app.
#' @param roomid The room id Required
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
chat_get_discussions_of_a_room <- function(tok,
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
    url = paste0(tok$url, "/api/v1/chat.getDiscussions")
  )

  stop_for_status(res)
  content(res)
}
