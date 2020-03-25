#' Inquiries List
#'
#' Lists all of the open livechat inquiries. It supports the Offset, Count, and Sort Query Parameters.
#'
#' @param token The token to connect to the app.
#' @param department The department’s id or name Optional
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
livechat_inquiries_list <- function(tok,
                                    department = NULL) {
  params <- list(
    department = department
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::GET(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/livechat/inquiries.list")
  )

  stop_for_status(res)
  content(res)
}
