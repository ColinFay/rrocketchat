#' Register
#'
#' @param token The token to connect to the app.
#' @param username The username for the user. Required
#' @param email The email for the user. Required
#' @param pass The password for the user. Required
#' @param name The name of the user. Required
#' @param secreturl String appended to secret registration URL (if using). Optional
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
users_register <- function(tok,
                           username,
                           email,
                           pass,
                           name,
                           secreturl = NULL) {
  params <- list(
    username = username,
    email = email,
    pass = pass,
    name = name,
    secreturl = secreturl
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::POST(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/users.register"),
    body = params
  )

  stop_for_status(res)
  content(res)
}
