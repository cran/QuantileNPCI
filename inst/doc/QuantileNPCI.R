## ---- include = FALSE----------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, message=FALSE------------------------------------------------
library(QuantileNPCI)
library(dplyr)
library(kableExtra)

## ------------------------------------------------------------------------
##The consecutive annual flood discharge rates of the Feather River at Oroville, CA
data1 <- flood[flood$loc=="Feather", "discharge"]

##The consecutive annual discharge rates of  the Blackstone River at Woonsocket, RI
data2 <- flood[flood$loc=="Blackstone", "discharge"]

## ------------------------------------------------------------------------
quant <- .5
alpha <- .05
q1 <- quantCI(data1,quant,alpha, method = "exact")
q1
q2 <- quantCI(data2,quant,alpha, method = "exact")
q2

## ------------------------------------------------------------------------
df <- cbind(as.data.frame(table(flood$loc)), 
            rbind(unlist(q1),unlist(q2))) %>% 
  dplyr::rename(River=1, n=2, u1=3, u2=4, lower=5, middle=6, upper=7)

df %>% 
  dplyr::mutate(u1=round(u1,5), u2=round(u2,5)) %>% 
  dplyr::mutate(CI=paste("(", round(lower,2), ", ", round(upper,2), ")", sep = "")) %>% 
  dplyr::select(River:u2, CI) %>% 
  knitr::kable(align=rep('c', 5)) %>%
  kableExtra::kable_styling(bootstrap_options = c("striped", "hover"),full_width = F, position = "center",font_size = 10)

## ------------------------------------------------------------------------
quantCI(data1,quant,alpha, method = "approximate")
quantCI(data2,quant,alpha, method = "approximate")

