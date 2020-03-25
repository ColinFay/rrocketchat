#' Subscriptions Get one
#'
#' Get the subscription by room id.
#'
#' @param token The token to connect to the app.
#' @param roomid The channel’s id Required
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
subscriptions_subscriptions_get_one <- function(tok,
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
    url = paste0(tok$url, "/api/v1/subscriptions.getOne")
  )

  stop_for_status(res)
  content(res)
}
