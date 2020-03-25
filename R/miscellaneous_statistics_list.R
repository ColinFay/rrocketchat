#' Statistics List
#'
#' Selectable statistics about the Rocket.Chat server. It supports the Offset, Count and Sort Query Parameters along with just the Fields and Query Parameters.. Requires view-statistics permission.
#'
#' @param token The token to connect to the app.
#' @param query See Query Parameter Required
#' @param offset See Offset Parameter Optional
#' @param count See Count Parameter Optional
#' @param fields See Fields Parameters Optional
#' @param sort See Sort Query Parameters Optional
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
miscellaneous_statistics_list <- function(tok,
                                          query,
                                          offset = NULL,
                                          count = NULL,
                                          fields = NULL,
                                          sort = NULL) {
  params <- list(
    query = query,
    offset = offset,
    count = count,
    fields = fields,
    sort = sort
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::GET(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/statistics.list")
  )

  stop_for_status(res)
  content(res)
}
