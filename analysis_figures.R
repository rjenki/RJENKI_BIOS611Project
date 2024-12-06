# Age By Group 
# Box Plot
age_group_box <- ggplot(oasis_data, aes(x = Group, y = Age, fill = Group)) + 
  geom_boxplot() +
  labs(title = "Box Plot of Age by Group", 
       x = "Group", 
       y = "Age") +
  scale_fill_manual(values = c("paleturquoise2", "olivedrab2", "gray80")) +
  theme_minimal() +
  theme(
    legend.position = "none",  
    plot.title = element_text(hjust = 0.5, face = "bold", size = 16)  
  )
# ANOVA and Tukey's HSD
anova_result <- aov(Age ~ Group, data = oasis_data)
summary(anova_result)
tukey_result <- TukeyHSD(anova_result)
age_group_tukey_table <- as.data.frame(tukey_result$Group)
# Save RDS
saveRDS(age_group_box, file="/home/rstudio/RJENKI_BIOS611Project/figures/age_group_box.rds");
saveRDS(age_group_tukey_table, file="/home/rstudio/RJENKI_BIOS611Project/figures/age_group_anova.rds");


# Education By SES
# Linear Regression
# Removing missing data
oasis_data_clean <- oasis_data[!is.na(oasis_data$SES) & !is.na(oasis_data$EDUC), ]
oasis_data_clean$SES <- as.numeric(as.character(oasis_data_clean$SES))
# Model
model <- lm(EDUC ~ SES, data = oasis_data_clean)
summary(model)
intercept <- coef(model)[1]
slope <- coef(model)[2]
f_value <- summary(model)$fstatistic[1]
df1 <- summary(model)$fstatistic[2]
df2 <- summary(model)$fstatistic[3]
p_value <- pf(f_value, df1, df2, lower.tail = FALSE)
# Plot labels
eq_label <- paste("y = ", round(intercept, 2), " + ", round(slope, 2), " * x")
stat_label <- paste("F = ", round(f_value, 2), ", p = ", format.pval(p_value, digits = 4))
# Plot
educ_ses_reg <- ggplot(oasis_data_clean, aes(x = SES, y = EDUC, color = factor(SES))) +
  geom_point() + 
  geom_smooth(method = "lm", se = FALSE, aes(group = 1), color = "black") + 
  labs(title = "Linear Regression of Years of Education vs. Socioeconomic Status",
       x = "Hollingshead Index of Social Position",
       y = "Years of Education",
       color = "SES") +
  scale_x_discrete(labels = c("1" = "1 (Highest Status)", "5" = "5 (Lowest Status)")) +
  theme_minimal() +
  scale_color_brewer(palette = "Set1") +
  theme(legend.position = "none", plot.title = element_text(hjust = 0.5, face = "bold", size = 14)) +  
  annotate("text", x = max(oasis_data_clean$SES) - 1, y = max(oasis_data_clean$EDUC) - 3, 
           label = eq_label, size = 4, color = "black", hjust = 0, vjust = 0) +
  annotate("text", x = max(oasis_data_clean$SES) - 1, y = max(oasis_data_clean$EDUC) - 5, 
           label = stat_label, size = 4, color = "black", hjust = 0, vjust = 0)
# Save RDS
saveRDS(educ_ses_reg, file="/home/rstudio/RJENKI_BIOS611Project/figures/educ_ses_reg.rds");


# Age by CDR
# Mean and Count Table
age_cdr_stats <- oasis_data %>%
  group_by(CDR) %>%
  summarise(
    mean_age = mean(Age, na.rm = TRUE),  
    count = n()                       
  )
# Box Plot
oasis_data$CDR <- as.factor(oasis_data$CDR)
age_cdr_box <- ggplot(oasis_data, aes(x = CDR, y = Age, fill = CDR)) + 
  geom_boxplot() +
  labs(title = "Box Plot of Age by Clinical Dementia Rating", 
       x = "Clinical Dementia Rating", 
       y = "Age") +
  scale_fill_manual(values = c("olivedrab1", "olivedrab2", "olivedrab3", "olivedrab4")) +
  theme_minimal() +
  theme(
    legend.position = "none",  
    plot.title = element_text(hjust = 0.5, face = "bold", size = 16)  
  )
# ANOVA and Tukey's HSD
anova_result <- aov(Age ~ CDR, data = oasis_data)
summary(anova_result)
tukey_result <- TukeyHSD(anova_result)
age_cdr_tukey_table <- as.data.frame(tukey_result$CDR)
# Save RDS
saveRDS(age_cdr_stats, file="/home/rstudio/RJENKI_BIOS611Project/figures/age_cdr_stats.rds");
saveRDS(age_cdr_box, file="/home/rstudio/RJENKI_BIOS611Project/figures/age_cdr_box.rds");
saveRDS(age_cdr_tukey_table, file="/home/rstudio/RJENKI_BIOS611Project/figures/age_cdr_anova.rds");


# MMSE By Group
# Data Cleaning
oasis_data_clean <- oasis_data %>%
  filter(!is.na(MMSE), !is.infinite(MMSE), !is.na(Group), !is.infinite(Group))
# Box Plot
mmse_group_box <- ggplot(oasis_data_clean, aes(x = Group, y = MMSE, fill = Group)) + 
  geom_boxplot() +
  labs(title = "Box Plot of Mini Mental State Examination (MMSE) By Group", 
       x = "Group", 
       y = "MMSE") +
  scale_fill_manual(values = c("paleturquoise2", "olivedrab2", "gray80")) +
  theme_minimal() +
  theme(
    legend.position = "none",  
    plot.title = element_text(hjust = 0.5, face = "bold", size = 16)  
  ) +
  geom_hline(yintercept = 25, linetype = "dashed", color = "red", linewidth = 1) +
  # Add shaded region above Y = 25
  geom_rect(aes(xmin = -Inf, xmax = Inf, ymin = 25, ymax = Inf), 
            fill = "lightblue", alpha = 0.01) +
  # Add label for 'Normal Range'
  annotate("text", x = 1.5, y = 30, label = "Normal Range", size = 4, 
           color = "black", fontface = "italic", hjust = -3.25, vjust = 5)
# ANOVA and Tukey's HSD
mmse_anova_result <- aov(MMSE ~ Group, data = oasis_data_clean)
summary(mmse_anova_result)
mmse_tukey_result <- TukeyHSD(mmse_anova_result)
mmse_tukey_result
mmse_group_tukey_table <- as.data.frame(mmse_tukey_result$Group)
# Save RDS
saveRDS(mmse_group_box, file="/home/rstudio/RJENKI_BIOS611Project/figures/mmse_group_box.rds");
saveRDS(mmse_group_tukey_table, file="/home/rstudio/RJENKI_BIOS611Project/figures/mmse_group_anova.rds");


# nWBV and Age By Dementia Group
# Combined plot
intercept_non_demented <- format(coef(model_non_demented)[1], scientific = FALSE, digits = 3)
slope_non_demented <- format(coef(model_non_demented)[2], scientific = TRUE, digits = 3)

intercept_demented <- format(coef(model_demented)[1], scientific = FALSE, digits = 3)
slope_demented <- format(coef(model_demented)[2], scientific = TRUE, digits = 3)

intercept_converted <- format(coef(model_converted)[1], scientific = FALSE, digits = 3)
slope_converted <- format(coef(model_converted)[2], scientific = TRUE, digits = 3)

oasis_data_clean2 <- oasis_data %>%
  filter(!is.na(nWBV), !is.infinite(nWBV), !is.na(Group), !is.infinite(Group), !is.na(Age), !is.infinite(Age))

nWBV_age_group_reg <- ggplot(oasis_data_clean2, aes(x = Age, y = nWBV, color = Group)) +
  geom_point(size = 2, alpha = 0.6) +  
  geom_smooth(method = "lm", se = FALSE, aes(color = Group), linetype = "solid") + 
  
  annotate("text", x = 89.17, y = 0.85, label = paste("Converted: y =", intercept_converted, 
                                                      "+", slope_converted, "* x"), size = 4, color = "black") +
  annotate("text", x = 89.5, y = 0.83, label = paste("Demented: y =", intercept_demented, 
                                                     "+", slope_demented, "* x"), size = 4, color = "black") +
  annotate("text", x = 90, y = 0.81, label = paste("Nondemented: y =", intercept_non_demented, 
                                                   "+", slope_non_demented, "* x"), size = 4, color = "black") +
  labs(title = "Linear Regression for Normalized Whole Brain Volume (nWBV) by Age and Group",
       x = "Age",
       y = "nWBV",
       color = "Group") + 
  scale_color_manual(values = c("Nondemented" = "firebrick", "Demented" = "dodgerblue3", "Converted" = "green4")) + 
  theme_minimal() +  
  theme(legend.position = "top",  
        plot.title = element_text(hjust = 0.5, face = "bold", size = 12)) +
  xlim(60, 98) +  
  ylim(0.62, 0.85) 
# Results table
slope_non_demented <- coef(model_non_demented)[2]
intercept_non_demented <- coef(model_non_demented)[1]
f_stat_non_demented <- summary(model_non_demented)$fstatistic[1]
p_value_non_demented <- summary(model_non_demented)$coefficients[2, 4]
slope_demented <- coef(model_demented)[2]
intercept_demented <- coef(model_demented)[1]
f_stat_demented <- summary(model_demented)$fstatistic[1]
p_value_demented <- summary(model_demented)$coefficients[2, 4]
slope_converted <- coef(model_converted)[2]
intercept_converted <- coef(model_converted)[1]
f_stat_converted <- summary(model_converted)$fstatistic[1]
p_value_converted <- summary(model_converted)$coefficients[2, 4]
regression_results <- data.frame(
  Group = c("Non-demented", "Demented", "Converted"),
  Intercept = c(intercept_non_demented, intercept_demented, intercept_converted),
  Slope = c(slope_non_demented, slope_demented, slope_converted),
  F_Statistic = c(f_stat_non_demented, f_stat_demented, f_stat_converted),
  P_Value = c(p_value_non_demented, p_value_demented, p_value_converted)
)
# Save RDS
saveRDS(nWBV_age_group_reg, file="/home/rstudio/RJENKI_BIOS611Project/figures/nWBV_age_group_reg.rds");
saveRDS(regression_results, file="/home/rstudio/RJENKI_BIOS611Project/figures/nWBV_age_group_regression_results.rds");

# Analysis figures
readRDS("/home/rstudio/RJENKI_BIOS611Project/figures/age_group_box.rds");
readRDS("/home/rstudio/RJENKI_BIOS611Project/figures/age_group_anova.rds");
readRDS("/home/rstudio/RJENKI_BIOS611Project/figures/educ_ses_reg.rds");
readRDS("/home/rstudio/RJENKI_BIOS611Project/figures/age_cdr_box.rds");
readRDS("/home/rstudio/RJENKI_BIOS611Project/figures/age_cdr_anova.rds");
readRDS("/home/rstudio/RJENKI_BIOS611Project/figures/age_cdr_stats.rds");
readRDS("/home/rstudio/RJENKI_BIOS611Project/figures/mmse_group_box.rds");
readRDS("/home/rstudio/RJENKI_BIOS611Project/figures/mmse_group_anova.rds");
readRDS("/home/rstudio/RJENKI_BIOS611Project/figures/nWBV_age_group_reg.rds");
readRDS("/home/rstudio/RJENKI_BIOS611Project/figures/nWBV_age_group_regression_results.rds");