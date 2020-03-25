#' Group Remove Leader
#'
#' Removes the role of Leader for a user in the current group.
#'
#' @param token The token to connect to the app.
#' @param roomid The groups’s id Required
#' @param userid The user’s id Required
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
groups_group_remove_leader <- function(tok,
                                       roomid,
                                       userid) {
  params <- list(
    roomid = roomid,
    userid = userid
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::POST(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/groups.removeLeader"),
    body = params
  )

  stop_for_status(res)
  content(res)
}
