#' Login with Twitter
#'
#' Authenticate with Twitter.
#'
#' @param token The token to connect to the app.
#' @param servicename The desired OAuth service name Required
#' @param accesstoken Access token provided by twitter oauth Required
#' @param accesstokensecret Access token secret provided by twitter oauth Required
#' @param appsecret The secret provided by twitter for app Required
#' @param appid The id provided by twitter for app Required
#' @param expiresin Lifetime of token(in seconds) Required
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
authentication_login_with_twitter <- function(tok,
                                              servicename,
                                              accesstoken,
                                              accesstokensecret,
                                              appsecret,
                                              appid,
                                              expiresin) {
  params <- list(
    servicename = servicename,
    accesstoken = accesstoken,
    accesstokensecret = accesstokensecret,
    appsecret = appsecret,
    appid = appid,
    expiresin = expiresin
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
