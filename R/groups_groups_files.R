#' Groups Files
#'
#' Retrieves the files from a private group. It supports the Offset, Count, and Sort Query Parameters along with Query and Fields Query Parameters.
#'
#' @param token The token to connect to the app.
#' @param roomid_roomname The room id.  The room name. Required
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
groups_groups_files <- function(tok,
                                roomid_roomname) {
  params <- list(
    roomid_roomname = roomid_roomname
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::GET(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/groups.files")
  )

  stop_for_status(res)
  content(res)
}
