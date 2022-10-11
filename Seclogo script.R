###logo script
#If you use ggseqlogo please cite:
#Wagih, Omar. ggseqlogo: a versatile R package for drawing sequence logos. Bioinformatics (2017). https://doi.org/10.1093/bioinformatics/btx469
#see extra information on: https://omarwagih.github.io/ggseqlogo/#getting_started

###packages
library(ggplot2)
library(ggseqlogo)
library(readxl)

###import excel file containing a sequence list and combine the genera specific data
TTV_data <- read_excel("TTV.xlsx")
list1 <- list("TTV"=TTV_data$TTV)

TTMV_data <- read_excel("TTMV.xlsx")
list2 <- list("TTMV"=TTMV_data$TTMV)

TTMDV_data <- read_excel("TTMDV.xlsx")
list3 <- list("TTMDV"=TTMDV_data$TTMDV)

list4 <- c(list1, list2, list3) 
View(list4)

###plot multiple sequence logos from the list
ggseqlogo(data=list4, method='prob', ncol=1, nrow=4, seq_type="dna")  + #combining figures
  scale_x_discrete(limits=c('-5' , '', '', '', '', '0', '', '', '', '', '5')) + #adjust the x-axis
  ggtitle("") + #change title 
  theme(plot.title = element_text(size = 14, hjust = 0.5, face="bold"), #change sizes
        axis.text = element_text(size = 10), axis.title.y = element_text(size=14), panel.spacing.y = unit(20, "pt")) #change sizes

ggsave("nt_context.svg", width=5, height=8)
ggsave("nt_context.tiff", width=5, height=8)










