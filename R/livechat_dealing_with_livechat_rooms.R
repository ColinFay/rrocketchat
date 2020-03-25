#' Dealing with Livechat rooms
#'
#' Get the Livechat room data or open a new room.
#'
#' @param token The token to connect to the app.
#' @param token The visitor token. Required
#' @param rid The room _id. Optional
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
livechat_dealing_with_livechat_rooms <- function(tok,
                                                 token,
                                                 rid = NULL) {
  params <- list(
    token = token,
    rid = rid
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::GET(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/livechat/room")
  )

  stop_for_status(res)
  content(res)
}
