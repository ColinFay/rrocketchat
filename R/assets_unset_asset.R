#' Unset Asset
#'
#' Unset an asset by name. Requires manage-assets permission.
#'
#' @param token The token to connect to the app.
#' @param assetname Asset naeme to unset. Required
#' @param refreshallclients If needs refresh all clients to apply changes immediately. Optional
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
assets_unset_asset <- function(tok,
                               assetname,
                               refreshallclients = NULL) {
  params <- list(
    assetname = assetname,
    refreshallclients = refreshallclients
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::POST(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/assets.unsetAsset"),
    body = params
  )

  stop_for_status(res)
  content(res)
}
