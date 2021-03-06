#' Group Delete
#'
#' Remove a private channel.
#'
#' @param token The token to connect to the app.
#' @param roomid The channel’s id Required (if no roomName)
#' @param roomname The channel’s name Required (if no roomId)
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
groups_group_delete <- function(tok,
                                roomid,
                                roomname) {
  params <- list(
    roomid = roomid,
    roomname = roomname
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::POST(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/groups.delete"),
    body = params
  )

  stop_for_status(res)
  content(res)
}
