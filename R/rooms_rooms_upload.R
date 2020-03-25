#' Rooms Upload
#'
#' Post a message with attached file to a dedicated room.
#'
#' @param token The token to connect to the app.
#' @param file A file name to upload Required
#' @param msg A message text Optional
#' @param description A description of the file Optional
#' @param tmid The thread message id (if you want upload a file to a thread) Optional
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
rooms_rooms_upload <- function(tok,
                               file,
                               msg = NULL,
                               description = NULL,
                               tmid = NULL) {
  params <- list(
    file = file,
    msg = msg,
    description = description,
    tmid = tmid
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::POST(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/rooms.upload/:rid"),
    body = params
  )

  stop_for_status(res)
  content(res)
}
