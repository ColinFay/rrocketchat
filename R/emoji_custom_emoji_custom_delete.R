#' Emoji Custom delete
#'
#' @param token The token to connect to the app.
#' @param emojiid The custom emoji id to be deleted. Required
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
emoji_custom_emoji_custom_delete <- function(tok,
                                             emojiid) {
  params <- list(
    emojiid = emojiid
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::POST(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/emoji-custom.delete"),
    body = params
  )

  stop_for_status(res)
  content(res)
}
