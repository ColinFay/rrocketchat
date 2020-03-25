#' Emoji Custom create
#'
#' Create new custom emoji.
#'
#' @param token The token to connect to the app.
#' @param emoji The image file to use as the new custom emoji, as form data. Required
#' @param name The name of the new custom emoji. Required
#' @param aliases The alias of the new custom emoji. Required
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
emoji_custom_emoji_custom_create <- function(tok,
                                             emoji,
                                             name,
                                             aliases) {
  params <- list(
    emoji = emoji,
    name = name,
    aliases = aliases
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::POST(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/emoji-custom.create"),
    body = params
  )

  stop_for_status(res)
  content(res)
}
