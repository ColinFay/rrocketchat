#' Group Counters
#'
#' Gets group counters.
#'
#' @param token The token to connect to the app.
#' @param roomid The group’s id Required
#' @param roomname The group’s name Required
#' @param userid Counters for provided user id (need to have a view-room-administration right for calling user) Optional
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
groups_group_counters <- function(tok,
                                  roomid,
                                  roomname,
                                  userid = NULL) {
  params <- list(
    roomid = roomid,
    roomname = roomname,
    userid = userid
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::GET(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/groups.counters")
  )

  stop_for_status(res)
  content(res)
}
