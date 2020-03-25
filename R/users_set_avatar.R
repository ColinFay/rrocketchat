#' Set Avatar
#'
#' @param token The token to connect to the app.
#' @param image The image file to use as the new avatar, as form data. Required
#' @param userid_or_username The id or username of the user. If not provided, the auth user is updated. Optional
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
users_set_avatar <- function(tok,
                             image,
                             userid_or_username = NULL) {
  params <- list(
    image = image,
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
    url = paste0(tok$url, "/api/v1/users.setAvatar"),
    body = params
  )

  stop_for_status(res)
  content(res)
}
