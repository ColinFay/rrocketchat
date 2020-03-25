#' Statistics
#'
#' Statistics about the Rocket.Chat server. Requires view-statistics permission.
#'
#' @param token The token to connect to the app.
#' @param refresh Need to refresh statistics Optional
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
miscellaneous_statistics <- function(tok,
                                     refresh = NULL) {
  params <- list(
    refresh = refresh
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::GET(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/statistics")
  )

  stop_for_status(res)
  content(res)
}
