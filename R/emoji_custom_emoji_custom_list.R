#' Emoji custom list
#'
#' List all custom emojis available. It supports the Query Parameters only.
#'
#' @param token The token to connect to the app.
#' @param updatedsince Date as ISO string Optional
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
emoji_custom_emoji_custom_list <- function(tok,
                                           updatedsince = NULL) {
  params <- list(
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
    url = paste0(tok$url, "/api/v1/emoji-custom.list")
  )

  stop_for_status(res)
  content(res)
}
