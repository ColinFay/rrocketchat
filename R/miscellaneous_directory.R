#' Directory
#'
#' A method, that searches by users or channels on all users and channels available on server.. It supports the Offset, Count, and Sort Query Parameters. along with Query and Fields Query Parameters.
#'
#' @param token The token to connect to the app.
#' @param query When type is users you can send an additional workspace field, that can be local (default) or all. workspace=all will work only if Federation is enabled. Required
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
miscellaneous_directory <- function(tok,
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
    url = paste0(tok$url, "/api/v1/directory")
  )

  stop_for_status(res)
  content(res)
}
