# AGREE-analysis

## Single joint analysis

uiopen('data/***.csv');\
rename table to 'agree_esmacat'\
save 'agree_esmacat' to 'agree_esmacat.mat' file\
\
in script, just load .mat files:\
load(data/agree_esmacat.mat);\
