#' Group Rename
#'
#' Changes the name of the private group.
#'
#' @param token The token to connect to the app.
#' @param roomid The private group’s id Required
#' @param name The new name the private group will have, it can not be the same as another or the existing name Required
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
groups_group_rename <- function(tok,
                                roomid,
                                name) {
  params <- list(
    roomid = roomid,
    name = name
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::POST(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/groups.rename"),
    body = params
  )

  stop_for_status(res)
  content(res)
}
