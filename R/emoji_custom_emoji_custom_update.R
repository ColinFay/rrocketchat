#' Emoji Custom update
#'
#' Update an existent custom emoji.
#'
#' @param token The token to connect to the app.
#' @param emoji The image file to use as custom emoji, as form data. Optional
#' @param x_id The id of the custom emoji. Required
#' @param name The name of the custom emoji. Required
#' @param aliases The alias of the custom emoji. Optional
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
emoji_custom_emoji_custom_update <- function(tok,
                                             emoji = NULL,
                                             x_id,
                                             name,
                                             aliases = NULL) {
  params <- list(
    emoji = emoji,
    x_id = x_id,
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
    url = paste0(tok$url, "/api/v1/emoji-custom.update"),
    body = params
  )

  stop_for_status(res)
  content(res)
}
