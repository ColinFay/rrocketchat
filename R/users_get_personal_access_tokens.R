#' Get Personal Access Tokens
#'
#' Gets the user’s personal access tokens. Requires create-personal-access-tokens permission.
#'
#' @param token The token to connect to the app.
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
get_personal_access_tokens <- function(tok) {
  res <- httr::GET(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/users.getPersonalAccessTokens")
  )

  stop_for_status(res)
  content(res)
}
