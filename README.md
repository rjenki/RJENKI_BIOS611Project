# BIOS 611 Project: OASIS Alzheimer's Detection Dataset
This project analyzies the OASIS Alzheimer's Detection Dataset, which is a data set consists of 373 scans, of patients aged 60 to 96, who received an MRI scan on two or more visits, each visit separated by at least a year. The cognitive status (demented/non demented) was documented throughout the study.

The report generated will give patient demographic data, visualization of the data collected in the study, and analysis of the connection between age and dementia status, socioeconomic status and education, age and clincal dementia rating, dementia status and mini mental state examination, and normalized total brain volume and age by dementia status. 

## About This Dataset
This data was obtained from the Open Access Series of Imaging Studies (OASIS), which is comprised by data made available from the Washington University Alzheimer’s Disease Research Center, Dr. Randy Buckner at the Howard Hughes Medical Institute (HHMI) at Harvard University, the Neuroinformatics Research Group (NRG) at Washington University School of Medicine, and the Biomedical Informatics Research Network (BIRN).
Link to data: https://www.kaggle.com/datasets/ninadaithal/imagesoasis 
### Columns
| Variable             | Description                                        |
|----------------------|----------------------------------------------------|
| Subject ID           | Subject identification                             |
| Age                  | Age (Years)                                        |
| MRI ID               | MRI Exam Identification                            |
| EDUC                 | Years of Education                                 |
| Group                | Nondemented/Demented                               |
| SES                  | Socioeconomic Status                               |
| Visit                | Visit #                                            |
| MMSE                 | Mini Mental State Examination                      |
| MR Delay             | MR Delay Time                                      |
| CDR                  | Clinical Dementia Rating                           |
| M/F                  | Sex                                                |
| eTIV                 | Estimated total intracranial volume                |
| Hand                 | Right or left handed                               |
| nWBV                 | Normalize Whole Brain Volume                       |
| ASF                  | Atlas Scaling Factor                               |


To use this repository, first clone the repository to your device. 
```bash
git clone https://github.com/rjenki/RJENKI_BIOS611Project
```

Add a .password file to your device with the following code:
```bash
nano .password
```
Once in the file, write down your password. Because this is public data and analysis, the password used was "workspace".

Next, use Docker to build and run the associated image.
```bash
docker build --build-arg linux_user_pwd=$(cat .password) -t rjenki .
```
Please note: This docker image uses rocker/rstudio instead of rocker/verse because the device used to run it is an M3 mac.

Finally, run the Docker image.
```bash
docker run -d -p 8787:8787 -v /Users/rebeccajenkins/BIOS611/RJENKI_BIOS611Project:/home/rstudio/RJENKI_BIOS611Project rjenki
```

Once navigated to http://localhost:8787/, specify the directory:
```bash
cd ~/RJENKI_BIOS611Project
```

Lastly, use the make command to generate the report:
```bash
make all
```
