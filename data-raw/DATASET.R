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
  url,
  prefix
){

  prefix <- thinkr::clean_vec(prefix)
  page <- read_html(url)

  fun_args <- page %>%
    html_table() %>%
    purrr::pluck(2)

  if (! "Argument" %in% names(fun_args)){
    fun_args <- c("")
  }

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

  if (fun_args[1] != ""){
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
  }

  fun_code %<>% c(
    tag_app("@export")
  )

  fun_code %<>% c(
    tag_app("@importFrom httr POST GET add_headers content stop_for_status"),
    tag_app("@importFrom jsonlite toJSON")

  )

  if (fun_args[1] != ""){
    fun_code %<>% c(
      sprintf(
        "%s_%s <- function(tok,",
        prefix,
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
      "){"
    )

    fun_code %<>% c(
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
  } else {
    fun_code %<>% c(
      sprintf(
        "%s <- function(tok){",
        thinkr::clean_vec(title)
      )
    )
  }

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

  #pth <- fs::path("R", , ext = "R")
  pth <- thinkr::clean_vec(
    sprintf(
      "%s_%s",
      prefix,
      title
    )
  )

  usethis::use_r(pth, FALSE)
  write(fun_code, fs::path("R", pth, ext = "R"))
  usethis::use_test(pth, FALSE)

  cli::cat_rule(
    sprintf("Created at R/%s", pth)
  )

}

make_all <- function(prefix){
  url <- sprintf(
    "https://rocket.chat/docs/developer-guides/rest-api/%s/",
    prefix
  )
  cli::cat_rule(
    sprintf(
      "Trying %s",
      url
    )
  )
  httr::stop_for_status(
    httr::GET(
      url
    )
  )
  user_methods <- read_html(
    url
  )
  vals <- user_methods %>%
    html_nodes("a") %>%
    html_attr("href") %>%
    grep(
      sprintf(
        "rest-api/%s/.*/",
        prefix
      ), ., value = TRUE)
  vals %>%
    purrr::map(~{
      print(.x)
      purrr::safely(fun_make)(.x, prefix)
    }) %>%
    setNames(vals)
  cli::cat_bullet(
    "Done",
    bullet = "tick"
  )
}

h3 <- read_html(
  "https://rocket.chat/docs/developer-guides/rest-api/"
) %>%
  html_nodes('h3') %>%
  html_text() %>% .[1:25] %>%
  tolower() %>%
  gsub(" ", "-", .) %>%
  gsub("miscellaneous-information", "miscellaneous", .)

for (i in h3){
  purrr::safely(
    make_all
  )(i)
}

devtools::document()
