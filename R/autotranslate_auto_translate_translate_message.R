#' Auto Translate Translate Message
#'
#' Translate the provided message.
#'
#' @param token The token to connect to the app.
#' @param messageid The message’s id to be translated. Required
#' @param targetlanguage The target language that the message will be translated. Optional
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
autotranslate_auto_translate_translate_message <- function(tok,
                                                           messageid,
                                                           targetlanguage = NULL) {
  params <- list(
    messageid = messageid,
    targetlanguage = targetlanguage
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::POST(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/autotranslate.translateMessage"),
    body = params
  )

  stop_for_status(res)
  content(res)
}
