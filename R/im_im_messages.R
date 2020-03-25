#' Im messages
#'
#' Lists all of the specific direct message on the server. It supports the Offset, Count, and Sort Query Parameters along with Query and Fields Query Parameters.
#'
#' @param token The token to connect to the app.
#' @param roomid The channel’s id Required(if no username)
#' @param username The username of DM Required(if no roomId)
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
im_im_messages <- function(tok,
                           roomid,
                           username) {
  params <- list(
    roomid = roomid,
    username = username
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::GET(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/im.messages")
  )

  stop_for_status(res)
  content(res)
}
