#' Synced thread’s messages
#'
#' List all custom emojis available. It supports the Query, Fields and sort.
#'
#' @param token The token to connect to the app.
#' @param tmid Thread’s message ID Required
#' @param updatedsince Date as ISO string Required
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
chat_synced_thread_s_messages <- function(tok,
                                          tmid,
                                          updatedsince) {
  params <- list(
    tmid = tmid,
    updatedsince = updatedsince
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::GET(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/chat.syncThreadMessages")
  )

  stop_for_status(res)
  content(res)
}
