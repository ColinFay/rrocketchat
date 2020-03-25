#' Save a SMS message on Rocket.Chat
#'
#' @param token The token to connect to the app.
#' @param service Only the server twilio is accepted at moment. Required
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
livechat_save_a_sms_message_on_rocket_chat <- function(tok,
                                                       service) {
  params <- list(
    service = service
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::POST(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/livechat/sms-incoming/:service"),
    body = params
  )

  stop_for_status(res)
  content(res)
}
