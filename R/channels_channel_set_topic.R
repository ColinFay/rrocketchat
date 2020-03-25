#' Channel Set Topic
#'
#' Sets the topic for the channel.
#'
#' @param token The token to connect to the app.
#' @param roomid The channel’s id Required
#' @param topic The channel’s topic to set. Required
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
channels_channel_set_topic <- function(tok,
                                       roomid,
                                       topic) {
  params <- list(
    roomid = roomid,
    topic = topic
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::POST(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/channels.setTopic"),
    body = params
  )

  stop_for_status(res)
  content(res)
}
