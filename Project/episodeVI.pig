inputDialouges = LOAD 'hdfs:///user/root/inputs/episodeVI_dialouges.txt' USING PigStorage('\t') AS (name:chararray, line:chararray);
ranked = RANK inputDialouges;
OnlyDialouges = FILTER ranked BY (rank_inputDialouges > 2);
groupByName = GROUP OnlyDialouges By name;
names = FOREACH groupByName GENERATE $0 as name, COUNT($1) as no_of_lines;
namesOrdered = ORDER names BY no_of_lines DESC;
STORE namesOrdered INTO 'hdfs:///user/root/outputs/episodeVIOutput' USING PigStorage('\t');