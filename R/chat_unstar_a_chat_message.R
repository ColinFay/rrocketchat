#' Unstar a Chat Message
#'
#' Unstars the chat message for the authenticated user.
#'
#' @param token The token to connect to the app.
#' @param messageid The message id to unpin. Required
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
chat_unstar_a_chat_message <- function(tok,
                                       messageid) {
  params <- list(
    messageid = messageid
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::POST(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/chat.unStarMessage"),
    body = params
  )

  stop_for_status(res)
  content(res)
}
