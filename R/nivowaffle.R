#' 绘制华夫图
#'
#' @import htmlwidgets
#'
#' @export
nivowaffle <- function(
  data = NULL,
  total = 100,
  rows = 18,
  columns = 14,
  colorBy = "id",
  ...,
  width = NULL,
  height = NULL,
  elementId = NULL) {

  data <- mapply(
    function(id, label, value, color){
      list(
        id = id,
        label = label,
        value = value,
        color = color
      )
    },
    data$id,
    data$label,
    data$value,
    data$color,
    SIMPLIFY = FALSE
  )

  component <- reactR::reactMarkup(htmltools::tag(
    "ResponsiveWaffle",
    list(
      data = data,
      total = total,
      rows = rows,
      columns = columns,
      colorBy = colorBy,
      ...
    )
  )
)

  # create widget
  htmlwidgets::createWidget(
    name = 'nivowaffle',
    component,
    width = width,
    height = height,
    package = 'nivowaffle',
    elementId = elementId
  )
}

#' Shiny bindings for nivowaffle
#'
#' Output and render functions for using nivowaffle within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a nivowaffle
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name nivowaffle-shiny
#'
#' @export
nivowaffleOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'nivowaffle', width, height, package = 'nivowaffle')
}

#' @rdname nivowaffle-shiny
#' @export
renderNivowaffle <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, nivowaffleOutput, env, quoted = TRUE)
}

#' Called by HTMLWidgets to produce the widget's root element.
#' @rdname nivowaffle-shiny
nivowaffle_html <- function(id, style, class, ...) {
  htmltools::tagList(
    # Necessary for RStudio viewer version < 1.2
    reactR::html_dependency_corejs(),
    reactR::html_dependency_react(),
    reactR::html_dependency_reacttools(),
    htmltools::tags$div(id = id, class = class, style = style)
  )
}
