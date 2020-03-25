#' Group Set Purpose
#'
#' Sets the description for the private group (the same as groups.setDescription, obsolete).
#'
#' @param token The token to connect to the app.
#' @param roomid The private group’s id Required
#' @param purpose The description to set for the private group. Required
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
groups_group_set_purpose <- function(tok,
                                     roomid,
                                     purpose) {
  params <- list(
    roomid = roomid,
    purpose = purpose
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::POST(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/groups.setPurpose"),
    body = params
  )

  stop_for_status(res)
  content(res)
}
