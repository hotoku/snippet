library(tidyverse)
library(stringr)


summarise_by <- function(dat, key, val){
    k <- as.character(substitute(key))
    v <- as.character(substitute(val))
    "dat __PIPE__
        group_by(%s) __PIPE__
        summarise(%s = sum(%s)) __PIPE__
        ungroup" %>%
        sprintf(k, v, v) %>%
        str_replace_all("__PIPE__", "%>%") %>%
        parse(text = .) %>%
        eval
}

tibble(x=1:10, y=rep(1:2,5)) %>%
    summarise_by(key = y, val = x)
