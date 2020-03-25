#' Rooms Clean History
#'
#' Cleans up a room, removing messages from the provided time range.
#'
#' @param token The token to connect to the app.
#' @param roomid The room’s id Required
#' @param latest The end of time range of messages to clean Required
#' @param oldest The start of the time range of messages to clean Required
#' @param inclusive Whether messages which land on latest and oldest should be included Optional  Default: false
#' @param excludepinned Whether pinned messages should be deleted Optional  Default: false
#' @param filesonly Whether to only delete files and keep messages intact Optional  Default: false
#' @param users Specific set of users whose content to delete Optional  Default: [] (everyone)
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
rooms_rooms_clean_history <- function(tok,
                                      roomid,
                                      latest,
                                      oldest,
                                      inclusive = NULL,
                                      excludepinned = NULL,
                                      filesonly = NULL,
                                      users = NULL) {
  params <- list(
    roomid = roomid,
    latest = latest,
    oldest = oldest,
    inclusive = inclusive,
    excludepinned = excludepinned,
    filesonly = filesonly,
    users = users
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::POST(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/rooms.cleanHistory"),
    body = params
  )

  stop_for_status(res)
  content(res)
}
