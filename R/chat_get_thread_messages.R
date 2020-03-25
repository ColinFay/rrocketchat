#' Get thread messages
#'
#' Get thread messages. It supports the Offset, Count, and Sort Query Parameters along with Query and Fields Query Parameters.
#'
#' @param token The token to connect to the app.
#' @param tmid The id of the the thread message. Required
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
chat_get_thread_messages <- function(tok,
                                     tmid) {
  params <- list(
    tmid = tmid
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::GET(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/chat.getThreadMessages")
  )

  stop_for_status(res)
  content(res)
}
