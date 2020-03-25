#' Channel Online
#'
#' Lists all online users of a channel if the channel’s id is provided, otherwise it gets all online users of all channels. It supports the Query Parameters only.
#'
#' @param token The token to connect to the app.
#' @param query See Query Parameter Optional
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
channels_channel_online <- function(tok,
                                    query = NULL) {
  params <- list(
    query = query
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::GET(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/channels.online")
  )

  stop_for_status(res)
  content(res)
}
