

#' Rename columns.
#'
#' \code{data.table} based implementation.
#'
#' @inheritParams ex_data_table
#'
#' @examples
#'
#' dL <- build_frame(
#'     "x", "y" |
#'     2L , "b" |
#'     1L , "a" |
#'     3L , "c" )
#' rquery_pipeline <- local_td(dL) %.>%
#'   rename_columns(., c("x" = "y", "y" = "x"))
#' ex_data_table(rquery_pipeline)[]
#'
#' @export
ex_data_table.relop_rename_columns <- function(optree,
                                               ...,
                                               tables = list(),
                                               source_usage = NULL,
                                               source_limit = NULL,
                                               env = parent.frame()) {
  wrapr::stop_if_dot_args(substitute(list(...)), "rquery::ex_data_table.relop_rename_columns")
  if(is.null(source_usage)) {
    source_usage <- columns_used(optree)
  }
  x <- ex_data_table(optree$source[[1]],
                     tables = tables,
                     source_usage = source_usage,
                     source_limit = source_limit,
                     env = env)
  data.table::setnames(x, old = as.character(optree$cmap), new = names(optree$cmap))
  x
}


