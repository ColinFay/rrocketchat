#' Channel List Joined
#'
#' Lists all of the channels the calling user has joined. It supports the Offset, Count, and Sort Query Parameters along with just the Fields Query Parameter.
#'
#' @param token The token to connect to the app.
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
channel_list_joined <- function(tok) {
  res <- httr::GET(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/channels.list.joined")
  )

  stop_for_status(res)
  content(res)
}
