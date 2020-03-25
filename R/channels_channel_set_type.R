#' Channel Set Type
#'
#' Sets the type of room this channel should be.
#'
#' @param token The token to connect to the app.
#' @param roomid The channel’s id Required
#' @param type The type of room this channel should be, either c or p. Required
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
channels_channel_set_type <- function(tok,
                                      roomid,
                                      type) {
  params <- list(
    roomid = roomid,
    type = type
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::POST(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/channels.setType"),
    body = params
  )

  stop_for_status(res)
  content(res)
}
