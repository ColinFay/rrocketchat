#' Reset Avatar
#'
#' @param token The token to connect to the app.
#' @param userid_or_username The id or username of the user. Required
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
reset_avatar <- function(tok,
                         userid_or_username) {
  params <- list(
    userid_or_username = userid_or_username
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::POST(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/users.resetAvatar"),
    body = params
  )

  stop_for_status(res)
  content(res)
}
