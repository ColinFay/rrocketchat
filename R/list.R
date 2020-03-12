#' List
#'
#' Gets all of the users in the system and their information, the result is only limited to what the callee has access to view.. It supports the Offset, Count, and Sort Query Parameters along with Query and Fields Query Parameter.
#'
#' @param token The token to connect to the app.
#' @param fields Field include hash (value of 1 to include, 0 to exclude). Optional
#' @param query Query filter hash. Optional
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
list <- function(tok,
                 fields = NULL,
                 query = NULL) {
  params <- list(
    fields = fields,
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
    url = paste0(tok$url, "/api/v1/users.list")
  )

  stop_for_status(res)
  content(res)
}
