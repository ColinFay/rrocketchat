#' Channel Moderators List
#'
#' Lists all channel moderators.
#'
#' @param token The token to connect to the app.
#' @param roomid The channel’s id Required (if no roomName)
#' @param roomname The channel’s name Required (if no roomId)
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
channels_channel_moderators_list <- function(tok,
                                             roomid,
                                             roomname) {
  params <- list(
    roomid = roomid,
    roomname = roomname
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::GET(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/channels.moderators")
  )

  stop_for_status(res)
  content(res)
}
