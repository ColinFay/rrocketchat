#' Integrations Settings
#'
#' Retrieves a list of integration settings.
#'
#' @param token The token to connect to the app.
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
integrations_settings <- function(tok) {
  res <- httr::GET(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/livechat/integrations.settings")
  )

  stop_for_status(res)
  content(res)
}
