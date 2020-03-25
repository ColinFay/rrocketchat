#' Auto Translate Get Supported Languages
#'
#' Get the supported languages by the autotranslate.
#'
#' @param token The token to connect to the app.
#' @param targetlanguage Language in which language names will be returned. No
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
autotranslate_auto_translate_get_supported_languages <- function(tok,
                                                                 targetlanguage) {
  params <- list(
    targetlanguage = targetlanguage
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::GET(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/autotranslate.getSupportedLanguages")
  )

  stop_for_status(res)
  content(res)
}
