#' Regenerate Personal Access Token
#'
#' Regenerate a user personal access token. Requires create-personal-access-tokens permission.
#'
#' @param token The token to connect to the app.
#' @param tokenname The name of the token. Required
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
users_regenerate_personal_access_token <- function(tok,
                                                   tokenname) {
  params <- list(
    tokenname = tokenname
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::POST(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/users.regeneratePersonalAccessToken"),
    body = params
  )

  stop_for_status(res)
  content(res)
}
