#' Update Jitsi Timeout
#'
#' @param token The token to connect to the app.
#' @param roomid The room Id of the room to update the jitsi timeout. Required
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
video_conference_update_jitsi_timeout <- function(tok,
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
    url = paste0(tok$url, "/api/v1/video-conference/jitsi.update-timeout"),
    body = params
  )

  stop_for_status(res)
  content(res)
}
