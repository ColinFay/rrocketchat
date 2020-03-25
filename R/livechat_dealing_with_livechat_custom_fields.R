#' Dealing with Livechat Custom Fields
#'
#' Get a list of Livechat custom fields. It supports the Offset, Count, and Sort Query Parameters.
#'
#' @param token The token to connect to the app.
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
dealing_with_livechat_custom_fields <- function(tok) {
  res <- httr::POST(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/livechat/custom.field"),
    body = params
  )

  stop_for_status(res)
  content(res)
}
