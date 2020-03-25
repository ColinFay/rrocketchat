#' Channel Set Join Code
#'
#' Sets the code required to join the channel.
#'
#' @param token The token to connect to the app.
#' @param roomid The channel’s id Required
#' @param joincode The join code which this channel will require to be joined. Required
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
channels_channel_set_join_code <- function(tok,
                                           roomid,
                                           joincode) {
  params <- list(
    roomid = roomid,
    joincode = joincode
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::POST(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/channels.setJoinCode"),
    body = params
  )

  stop_for_status(res)
  content(res)
}
