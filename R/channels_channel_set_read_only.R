#' Channel Set Read Only
#'
#' Sets whether the channel is read only or not.
#'
#' @param token The token to connect to the app.
#' @param roomid The channel’s id Required
#' @param readonly Boolean of whether the room is read only or not. Required
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
channels_channel_set_read_only <- function(tok,
                                           roomid,
                                           readonly) {
  params <- list(
    roomid = roomid,
    readonly = readonly
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::POST(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/channels.setReadOnly"),
    body = params
  )

  stop_for_status(res)
  content(res)
}
