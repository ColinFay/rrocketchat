#' IM Messages Others
#'
#' Retrieves the messages from any direct message in the server. It supports the Offset, Count, and Sort Query Parameters along with Query and Fields Query Parameter.
#'
#' @param token The token to connect to the app.
#' @param roomid The direct message id Required
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
im_im_messages_others <- function(tok,
                                  roomid) {
  params <- list(
    roomid = roomid
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::GET(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/im.messages.others")
  )

  stop_for_status(res)
  content(res)
}
