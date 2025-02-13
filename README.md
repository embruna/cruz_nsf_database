# cruz nsf database

Database from Sen Ted Cruz [linked here](https://www.commerce.senate.gov/2025/2/cruz-led-investigation-uncovers-2-billion-in-woke-dei-grants-at-nsf-releases-full-database) purporting to find "billions spent on 'woke dei grants' at NSF"  

- [press release](https://www.commerce.senate.gov/2024/10/new-cruz-investigation-reveals-how-biden-harris-diverted-billions-from-scientific-research-to-dei-activists)  
- [report with methodology](https://www.commerce.senate.gov/services/files/4BD2D522-2092-4246-91A5-58EEF99750BC)


## Notes 

3484 awards, but only 3002 different projects (collaborative grants split the buudget to different institutions with different award numbers)

## Column Name Changes or Notes

### `status`, `social_justice`, `gender`, `race`, and `env_justice` columns 

"[funds] went to questionable projects that promoted diversity,
equity, and inclusion (DEI) tenets or pushed onto science neo-Marxist perspectives about
enduring class struggle. The Committee grouped these **grants into five categories: Status,
Social Justice, Gender, Race, and Environmental Justice**. For the purposes for this report,
“DEI funding,” a “DEI grant,” or “DEI research” refers to taxpayer dollars NSF provided to a
research or engagement program that fell into one of these five groups."


### `summary` column

This was called `award_descriptions` in the original `.xlsx` file.

### `recipient_type` column

- they incorrectly coded non-profits (e  g  , Ecological Society of America) as "for-profit organization (other than small business)" (recoded as "for_profit_nonbiz")   


### `award_type` column

- cooperative agreements: funding mechanism for project that
involves “substantial staff involvement” from a federal agency  

### `funding_office` column

Their 'funding office' was a long text string, soetimes incomplete. I converted to an acronym for the relevant NSF Division, Program, or Office as follows: 

 "div of biological infrastructure" ~ "DBI" # "Biological Infrastructure"   
 "division of environmental biology" ~ "DEB" # "Environmental Biology"  
 "emerging frontiers" ~ "EF" # "Emerging Frontiers"  
 "div of integrative organismal sys" ~ "IOS" # "Integrative Organismal Systems  
 "division of molecular and" ~ "MCB" # "Molecular and Cellular Biosciences"   
 "Computer and Information Science and Engineering" ~ "CISE"  
 "ofc of adv cyberinfrastructure" ~ "OAC" # "Advanced Cyberinfrastructure"  
 "div of computer  comm foundations"  ~ "CCF" # "Computing and Communication Foundations"  
 "div of computer  network systems" ~ "CNS" # "Computer and Network Systems"   
 "div of infor  intelligent systems" ~ "IIS" # "Information and Intelligent Systems"  
 "division of chemical bioengineering" ~ "CBET" # "Chemical, Bioengineering, Environmental and Transport Systems"  
 "div of civil, mechan  manuf innov" ~ "CMMI"  # "Civil, Mechanical and Manufacturing Innovation"  
 "division electrical, communication" ~ "ECCS"  # "Electrical, Communications and Cyber Systems"  
 "division of engineering education" ~ "EEC"  # "Engineering Education and Centers"  
 "office of emerging frontiers and" ~ "EFMA"  # "Emerging Frontiers and Multidisciplinary Activities"  
 "division of atmospheric and" ~ "AGS"  # "Atmospheric and Geospace Sciences"   
 "division of earth sciences"  ~ "EAR"  # "Earth Sciences"  
 "division of ocean sciences" ~ "OCE"  # "Ocean Sciences"  
 "office of polar programs" ~ "OPP" # "Polar Programs"  
 "office of integrative activities" ~ "OIA"  # "Integrative Activities"  
 "ofc interntl science  eng" ~ "OISE"  # "International Science and Engineering"  
 "division of astronomical sciences" ~ "AST"  # "Astronomical Sciences"  
 "division of chemistry" ~ "CHE"  # "Chemistry"  
 "division of materials research" ~ "DMR" # "Materials Research"  
 "division of mathematical sciences" ~ "DMS"  # "Mathematical Sciences"  
 "division of physics"  ~ "PHY"  # "Physics"  
 "div of social and economic science" ~ "SBE" # "Social, Behavioral and Economic Sciences"  
 "div of behavioral  cognitive sci" ~ "BCS"   
 "division of equity for excellence in stem" ~ "EES" # "Equity for Excellence in STEM"  
 "division of graduate education"  ~ "DGE" # "Graduate Education"  
 "div of research on learning in" ~ "DRL"  # "Research on Learning in Formal and Informal Settings"  
 "division of undergraduate education" ~ "DUE"  # "Undergraduate Education"   
 "Technology, Innovation and Partnerships" ~ "TIP"  
 "division of industrial innovation" ~ "IIP" # Division of Industrial Innovation and Partnerships (IIP)  
 "innovation and technology ecosystems" ~ "ITE" # Directorate for Technology, Innovation and Partnerships / Division of Innovation and Technology Ecosystems (TIP/ITE)  
 "integrative and collaborative" ~ "OIA" # office of integrative and collaborative (OD/OIA)  
 "mps multidisciplinary activities" ~ "OMA" # Mathematical and Physical Sciences Office of Multidisciplinary Activities (OMA)  
 "nat nanotechnology coordinating ofc" ~ "NNCO" # National Nanotechnology Coordination Office (NNCO)  
 "sbe office of multidisciplinary act" ~ "SMA" # SBE Office of Multidisciplinary Activities (SBE/SMA) 
 "strategic partnerships office" ~ "SPH" # Division of Strategic Partnerships Hub (SPH)  
 "technology frontiers" ~ "HTF" # The Future of Work at the Human-Technology Frontier (FW-HTF)   
 "translational impacts" ~ "ART" # Accelerating Research Translation (ART)  
 "div of human resource development"  ~ "ART" Division Human Resource Development (HRD)  


#### The following NSF Divisions+ are not referenced in the original file but I include here should others wish to edit their forks

 "Biological Sciences" ~ "BIO"  
 "Geosciences" ~ "GEO"  
 "Social and Economic Sciences" ~ "SES"  
 "Multidisciplinary Activities" ~ "SMA"  
 "STEM Education" ~ "EDU"  
 "Strategic Initiatives" ~ "OSI"  
 "Research, Innovation, Synergies, and Education" ~ "RISE"  
 "Mathematical and Physical Sciences" ~ "MPS"  
 "Engineering" ~ "ENG"

