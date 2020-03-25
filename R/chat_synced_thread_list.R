#' Synced thread list
#'
#' List all custom emojis available. It supports the Query, Fields and sort.
#'
#' @param token The token to connect to the app.
#' @param rid Room’s ID Required
#' @param updatedsince Date as ISO string Required
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
chat_synced_thread_list <- function(tok,
                                    rid,
                                    updatedsince) {
  params <- list(
    rid = rid,
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
    url = paste0(tok$url, "/api/v1/chat.syncThreadsList")
  )

  stop_for_status(res)
  content(res)
}
