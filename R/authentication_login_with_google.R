#' Login with Google
#'
#' Authenticate with Google.
#'
#' @param token The token to connect to the app.
#' @param servicename The desired OAuth service name Required
#' @param accesstoken Access token provided by google oauth Required
#' @param idtoken Id token provided by google auth Required
#' @param expiresin Lifetime of token(in seconds) Required
#' @param scope Google scopes for API Optional
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
authentication_login_with_google <- function(tok,
                                             servicename,
                                             accesstoken,
                                             idtoken,
                                             expiresin,
                                             scope = NULL) {
  params <- list(
    servicename = servicename,
    accesstoken = accesstoken,
    idtoken = idtoken,
    expiresin = expiresin,
    scope = scope
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
