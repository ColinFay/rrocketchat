#' Group Archive
#'
#' Archives a private group, only if you’re part of the group.
#'
#' @param token The token to connect to the app.
#' @param roomid The private groups’s id Required
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
groups_group_archive <- function(tok,
                                 roomid) {
  params <- list(
    roomid = roomid
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::POST(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/groups.archive"),
    body = params
  )

  stop_for_status(res)
  content(res)
}
