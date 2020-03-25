#' Role Create
#'
#' Create a new role in the system.
#'
#' @param token The token to connect to the app.
#' @param name The name of the new role. Required
#' @param scope The scope of the new role. Optional  Default: Users
#' @param description A description for the new role. Optional
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
roles_role_create <- function(tok,
                              name,
                              scope = NULL,
                              description = NULL) {
  params <- list(
    name = name,
    scope = scope,
    description = description
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::POST(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/roles.create"),
    body = params
  )

  stop_for_status(res)
  content(res)
}
