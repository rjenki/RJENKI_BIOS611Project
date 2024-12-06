# Makefile

.PHONY: clean visualize generate_report

clean:
	rm -rf figures/*
	rm -rf data/*
	rm -f report.pdf

.created-dirs:
	mkdir -p figures
	mkdir -p data
	touch .created-dirs

data/oasis_longitudinal.csv: .created-dirs packages_and_data.R
	Rscript packages_and_data.R

# demographics_figures.R
figures/age_stats.rds: .created-dirs data/oasis_longitudinal.csv demographics_figures.R
	Rscript demographics_figures.R

figures/educ_stats.rds: .created-dirs data/oasis_longitudinal.csv demographics_figures.R
	Rscript demographics_figures.R

figures/cdr_plot.rds: .created-dirs data/oasis_longitudinal.csv demographics_figures.R
	Rscript demographics_figures.R

figures/sex_plot.rds: .created-dirs data/oasis_longitudinal.csv demographics_figures.R
	Rscript demographics_figures.R

figures/hand_plot.rds: .created-dirs data/oasis_longitudinal.csv demographics_figures.R
	Rscript demographics_figures.R

figures/group_plot.rds: .created-dirs data/oasis_longitudinal.csv demographics_figures.R
	Rscript demographics_figures.R

figures/ses_plot.rds: .created-dirs data/oasis_longitudinal.csv demographics_figures.R
	Rscript demographics_figures.R

# Figures generation target for raw data (raw_data_figures.R)
figures/mmse_stats.rds: .created-dirs data/oasis_longitudinal.csv raw_data_figures.R
	Rscript raw_data_figures.R

figures/mr_stats.rds: .created-dirs data/oasis_longitudinal.csv raw_data_figures.R
	Rscript raw_data_figures.R

figures/nWBV_stats.rds: .created-dirs data/oasis_longitudinal.csv raw_data_figures.R
	Rscript raw_data_figures.R

figures/eTIV_stats.rds: .created-dirs data/oasis_longitudinal.csv raw_data_figures.R
	Rscript raw_data_figures.R

figures/ASF_stats.rds: .created-dirs data/oasis_longitudinal.csv raw_data_figures.R
	Rscript raw_data_figures.R

# analysis_figures.R
figures/age_group_box.rds: .created-dirs data/oasis_longitudinal.csv analysis_figures.R
	Rscript analysis_figures.R

figures/age_group_anova.rds: .created-dirs data/oasis_longitudinal.csv analysis_figures.R
	Rscript analysis_figures.R

figures/educ_ses_reg.rds: .created-dirs data/oasis_longitudinal.csv analysis_figures.R
	Rscript analysis_figures.R

figures/age_cdr_box.rds: .created-dirs data/oasis_longitudinal.csv analysis_figures.R
	Rscript analysis_figures.R

figures/age_cdr_anova.rds: .created-dirs data/oasis_longitudinal.csv analysis_figures.R
	Rscript analysis_figures.R

figures/age_cdr_stats.rds: .created-dirs data/oasis_longitudinal.csv analysis_figures.R
	Rscript analysis_figures.R

figures/mmse_group_box.rds: .created-dirs data/oasis_longitudinal.csv analysis_figures.R
	Rscript analysis_figures.R

figures/mmse_group_anova.rds: .created-dirs data/oasis_longitudinal.csv analysis_figures.R
	Rscript analysis_figures.R

figures/nWBV_age_group_reg.rds: .created-dirs data/oasis_longitudinal.csv analysis_figures.R
	Rscript analysis_figures.R

figures/nWBV_age_group_regression_results.rds: .created-dirs data/oasis_longitudinal.csv analysis_figures.R
	Rscript analysis_figures.R

# Visualization server target (Optional)
visualize: \
	figures/age_stats.rds \
	figures/educ_stats.rds \
	figures/cdr_plot.rds \
	figures/sex_plot.rds \
	figures/hand_plot.rds \
	figures/group_plot.rds \
	figures/ses_plot.rds \
	figures/mmse_stats.rds \
	figures/mr_stats.rds \
	figures/nWBV_stats.rds \
	figures/eTIV_stats.rds \
	figures/ASF_stats.rds \
	figures/age_group_box.rds \
	figures/age_group_anova.rds \
	figures/educ_ses_reg.rds \
	figures/age_cdr_box.rds \
	figures/age_cdr_anova.rds \
	figures/age_cdr_stats.rds \
	figures/mmse_group_box.rds \
	figures/mmse_group_anova.rds \
	figures/nWBV_age_group_reg.rds \
	figures/nWBV_age_group_regression_results.rds
	python3 -m http.server 8888

# Report
generate_report: \
	figures/age_stats.rds \
	figures/educ_stats.rds \
	figures/cdr_plot.rds \
	figures/sex_plot.rds \
	figures/hand_plot.rds \
	figures/group_plot.rds \
	figures/ses_plot.rds \
	figures/mmse_stats.rds \
	figures/mr_stats.rds \
	figures/nWBV_stats.rds \
	figures/eTIV_stats.rds \
	figures/ASF_stats.rds \
	figures/age_group_box.rds \
	figures/age_group_anova.rds \
	figures/educ_ses_reg.rds \
	figures/age_cdr_box.rds \
	figures/age_cdr_anova.rds \
	figures/age_cdr_stats.rds \
	figures/mmse_group_box.rds \
	figures/mmse_group_anova.rds \
	figures/nWBV_age_group_reg.rds \
	figures/nWBV_age_group_regression_results.rds
	Rscript -e "rmarkdown::render('report-script.Rmd', output_format='pdf_document')"

# Default target
all: generate_report