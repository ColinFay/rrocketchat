# Function maker
library(rvest)
library(magrittr)
library(purrr)

tag_app <- function(var) {
  sprintf("#' %s", var)
}


ap_em_rox <- function(val){
  val %<>% c(
    "#' "
  )
  val
}

fun_make <- function(
  url
){
  page <- read_html(url)

  fun_args <- page %>%
    html_table() %>%
    purrr::pluck(2)

  title <- page %>%
    html_nodes("h1") %>%
    pluck(2) %>%
    html_text()

  fun_code <- title %>%
    tag_app() %>%
    ap_em_rox()

  has_desc <- page %>%
    html_nodes("p")

  if (length(has_desc) > 0){
    fun_code %<>% c(
      has_desc %>%
        pluck(1)%>%
        html_text() %>%
        gsub("\n", ". ", .) %>%
        tag_app() %>%
        ap_em_rox()
    )
  }


  fun_code %<>% c("#' @param token The token to connect to the app.")

  fun_code %<>% c(
    purrr::pmap_chr(
      fun_args,
      ~ {
        sprintf(
          "#' @param %s %s %s",
          thinkr::clean_vec(..1), ..4, ..3
        )
      }
    )
  ) %<>% ap_em_rox()
  fun_code %<>% c(
    tag_app("@export")
  )

  fun_code %<>% c(
    tag_app("@importFrom httr POST GET add_headers content stop_for_status"),
    tag_app("@importFrom jsonlite toJSON")

  )

  fun_code %<>% c(
    sprintf(
      "%s <- function(tok,",
      thinkr::clean_vec(title)
    )
  )

  fun_code %<>% c(
    purrr::pmap_chr(
      fun_args,
      ~ {
        if (
          grepl("Optional", ..3)
        ){
          sprintf(
            "  %s = NULL,",
            thinkr::clean_vec(..1)
          )
        } else {
          sprintf(
            "  %s,",
            thinkr::clean_vec(..1)
          )
        }

      }
    )
  )

  fun_code[
    length(fun_code)
    ] %<>% gsub(",", "", .)

  fun_code %<>% c(
    "){",
    " ",
    "  params <- list("
  )

  fun_code %<>% c(
    purrr::pmap_chr(
      fun_args,
      ~ {
        sprintf(
          "    %s = %s,",
          thinkr::clean_vec(..1), thinkr::clean_vec(..1)
        )
      }
    )
  )

  fun_code[
    length(fun_code)
    ] %<>% gsub(",", "", .)

  fun_code %<>% c(
    ")",
    "",
    "params <- no_null(params)",
    "",
    "params <- toJSON(params, auto_unbox = TRUE)"
  )

  method <- page %>%
    html_table() %>%
    pluck(1)
  if ( method["HTTP Method" ] == "POST"){
    fun_code %<>% c(
      sprintf(
        "res <- httr::%s(",
        method["HTTP Method"]
      ),
      "add_headers('Content-type' = 'application/json',",
      "'X-Auth-Token' = tok$data$authToken,",
      "'X-User-Id' = tok$data$userId",
      "),",
      sprintf("url = paste0(tok$url, '%s'),", method["URL"] ),
      "body = params"
    )
  } else {
    fun_code %<>% c(
      sprintf(
        "res <- httr::%s(",
        method["HTTP Method" ]
      ),
      "add_headers('Content-type' = 'application/json',",
      "'X-Auth-Token' = tok$data$authToken,",
      "'X-User-Id' = tok$data$userId",
      "),",
      sprintf("url = paste0(tok$url, '%s')", method["URL"] )
    )
  }

  fun_code %<>% c(
    ")",
    " ",
    "stop_for_status(res)",
    "content(res)",
    "}"
  )

  fun_code <- styler::style_text(fun_code)

  usethis::use_r(thinkr::clean_vec(title))
  write(fun_code, sprintf("R/%s.R", thinkr::clean_vec(title)))
}

# User Methods

user_methods <- read_html("https://rocket.chat/docs/developer-guides/rest-api/users/")
user_methods %>%
  html_nodes("a") %>%
  html_attr("href") %>%
  grep("rest-api/users/.*/", ., value = TRUE) %>%
  purrr::map(~{
    print(.x)
    purrr::safely(fun_make)(.x)
  })

fun_make("https://rocket.chat/docs/developer-guides/rest-api/users/forgotpassword/")
