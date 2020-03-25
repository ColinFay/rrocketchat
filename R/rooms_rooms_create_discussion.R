#' Rooms create discussion
#'
#' Creates a new discussion for room. It requires at least one of the following permissions: start-discussion OR start-discussion-other-user, AND must be with the following. setting enabled: Discussion_enabled.
#'
#' @param token The token to connect to the app.
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
rooms_create_discussion <- function(tok) {
  res <- httr::POST(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/rooms.createDiscussion"),
    body = params
  )

  stop_for_status(res)
  content(res)
}
