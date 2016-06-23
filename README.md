# US Presidential Elections since 1789

## About

Inspired by [this Reddit post](https://www.reddit.com/r/dataisbeautiful/comments/3pxna7/100_years_of_us_presidential_elections_a_table_of/).

Wanted to expand on it with the following improvements:

* including shading for margin of victory (% of winning party - % of next highest party)
* expanding the dataset to the earliest possible election data
* breaking down the states into regions, since there are clear election patterns

## Graphics

![Election Results by State (ordered by Admission into Union)](https://raw.githubusercontent.com/zonination/election-history/master/Election-Order.png)

![Election Results by Region](https://raw.githubusercontent.com/zonination/election-history/master/Elections-region.png) 

## Sources:

**Election Data**

* 1821 and Before: http://www.archives.gov/federal-register/electoral-college/votes/1789_1821.html
* 1824 and After: http://www.presidency.ucsb.edu/showelection.php?year=1824

**Other Data**

* BEA regions: http://www.bea.gov/regional/docs/regions.cfm
* States by admission into union: https://en.wikipedia.org/wiki/List_of_U.S._states_by_date_of_admission_to_the_Union#List_of_U.S._states

## Tools used:

* ggplot2
* Rstudio
