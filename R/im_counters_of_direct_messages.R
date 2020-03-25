#' Counters of Direct Messages
#'
#' Gets counters of direct messages.
#'
#' @param token The token to connect to the app.
#' @param roomid The id of Direct Messages’ Room Required
#' @param username Counters for provided username (need to have a view-room-administration right for calling user) Optional
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
im_counters_of_direct_messages <- function(tok,
                                           roomid,
                                           username = NULL) {
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
    url = paste0(tok$url, "/api/v1/im.counters")
  )

  stop_for_status(res)
  content(res)
}
