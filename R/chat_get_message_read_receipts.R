#' Get Message Read Receipts
#'
#' Retrieve message read receipts.
#'
#' @param token The token to connect to the app.
#' @param messageid The message id Required
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
chat_get_message_read_receipts <- function(tok,
                                           messageid) {
  params <- list(
    messageid = messageid
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::GET(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/chat.getMessageReadReceipts")
  )

  stop_for_status(res)
  content(res)
}
