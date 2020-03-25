#' Group List All
#'
#' Lists all of the private groups of any users. The calling user requires to have ‘view-room-administration’ right. It supports the Offset, Count, and Sort Query Parameters along with just the Fields Query Parameters.
#'
#' @param token The token to connect to the app.
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
group_list_all <- function(tok) {
  res <- httr::GET(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/groups.listAll")
  )

  stop_for_status(res)
  content(res)
}
