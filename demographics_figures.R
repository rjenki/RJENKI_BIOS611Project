# Loading packages
library(ggplot2)
library(gridExtra)
library(grid) 
library(dplyr)
library(tidyr)
library(knitr)

# AGE Variable calculations and figure generation
# Calculations of age summary statistics
mean_age <- mean(oasis_data$Age, na.rm = TRUE)
median_age <- median(oasis_data$Age, na.rm = TRUE)
min_age <- min(oasis_data$Age, na.rm = TRUE)
q1_age <- quantile(oasis_data$Age, 0.25, na.rm = TRUE)
q3_age <- quantile(oasis_data$Age, 0.75, na.rm = TRUE)
max_age <- max(oasis_data$Age, na.rm = TRUE)
# Data frame to hold the results
age_stats <- data.frame(
  Statistic = c("Mean", "Median", "Min", "Q1", "Q3", "Max"),
  Value = c(mean_age, median_age, min_age, q1_age, q3_age, max_age)
)
# Histogram for age
p <- ggplot(oasis_data, aes(x = Age)) +
  geom_histogram(binwidth = 2, fill = "skyblue", color = "black", alpha = 0.7) +
  labs(title = "Age Distribution with Summary Statistics",
       x = "Age (Years)", y = "Frequency") +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold") 
  )
# Table of summary statistics
table_grob <- tableGrob(age_stats, rows = NULL, theme = ttheme_minimal())
# Combining the histogram and table
age_stats <- p + annotation_custom(grob = table_grob, 
                                   xmin = 88, xmax = Inf, ymin = 0, ymax = 55)
# Save RDS
saveRDS(age_stats, file="/home/rstudio/RJENKI_BIOS611Project/figures/age_stats.rds");


# EDUC Variable calculations and figure generation
# Calculations of education summary statistics
mean_educ <- mean(oasis_data$EDUC, na.rm = TRUE)
median_educ <- median(oasis_data$EDUC, na.rm = TRUE)
min_educ <- min(oasis_data$EDUC, na.rm = TRUE)
q1_educ <- quantile(oasis_data$EDUC, 0.25, na.rm = TRUE)
q3_educ <- quantile(oasis_data$EDUC, 0.75, na.rm = TRUE)
max_educ <- max(oasis_data$EDUC, na.rm = TRUE)
# Data frame to hold the results
educ_stats <- data.frame(
  Statistic = c("Mean", "Median", "Min", "Q1", "Q3", "Max"),
  Value = c(mean_educ, median_educ, min_educ, q1_educ, q3_educ, max_educ)
)
# Histogram for age
p <- ggplot(oasis_data, aes(x = EDUC)) +
  geom_histogram(binwidth = 2, fill = "lightgreen", color = "black", alpha = 0.7) +
  labs(title = "Years of Education Distribution with Summary Statistics",
       x = "Education (Years)", y = "Frequency") +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold") 
  )
# Table of summary statistics
table_grob <- tableGrob(educ_stats, rows = NULL, theme = ttheme_minimal())
# Combining the histogram and table
educ_stats <- p + annotation_custom(grob = table_grob, 
                                    xmin = 0, xmax = 15, ymin = 0, ymax = 190)
# Save RDS
saveRDS(educ_stats, file="/home/rstudio/RJENKI_BIOS611Project/figures/educ_stats.rds");


# CDR (Clinical Dementia Rating) bar chart
# Creating bar chart for CDR
cdr_plot <- ggplot(oasis_data, aes(x = CDR)) +
  geom_bar(fill = "lightgrey", color = "black", alpha = 0.7) +
  geom_text(stat = "count", aes(label = after_stat(count)), 
            vjust = -0.5, size = 3.5) +
  labs(title = "Clinical Dementia Rating (CDR)", 
       x = "Clinical Dementia Rating", 
       y = "Count") +
  theme_minimal() + 
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold"),  
    axis.text.x = element_text(angle = 0, hjust = 0.5),    
  )
# Save RDS
saveRDS(cdr_plot, file="/home/rstudio/RJENKI_BIOS611Project/figures/cdr_plot.rds");


# M.F bar chart
# Creating bar chart for CDR
sex_plot <- ggplot(oasis_data, aes(x = M.F)) +
  geom_bar(fill = "aquamarine2", color = "black", alpha = 0.7) + 
  geom_text(stat = "count", aes(label = after_stat(count)), 
            vjust = -0.5, size = 3.5) + 
  labs(title = "Sex of Participants", 
       x = "Sex", 
       y = "Count") +
  scale_x_discrete(labels = c("M" = "Male", "F" = "Female")) +
  theme_minimal() + 
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold"),  
    axis.text.x = element_text(angle = 0, hjust = 0.5),    
  )
# Save RDS
saveRDS(sex_plot, file="/home/rstudio/RJENKI_BIOS611Project/figures/sex_plot.rds");


# Hand bar chart
hand_count <- oasis_data %>%
  count(Hand) %>%
  mutate(Hand = factor(Hand, levels = c("R", "L"))) %>%
  complete(Hand, fill = list(n = 0))
# Adding L level because there are no left handed participants
hand_plot <- ggplot(hand_count, aes(x = Hand, y = n)) +
  geom_bar(stat = "identity", fill = "darkolivegreen2", color = "black", alpha = 0.7) + 
  geom_text(aes(label = n), vjust = -0.5, size = 3.5) + 
  labs(title = "Dominant Hand of Participants", 
       x = "Dominant Hand", 
       y = "Count") +
  scale_x_discrete(labels = c("R" = "Right", "L" = "Left")) + 
  theme_minimal() + 
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold"),  
    axis.text.x = element_text(angle = 0, hjust = 0.5)
  )
# Save RDS
saveRDS(hand_plot, file="/home/rstudio/RJENKI_BIOS611Project/figures/hand_plot.rds");


# Group (Nondemeneted/Demented) bar chart
# Creating bar chart for group
group_plot <- ggplot(oasis_data, aes(x = Group)) +
  geom_bar(fill = "azure3", color = "black", alpha = 0.7) +
  geom_text(stat = "count", aes(label = after_stat(count)), 
            vjust = -0.5, size = 3.5) +
  labs(title = "Dementia Status of Participants", 
       x = "Dementia Status", 
       y = "Count") +
  theme_minimal() + 
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold"),  
    axis.text.x = element_text(angle = 0, hjust = 0.5),    
  )
# Save RDS
saveRDS(group_plot, file="/home/rstudio/RJENKI_BIOS611Project/figures/group_plot.rds");


# SES bar chart
oasis_data$alpha_value <- ifelse(oasis_data$SES == "Missing", 0.5, 0.7)
fill_colors <- c("Missing" = "deepskyblue", 
                 "1" = "deepskyblue",    
                 "2" = "deepskyblue",
                 "3" = "deepskyblue",
                 "4" = "deepskyblue",
                 "5" = "deepskyblue")

ses_plot <- ggplot(oasis_data, aes(x = SES)) +
  geom_bar(aes(fill = SES, alpha = alpha_value), color = "black") +  
  geom_text(stat = "count", aes(label = after_stat(count)), 
            vjust = -0.5, size = 3.5) +
  labs(title = "Socioeconomic Status of Participants", 
       x = "Hollingshead Index of Social Position", 
       y = "Count") +
  scale_x_discrete(labels = c("1" = "1 (Highest Status)", "5" = "5 (Lowest Status)")) +
  scale_fill_manual(values = fill_colors) + 
  theme_minimal() + 
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold"),  
    axis.text.x = element_text(angle = 0, hjust = 0.5),  
    legend.position = "none"
  )
# Save RDS
saveRDS(ses_plot, file="/home/rstudio/RJENKI_BIOS611Project/figures/ses_plot.rds");


# Demographics figures
readRDS("/home/rstudio/RJENKI_BIOS611Project/figures/age_stats.rds");
readRDS("/home/rstudio/RJENKI_BIOS611Project/figures/educ_stats.rds");
readRDS("/home/rstudio/RJENKI_BIOS611Project/figures/cdr_plot.rds");
readRDS("/home/rstudio/RJENKI_BIOS611Project/figures/sex_plot.rds");
readRDS("/home/rstudio/RJENKI_BIOS611Project/figures/hand_plot.rds");
readRDS("/home/rstudio/RJENKI_BIOS611Project/figures/group_plot.rds");
readRDS("/home/rstudio/RJENKI_BIOS611Project/figures/ses_plot.rds");