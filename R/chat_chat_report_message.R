#' Chat Report Message
#'
#' Reports a message.
#'
#' @param token The token to connect to the app.
#' @param messageid The message id to report. Required
#' @param description The description of report. Required
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
chat_chat_report_message <- function(tok,
                                     messageid,
                                     description) {
  params <- list(
    messageid = messageid,
    description = description
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::POST(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/chat.reportMessage"),
    body = params
  )

  stop_for_status(res)
  content(res)
}
