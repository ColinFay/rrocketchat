#' Livechat office hours
#'
#' Get Livechat office hours
#'
#' @param token The token to connect to the app.
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
livechat_office_hours <- function(tok) {
  res <- httr::GET(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/livechat/office-hours")
  )

  stop_for_status(res)
  content(res)
}
