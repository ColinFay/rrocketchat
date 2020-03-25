#' Group Add All
#'
#' Adds all of the users of the Rocket.Chat server to the group.
#'
#' @param token The token to connect to the app.
#' @param roomid The channel’s id Required
#' @param activeusersonly Add active users only Optional  Default: false
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
groups_group_add_all <- function(tok,
                                 roomid,
                                 activeusersonly = NULL) {
  params <- list(
    roomid = roomid,
    activeusersonly = activeusersonly
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::POST(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/groups.addAll"),
    body = params
  )

  stop_for_status(res)
  content(res)
}
