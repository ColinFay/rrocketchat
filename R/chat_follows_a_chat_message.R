#' Follows a Chat Message
#'
#' Follows a chat message to the message’s channel.
#'
#' @param token The token to connect to the app.
#' @param mid The message id to follow. Required
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
chat_follows_a_chat_message <- function(tok,
                                        mid) {
  params <- list(
    mid = mid
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::POST(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/chat.followMessage"),
    body = params
  )

  stop_for_status(res)
  content(res)
}
