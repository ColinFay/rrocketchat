#' Get Integrations
#'
#' Retrieves the integrations which the channel has, requires at least one integration permission: manage-incoming-integrations, manage-own-incoming-integrations, manage-outgoing-integrations or manage-own-outgoing-integrations. It will return the integrations based on the user permission. It supports the Offset, Count, and Sort Query Parameters along with Query and Fields Query Parameters.
#'
#' @param token The token to connect to the app.
#' @param roomid The channel’s id Required
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
channels_get_integrations <- function(tok,
                                      roomid) {
  params <- list(
    roomid = roomid
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::GET(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/channels.getIntegrations")
  )

  stop_for_status(res)
  content(res)
}
