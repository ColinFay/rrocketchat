#' Get a list of livechat rooms
#'
#' Retrieves a list of livechat rooms. It supports the Offset, Count, and Sort Query Parameters along with Fields Query Parameters.
#'
#' @param token The token to connect to the app.
#' @param agents A list of agents, can be a list of ids or usernames Optional
#' @param departmentid The department’s id Optional
#' @param open If it should filter by open/closed rooms Optional
#' @param createdat An object representing when the room was created(Can also be filtered only with start or end) Optional
#' @param closedat An object representing when the room was closed(Can also be filtered only with start or end) Optional
#' @param tags A list of tags Optional
#' @param customfields An object with custom fields to be filtered(previously created and populated at custom fields endpoints) Optional
#' @param roomname The room’s name Optional
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
livechat_get_a_list_of_livechat_rooms <- function(tok,
                                                  agents = NULL,
                                                  departmentid = NULL,
                                                  open = NULL,
                                                  createdat = NULL,
                                                  closedat = NULL,
                                                  tags = NULL,
                                                  customfields = NULL,
                                                  roomname = NULL) {
  params <- list(
    agents = agents,
    departmentid = departmentid,
    open = open,
    createdat = createdat,
    closedat = closedat,
    tags = tags,
    customfields = customfields,
    roomname = roomname
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::GET(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/livechat/rooms")
  )

  stop_for_status(res)
  content(res)
}
