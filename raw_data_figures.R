# Loading packages
library(ggplot2)
library(gridExtra)
library(grid) 
library(dplyr)
library(tidyr)
library(kableExtra)
library(knitr)

# MMSE variable calculations and figure generation
# Remove rows with missing values
oasis_data_clean <- oasis_data %>% filter(!is.na(MMSE))
# Create Normal/Not Normal category
oasis_data_clean$MMSE_category <- ifelse(oasis_data_clean$MMSE >= 25, "Normal", "Not Normal")
# Calculate MMSE summary statistics 
mean_mmse <- mean(oasis_data_clean$MMSE, na.rm = TRUE)
median_mmse <- median(oasis_data_clean$MMSE, na.rm = TRUE)
min_mmse <- min(oasis_data_clean$MMSE, na.rm = TRUE)
q1_mmse <- quantile(oasis_data_clean$MMSE, 0.25, na.rm = TRUE)
q3_mmse <- quantile(oasis_data_clean$MMSE, 0.75, na.rm = TRUE)
max_mmse <- max(oasis_data_clean$MMSE, na.rm = TRUE)
# Create data frame
mmse_stats <- data.frame(
  Statistic = c("Mean", "Median", "Min", "Q1", "Q3", "Max"),
  Value = c(mean_mmse, median_mmse, min_mmse, q1_mmse, q3_mmse, max_mmse)
)
# Histogram for MMSE 
p <- ggplot(oasis_data_clean, aes(x = MMSE, fill = MMSE_category)) +
  geom_histogram(binwidth = 2, color = "black", alpha = 0.7, position = "identity") +
  scale_fill_manual(values = c("Normal" = "paleturquoise", "Not Normal" = "lightseagreen")) + 
  labs(
    title = "Mini Mental State Examination Distribution with Summary Statistics",
    subtitle = "MMSE values classified as normal (≥ 25) and not normal (< 25)",  
    x = "MMSE",
    y = "Frequency",
    fill = "MMSE Category"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold"),
    plot.subtitle = element_text(hjust = 0.5, face = "italic", size = 10),
    legend.position = "right",
    plot.margin = margin(t = 10, r = 10, b = 100, l = 10) 
  )
# Create table
table_grob <- tableGrob(mmse_stats, rows = NULL, theme = ttheme_minimal())
# Combine histogram and table
mmse_stats <- p + annotation_custom(grob = table_grob, 
                                    xmin = 88, xmax = Inf, ymin = 0, ymax = 55) +
  annotation_custom(
    grob = textGrob("Two data points removed due to missing MMSE value.", 
                    x = 0.5, y = -0.1, gp = gpar(fontsize = 9, fontface = "italic")),
    xmin = -Inf, xmax = Inf, ymin = -Inf, ymax = -Inf
  ) +
  coord_cartesian(clip = "off") +  # Prevent clipping of annotation
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold"),
    plot.subtitle = element_text(hjust = 0.5, face = "italic", size = 10),
    legend.position = "right",
    plot.margin = margin(t = 10, r = 10, b = 10, l = 10)  # Keep margins small, but ensure plot area is large enough
  )
# Save RDS
saveRDS(mmse_stats, file="/Users/rebeccajenkins/BIOS611/RJENKI_BIOS611Project/figures/mmse_stats.rds");


# MR Delay variable calculations and figure generation
# Calculations of education summary statistics
mean_mr <- mean(oasis_data$MR.Delay, na.rm = TRUE)
median_mr <- median(oasis_data$MR.Delay, na.rm = TRUE)
min_mr <- min(oasis_data$MR.Delay, na.rm = TRUE)
q1_mr <- quantile(oasis_data$MR.Delay, 0.25, na.rm = TRUE)
q3_mr <- quantile(oasis_data$MR.Delay, 0.75, na.rm = TRUE)
max_mr <- max(oasis_data$MR.Delay, na.rm = TRUE)
# Data frame to hold the results
mr_stats <- data.frame(
  Statistic = c("Mean", "Median", "Min", "Q1", "Q3", "Max"),
  Value = c(mean_mr, median_mr, min_mr, q1_mr, q3_mr, max_mr)
)
# Histogram for age
p <- ggplot(oasis_data, aes(x = MR.Delay)) +
  geom_histogram(binwidth = 100, fill = "lightgreen", color = "black", alpha = 0.7) +
  labs(title = "MR Delay Time (Contrast) Distribution with Summary Statistics",
       x = "Time (Days)", y = "Frequency") +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold") 
  )
# Table of summary statistics
table_grob <- tableGrob(mr_stats, rows = NULL, theme = ttheme_minimal())
# Combining the histogram and table
mr_stats <- p + annotation_custom(grob = table_grob, 
                                  xmin = 1250, xmax = Inf, ymin = 0, ymax = 190)
# Save RDS
saveRDS(mr_stats, file="/Users/rebeccajenkins/BIOS611/RJENKI_BIOS611Project/figures/mr_stats.rds");


# eTIV Delay variable calculations and figure generation
# Calculations of education summary statistics
mean_eTIV <- mean(oasis_data$eTIV, na.rm = TRUE)
median_eTIV <- median(oasis_data$eTIV, na.rm = TRUE)
min_eTIV <- min(oasis_data$eTIV, na.rm = TRUE)
q1_eTIV <- quantile(oasis_data$eTIV, 0.25, na.rm = TRUE)
q3_eTIV <- quantile(oasis_data$eTIV, 0.75, na.rm = TRUE)
max_eTIV <- max(oasis_data$eTIV, na.rm = TRUE)
# Data frame to hold the results
eTIV_stats <- data.frame(
  Statistic = c("Mean", "Median", "Min", "Q1", "Q3", "Max"),
  Value = c(mean_eTIV, median_eTIV, min_eTIV, q1_eTIV, q3_eTIV, max_eTIV)
)
# Histogram for age
p <- ggplot(oasis_data, aes(x = eTIV)) +
  geom_histogram(binwidth = 100, fill = "gray82", color = "black", alpha = 0.7) +
  labs(title = "Estimated Total Intracranial Volume Distribution with Summary Statistics",
       x = expression("eTIV ("* "cm"^3 * ")"), y = "Frequency") +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold") 
  )
# Table of summary statistics
table_grob <- tableGrob(eTIV_stats, rows = NULL, theme = ttheme_minimal())
# Combining the histogram and table
eTIV_stats <- p + annotation_custom(grob = table_grob, 
                                    xmin = 1700, xmax = Inf, ymin = 0, ymax = 130)
# Save RDS
saveRDS(eTIV_stats, file="/Users/rebeccajenkins/BIOS611/RJENKI_BIOS611Project/figures/eTIV_stats.rds");


# nWBV Delay variable calculations and figure generation
# Calculations of education summary statistics
mean_nWBV <- mean(oasis_data$nWBV, na.rm = TRUE)
median_nWBV <- median(oasis_data$nWBV, na.rm = TRUE)
min_nWBV <- min(oasis_data$nWBV, na.rm = TRUE)
q1_nWBV <- quantile(oasis_data$nWBV, 0.25, na.rm = TRUE)
q3_nWBV <- quantile(oasis_data$nWBV, 0.75, na.rm = TRUE)
max_nWBV <- max(oasis_data$nWBV, na.rm = TRUE)
# Data frame to hold the results
nWBV_stats <- data.frame(
  Statistic = c("Mean", "Median", "Min", "Q1", "Q3", "Max"),
  Value = c(mean_nWBV, median_nWBV, min_nWBV, q1_nWBV, q3_nWBV, max_nWBV)
)
# Histogram for age
p <- ggplot(oasis_data, aes(x = nWBV)) +
  geom_histogram(binwidth = 0.02, fill = "greenyellow", color = "black", alpha = 0.7) +
  labs(title = "Normalize Whole Brain Volume Distribution with Summary Statistics",
       x = "Percent of Voxels Labeled as Gray/White Matter", y = "Frequency") +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold") 
  )
# Table of summary statistics
table_grob <- tableGrob(nWBV_stats, rows = NULL, theme = ttheme_minimal())
# Combining the histogram and table
nWBV_stats <- p + annotation_custom(grob = table_grob, 
                                    xmin = Inf, xmax = 0.75, ymin = Inf, ymax = 35)
# Save RDS
saveRDS(nWBV_stats, file="/Users/rebeccajenkins/BIOS611/RJENKI_BIOS611Project/figures/nWBV_stats.rds");


# ASF Delay variable calculations and figure generation
# Calculations of ASF summary statistics
mean_ASF <- mean(oasis_data$ASF, na.rm = TRUE)
median_ASF <- median(oasis_data$ASF, na.rm = TRUE)
min_ASF <- min(oasis_data$ASF, na.rm = TRUE)
q1_ASF <- quantile(oasis_data$ASF, 0.25, na.rm = TRUE)
q3_ASF <- quantile(oasis_data$ASF, 0.75, na.rm = TRUE)
max_ASF <- max(oasis_data$ASF, na.rm = TRUE)
# Data frame to hold the results
ASF_stats <- data.frame(
  Statistic = c("Mean", "Median", "Min", "Q1", "Q3", "Max"),
  Value = c(mean_ASF, median_ASF, min_ASF, q1_ASF, q3_ASF, max_ASF)
)
# Histogram for age
p <- ggplot(oasis_data, aes(x = ASF)) +
  geom_histogram(binwidth = 0.1, fill = "steelblue1", color = "black", alpha = 0.7) +
  labs(title = "Atlas Scaling Factor Distribution with Summary Statistics",
       x = "Atlas Scaling Factor (Unitless)", y = "Frequency") +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold") 
  )
# Table of summary statistics
table_grob <- tableGrob(ASF_stats, rows = NULL, theme = ttheme_minimal())
# Combining the histogram and table
ASF_stats <- p + annotation_custom(grob = table_grob, 
                                   xmin = Inf, xmax = 1.35, ymin = Inf, ymax = 35)
# Save RDS
saveRDS(ASF_stats, file="/Users/rebeccajenkins/BIOS611/RJENKI_BIOS611Project/figures/ASF_stats.rds");

# Raw data figures
readRDS("/Users/rebeccajenkins/BIOS611/RJENKI_BIOS611Project/figures/mmse_stats.rds");
readRDS("/Users/rebeccajenkins/BIOS611/RJENKI_BIOS611Project/figures/mr_stats.rds");
readRDS("/Users/rebeccajenkins/BIOS611/RJENKI_BIOS611Project/figures/nWBV_stats.rds");
readRDS("/Users/rebeccajenkins/BIOS611/RJENKI_BIOS611Project/figures/eTIV_stats.rds");
readRDS("/Users/rebeccajenkins/BIOS611/RJENKI_BIOS611Project/figures/ASF_stats.rds");