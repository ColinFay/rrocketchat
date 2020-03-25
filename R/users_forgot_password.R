#' Forgot Password
#'
#' Send email to reset your password.
#'
#' @param token The token to connect to the app.
#' @param email The email to send password reset link Required
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
users_forgot_password <- function(tok,
                                  email) {
  params <- list(
    email = email
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::POST(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/users.forgotPassword"),
    body = params
  )

  stop_for_status(res)
  content(res)
}
