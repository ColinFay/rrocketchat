#' Spotlight
#'
#' Searches for users or rooms that are visible to the user.
#'
#' @param token The token to connect to the app.
#' @param query The term to be searched. Supports ‘#’ for channels and ‘@’ for users Required
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
miscellaneous_spotlight <- function(tok,
                                    query) {
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
    url = paste0(tok$url, "/api/v1/spotlight")
  )

  stop_for_status(res)
  content(res)
}
