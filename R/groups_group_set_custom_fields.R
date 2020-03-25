#' Group Set Custom Fields
#'
#' Sets the custom fields for the private group.
#'
#' @param token The token to connect to the app.
#' @param roomid The private group’s id Required
#' @param roomname The private group’s name Required
#' @param customfields The custom fields to set for the private group. Required
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
groups_group_set_custom_fields <- function(tok,
                                           roomid,
                                           roomname,
                                           customfields) {
  params <- list(
    roomid = roomid,
    roomname = roomname,
    customfields = customfields
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::POST(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/groups.setCustomFields"),
    body = params
  )

  stop_for_status(res)
  content(res)
}
