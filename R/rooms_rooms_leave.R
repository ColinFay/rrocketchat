#' Rooms Leave
#'
#' Causes the callee to be removed from the room.
#'
#' @param token The token to connect to the app.
#' @param roomid The room’s id Required
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
rooms_rooms_leave <- function(tok,
                              roomid) {
  params <- list(
    roomid = roomid
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::POST(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/rooms.leave"),
    body = params
  )

  stop_for_status(res)
  content(res)
}
