#' Group Create
#'
#' Creates a new private group, optionally including specified users. The group creator is always included.
#'
#' @param token The token to connect to the app.
#' @param name The name of the new private group Required
#' @param members The users to add to the group when it is created. Optional  Default: []
#' @param readonly Set if the group is read only or not. Optional  Default: false
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
groups_group_create <- function(tok,
                                name,
                                members = NULL,
                                readonly = NULL) {
  params <- list(
    name = name,
    members = members,
    readonly = readonly
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::POST(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/groups.create"),
    body = params
  )

  stop_for_status(res)
  content(res)
}
