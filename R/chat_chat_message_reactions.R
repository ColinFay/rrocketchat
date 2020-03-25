#' Chat Message Reactions
#'
#' Toggles the authenticated user’s reaction to the provided message.
#'
#' @param token The token to connect to the app.
#' @param emoji The emoji to react with. Required
#' @param messageid The message id to react to. Required
#' @param shouldreact Parameter to specify if the reaction should be added or removed. Optional: true or false
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
chat_chat_message_reactions <- function(tok,
                                        emoji,
                                        messageid,
                                        shouldreact = NULL) {
  params <- list(
    emoji = emoji,
    messageid = messageid,
    shouldreact = shouldreact
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::POST(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/chat.react"),
    body = params
  )

  stop_for_status(res)
  content(res)
}
