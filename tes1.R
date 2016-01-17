easytest.fun <- function() {
  library(RCurl)
  library(ggplot2)
  library(directlabels)
  library(namedCapture)
  
  myHttpheader <- c(
    
    "User-Agent"="Mozilla/5.0 (Windows; U; Windows NT 5.1; zh-CN; rv:1.9.1.6) ",
    
    "Accept"="text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
    
    "Accept-Language"="en-us",
    
    "Connection"="keep-alive",
    
    "Accept-Charset"="gb2312,utf-8;q=0.7,*;q=0.7"
    
  )
  
  # url = "http://qingkong.net/anime/animation/"
  url = "http://av.jejeso.com/animation.html"
  contents <- getURL(url,httpheader=myHttpheader)
  
  pattern_core_code <- 
    '<table cellspacing="1" cellpadding="1" width="100%" align="center" border="0">(.+)</tbody>'
  
  gregout <- gregexpr(pattern_core_code, contents)
  
  getcontent <- function(s,g) {
    substring(s, g[1], g[1]+attr(g, 'match.length')-1)
  }
  core_contents <- getcontent(contents[1], gregout[[1]])
  
  pattern_animation <- paste0(
    '<a href="',
    '(?<animation_url>[^"]+)',
    '" title="',
    '(?<animation_title>[^"]+)',
    '" target="_blank">'
  )
  simple_pattern <- '<a href="[^"]+" title="[^"]+" target="_blank">'
  animation_single_contents <- str_match_named(core_contents, pattern_animation)
  animation_single_contents
  
  animation_contents <- str_match_all_named(core_contents, pattern_animation)
  animation_contents
  
  max.N <- 6
  times.list <- list()
  for(N in 1:max.N) {
    cat(sprintf("subject/pattern size %4d / %4d\n", N, max.N))
    core_contents <- paste(rep(core_contents, N), collapse="")
    N.times <- microbenchmark::microbenchmark(
      #    STR_MAT = str_match_all_named(core_contents, pattern_animation),
      ICU=stringi::stri_match_all(core_contents, regex=simple_pattern),
      PCRE=gregexpr(pattern_animation, core_contents, perl=TRUE),
      TRE=gregexpr(simple_pattern, core_contents, perl=FALSE),
      times=7)
    times.list[[N]] <- data.frame(N, N.times)
  }
  times <- do.call(rbind, times.list)
  save(times, file="times.RData")
  
  linear.legend <- ggplot()+
    ggtitle("Timing regular expressions in R, linear scale")+
    scale_y_continuous("seconds")+
    scale_x_continuous("subject/pattern size",
                       limits=c(1, 8),
                       breaks=c(1, 2, 3, 4, 5, 6))+
    geom_point(aes(N, time/1e9, color=expr),
               shape=1,
               data=times)
  (linear.dl <- direct.label(linear.legend, "last.polygons"))
  png("new_figure-complexity-linear.png")
  print(linear.dl)
  dev.off()
  
  log.legend <- ggplot()+
    ggtitle("Timing regular expressions in R, log scale")+
    scale_y_log10("seconds")+
    scale_x_log10("subject/pattern size",
                  limits=c(1, 8),
                  breaks=c(1, 2, 3, 4, 5, 6))+
    geom_point(aes(N, time/1e9, color=expr),
               shape=1,
               data=times)
  (log.dl <- direct.label(log.legend, "last.polygons"))
  png("new_figure-complexity-log.png")
  print(log.dl)
  dev.off()
  
}

