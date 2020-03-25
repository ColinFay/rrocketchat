#' Retrieves an OAuth App
#'
#' Retrieves an OAuth App by id or client id
#'
#' @param token The token to connect to the app.
#' @param appid The app’s id. Required (if the clientId is not sent)
#' @param clientid The client’s id. Required (if the appId is not sent)
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
oauthapps_retrieves_an_oauth_app <- function(tok,
                                             appid,
                                             clientid) {
  params <- list(
    appid = appid,
    clientid = clientid
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::GET(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/oauth-apps.get")
  )

  stop_for_status(res)
  content(res)
}
