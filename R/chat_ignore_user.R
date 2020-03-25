#' Ignore user
#'
#' Ignores an user in a chat. If you pass ignore as false, the user will be unignored.
#'
#' @param token The token to connect to the app.
#' @param rid The room ID. Required
#' @param userid The User ID. Required
#' @param ignore If the user will be ignored or not, default is true. Optional
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
chat_ignore_user <- function(tok,
                             rid,
                             userid,
                             ignore = NULL) {
  params <- list(
    rid = rid,
    userid = userid,
    ignore = ignore
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::GET(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/chat.ignoreUser")
  )

  stop_for_status(res)
  content(res)
}
