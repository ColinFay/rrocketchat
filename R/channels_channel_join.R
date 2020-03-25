#' Channel Join
#'
#' Joins yourself to the channel.
#'
#' @param token The token to connect to the app.
#' @param roomid The channel’s id Required
#' @param joincode The join code of the room Required
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
channels_channel_join <- function(tok,
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
    url = paste0(tok$url, "/api/v1/channels.join"),
    body = params
  )

  stop_for_status(res)
  content(res)
}
