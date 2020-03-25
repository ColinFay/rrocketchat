#' Subscriptions Get
#'
#' Get all subscriptions. Please note that the unread counter value depends on your settings at the Administration => General section.
#'
#' @param token The token to connect to the app.
#' @param updatedsince Date as ISO string Optional
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
subscriptions_subscriptions_get <- function(tok,
                                            updatedsince = NULL) {
  params <- list(
    updatedsince = updatedsince
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::GET(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/subscriptions.get")
  )

  stop_for_status(res)
  content(res)
}
