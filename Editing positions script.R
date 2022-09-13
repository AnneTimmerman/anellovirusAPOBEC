###packages
library(dplyr)
library(data.table)
library(tidyverse)
library(lubridate)
library(readxl)
library(openxlsx)
library(scales) 

###import excel file containing the lofreq table with the variants
data <- read_excel("All_TP_S1.xlsx")
View(data)

###filter only C to T mutations if needed
dataCT <- data %>% 
  filter(REF == "C") %>% 
  filter(ALT == "T") 
write.xlsx(dataCT, "All_TP_S1_CT.xlsx")

### make a new column - change - which is a type of mutation
data_newcolumn <- dataCT %>% 
  filter(TYPE == "SNP") %>% 
  mutate(change = paste(REF_PLUSSTRAND, ALT_PLUSSTRAND)) ### putting together variables of two columns; first reference, than the alternate

TTMV41_only <- data_newcolumn %>% filter(CHROM == "TTMV41") ### here I select only one of the lineages

a <- TTMV41_only %>% 
  ggplot() +
  geom_point(aes(x = POS, y = as.factor(Timepoint),  
                 colour = change, alpha = AF), size = 3) + ### The "alpha" gives transparency to the points based on the frequency
  theme(axis.text.y = element_text(hjust = 0, size = 12), 
        axis.text.x = element_text(vjust = 0.5, angle = 90, size = 8),
        axis.title.x = element_text(size = 15), axis.title.y = element_text(size = 15),
        panel.background = element_rect(fill="transparent", colour = "grey50"),
        panel.grid.major = element_line(colour = "lightgray", linetype = "solid")) +
  labs(x = "Position (nt)", y = "Timepoint", title = "TTMV-AMS-S1-41", alpha = "Frequency", colour = "Change")
a

b <- a + theme(axis.text.x=element_text(angle = -360, hjust = 0)) + scale_x_continuous(expand = c(0,0), breaks = seq(0, 2800, 1000), limits = c(0, 2807))  + scale_color_manual(values="#62bb5d") #manually change color and x-axis
b

ggsave("TTMV-AMS-S1-41.svg", width=40, height=5)
ggsave("TTMV-AMS-S1-41.tiff", width=11, height=3)
