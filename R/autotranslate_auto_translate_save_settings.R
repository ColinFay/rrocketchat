#' Auto Translate Save Settings
#'
#' Save some settings about autotranslate.
#'
#' @param token The token to connect to the app.
#' @param roomid The room’s id to apply setting. Required
#' @param field The setting to apply to user’s subscription. Required
#' @param value Boolean if the setting is autoTranslate and a string (the language) if the setting is autoTranslateLanguage. Required
#' @param defaultlanguage The default language. Optional
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
autotranslate_auto_translate_save_settings <- function(tok,
                                                       roomid,
                                                       field,
                                                       value,
                                                       defaultlanguage = NULL) {
  params <- list(
    roomid = roomid,
    field = field,
    value = value,
    defaultlanguage = defaultlanguage
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::POST(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/autotranslate.saveSetttings"),
    body = params
  )

  stop_for_status(res)
  content(res)
}
