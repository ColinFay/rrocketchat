#' Dealing with Livechat transcript
#'
#' Request a Livechat transcript
#'
#' @param token The token to connect to the app.
#' @param token The visitor token Required
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
livechat_dealing_with_livechat_transcript <- function(tok,
                                                      token) {
  params <- list(
    token = token
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::GET(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/livechat/video.call/:token")
  )

  stop_for_status(res)
  content(res)
}
