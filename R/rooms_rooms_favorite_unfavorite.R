#' Rooms Favorite/Unfavorite
#'
#' Favorite or unfavorite room.
#'
#' @param token The token to connect to the app.
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
rooms_favorite_unfavorite <- function(tok) {
  res <- httr::POST(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/rooms.favorite"),
    body = params
  )

  stop_for_status(res)
  content(res)
}
