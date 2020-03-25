#' Rooms Admin Rooms
#'
#' Retrieves all rooms (requires the view-room-administration permission). It supports the Offset, Count, and Sort Query Parameters.
#'
#' @param token The token to connect to the app.
#' @param types The rooms types Optional (must be an array)
#' @param filter The rooms’s name Optional
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
rooms_rooms_admin_rooms <- function(tok,
                                    types = NULL,
                                    filter = NULL) {
  params <- list(
    types = types,
    filter = filter
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::GET(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/rooms.adminRooms")
  )

  stop_for_status(res)
  content(res)
}
