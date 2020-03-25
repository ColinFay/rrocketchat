#' Channel Create
#'
#' Creates a new public channel, optionally including specified users. The channel creator is always included.
#'
#' @param token The token to connect to the app.
#' @param name The name of the new channel Required
#' @param members The users to add to the channel when it is created. Optional  Default: []
#' @param readonly Set if the channel is read only or not. Optional  Default: false
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
channels_channel_create <- function(tok,
                                    name,
                                    members = NULL,
                                    readonly = NULL) {
  params <- list(
    name = name,
    members = members,
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
    url = paste0(tok$url, "/api/v1/channels.create"),
    body = params
  )

  stop_for_status(res)
  content(res)
}
