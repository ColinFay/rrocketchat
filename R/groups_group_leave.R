#' Group Leave
#'
#' Causes the callee to be removed from the private group, if they’re part of it and are not the last owner.
#'
#' @param token The token to connect to the app.
#' @param roomid The private group’s id Required
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
groups_group_leave <- function(tok,
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
    url = paste0(tok$url, "/api/v1/groups.leave"),
    body = params
  )

  stop_for_status(res)
  content(res)
}
