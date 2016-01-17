tests <- "ABabóćąęłń81241ĄĆĘŁŃÓŚŹŻ!#$%&'()*+,-./:;<=>?@[]^_`{|}~"
#patterns <- "[Ęźż]"
patterns <- c("[[:digit:]]", "[A-Z]", "[[:lower:]]", 
              "[[:upper:]]", "[[:punct:]]","[[:alpha:]]")
correct_results <- c("81241", "AB", "abóćąęłń", 
           "ABĄĆĘŁŃÓŚŹŻ", "!#%&'()*,-./:;?@[]_{}",
           "ABabóćąęłńĄĆĘŁŃÓŚŹŻ"
           )

getcontentsofTRE <- function(s,g) {
  substring(s, g[1], g[1]+sum(attr(g, 'match.length')) -1)
}
getcontents <- function(s,g) {
  substring(s, g[1], g[1]+attr(g, 'match.length')-1)
} 

test_PCRE <- function(patterns, correct_res) {
  PCRE <- gregexpr((patterns), (tests), perl=TRUE)
  core_contents <- getcontentsofTRE((tests[1]), PCRE[[1]])
  #  print(correct_res)
  if(core_contents != correct_res) {
    res <- paste0("PCRE doesn't support, correct_res should be  ", correct_res, " got ", core_contents)
    print(res)
  }
}

test_PCRE_normalized <- function(patterns, correct_res) {
  PCRE <- gregexpr(enc2utf8(patterns), enc2utf8(tests), perl=TRUE)
  core_contents <- getcontentsofTRE(enc2utf8(tests[1]), PCRE[[1]])
#  print(correct_res)
  if(core_contents != correct_res) {
    res <- paste0("PCRE normalized doesn't support, correct_res should be  ", correct_res, " got ", core_contents)
    print(res)
  }
}

test_TCRE <- function(patterns, correct_res) {
  TRE <- gregexpr((patterns), (tests), perl=FALSE)
  core_contents <- getcontentsofTRE((tests[1]), TRE[[1]])
  #  print(correct_res)
  if(core_contents != correct_res) {
    res <- paste0("TRE doesn't support, correct_res should be  ", correct_res, " got ", core_contents)
    print(res)
  }
}

test_TCRE_normalized <- function(patterns, correct_res) {
  TRE <- gregexpr(enc2utf8(patterns), enc2utf8(tests), perl=FALSE)
  core_contents <- getcontentsofTRE(enc2utf8(tests[1]), TRE[[1]])
#  print(correct_res)
  if(core_contents != correct_res) {
    res <- paste0("TRE normalized doesn't support, correct_res should be  ", correct_res, " got ", core_contents)
    print(res)
  }
}

test_ICU <- function(patterns, correct_res) {
  ICU <- stringi::stri_match_all(enc2utf8(tests), regex=enc2utf8(patterns))
  ICU  <- lapply(ICU, paste, collapse="")
  
  if(ICU != correct_res) {
    res <- paste0("ICU doesn't support, correct_res should be  ", correct_res, " got ", ICU)
    print(res)
  }
}
test_ICU_normalize <- function(patterns, correct_res) {
  ICU <- stringi::stri_match_all(enc2utf8(tests), regex=enc2utf8(patterns))
  ICU  <- lapply(ICU, paste, collapse="")
  
  if(ICU != correct_res) {
    res <- paste0("ICU normalized doesn't support, correct_res should be  ", correct_res, " got ", ICU)
    print(res)
  }
}

i<-1
for(pattern in patterns) {
  test_PCRE(pattern, correct_results[i])
  test_PCRE_normalized(pattern, correct_results[i])
  test_TCRE(pattern, correct_results[i])
  test_TCRE_normalized(pattern, correct_results[i])
  test_ICU(pattern , correct_results[i])
  test_ICU_normalize(pattern , correct_results[i])
  i <- i+1
}

i<-1
for(pattern in patterns) {
  test_PCRE_normalized(pattern, correct_results[i])
  test_TCRE_normalized(pattern, correct_results[i])
  test_ICU_normalize(pattern , correct_results[i])
  i <- i+1
}

