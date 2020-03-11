#' Get a token
#'
#' @param url url
#' @param user username
#' @param password password
#'
#' @importFrom rstudioapi showPrompt askForPassword
#' @importFrom httr POST GET add_headers content stop_for_status

#' @export
get_token <- function(
  url,
  user = rstudioapi::showPrompt("User", "Your username"),
  password = rstudioapi::askForPassword()
){
  endpoint <- sprintf(
    "%s/api/v1/login",
    url
  )

  res <- httr::POST(
    httr::add_headers("Content-type" = "application/json"),
    url = endpoint,
    body = jsonlite::toJSON(
      list(user = user, password = password), auto_unbox = TRUE
    )
  )
  httr::stop_for_status(res)
  res <- httr::content(
    res
  )
  res$url <- url
  class(res) <- "rocket_chat_tok"
  res
}
