#' Group History
#'
#' Retrieves the messages from a private group, only if you’re part of the group.
#'
#' @param token The token to connect to the app.
#' @param roomid The private groups’s id Required
#' @param latest The end of time range of messages to retrieve Optional  Default: now
#' @param oldest The start of the time range of messages to retrieve Optional  Default: n/a
#' @param inclusive Whether messages which land on latest and oldest should be included Optional  Default: false
#' @param offset The offset of the list messages to retrieve Optional  Default: 0
#' @param count The amount of messages to retrieve Optional  Default: 20
#' @param unreads Whether the amount of unreads should be included. Optional  Default: false
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
groups_group_history <- function(tok,
                                 roomid,
                                 latest = NULL,
                                 oldest = NULL,
                                 inclusive = NULL,
                                 offset = NULL,
                                 count = NULL,
                                 unreads = NULL) {
  params <- list(
    roomid = roomid,
    latest = latest,
    oldest = oldest,
    inclusive = inclusive,
    offset = offset,
    count = count,
    unreads = unreads
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::GET(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/groups.history")
  )

  stop_for_status(res)
  content(res)
}
