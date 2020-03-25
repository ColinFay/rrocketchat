#' Channel Rename
#'
#' Changes the name of the channel.
#'
#' @param token The token to connect to the app.
#' @param roomid The channel’s id Required
#' @param name The new name the channel will have, it cannot be the same as another or the existing name Required
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
channels_channel_rename <- function(tok,
                                    roomid,
                                    name) {
  params <- list(
    roomid = roomid,
    name = name
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::POST(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/channels.rename"),
    body = params
  )

  stop_for_status(res)
  content(res)
}
