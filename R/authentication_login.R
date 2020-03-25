#' Login
#'
#' Login with your username and password.
#'
#' @param token The token to connect to the app.
#' @param user Your username or email Required
#' @param password Your password Required
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
authentication_login <- function(tok,
                                 user,
                                 password) {
  params <- list(
    user = user,
    password = password
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::POST(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/login"),
    body = params
  )

  stop_for_status(res)
  content(res)
}
