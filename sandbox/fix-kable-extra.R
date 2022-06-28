# https://stackoverflow.com/a/71771178/120898
print.kableExtra <- function(x, ...) {
  view_html <- getOption("kableExtra_view_html", TRUE)
  if (view_html & interactive()) {
    dep <- list(
      rmarkdown::html_dependency_jquery(), 
      rmarkdown::html_dependency_bootstrap(theme = "cosmo"), 
      kableExtra::html_dependency_kePrint(), 
      kableExtra::html_dependency_lightable()
    )
    
    x <- sub('style="', 'style="color: black; ', as.character(x), fixed = TRUE)
    
    html_kable <- htmltools::browsable(
      htmltools::HTML(
        as.character(x), 
        "<script type=\"text/x-mathjax-config\">MathJax.Hub.Config({tex2jax: {inlineMath: [[\"$\",\"$\"]]}})</script><script async src=\"https://mathjax.rstudio.com/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML\"></script>"
      )
    )
    htmltools::htmlDependencies(html_kable) <- dep
    class(html_kable) <- "shiny.tag.list"
    print(html_kable)
  }
  else {
    cat(as.character(x))
  }
}
