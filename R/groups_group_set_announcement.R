#' Group Set Announcement
#'
#' Sets the announcement for the group.
#'
#' @param token The token to connect to the app.
#' @param roomid The group’s id Required
#' @param announcement The announcement to set for the group. Required
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
groups_group_set_announcement <- function(tok,
                                          roomid,
                                          announcement) {
  params <- list(
    roomid = roomid,
    announcement = announcement
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::POST(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/groups.setAnnouncement"),
    body = params
  )

  stop_for_status(res)
  content(res)
}
