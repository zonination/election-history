**Tools:** R/ggplot2  
**Code:** [Code is open-source](https://github.com/zonination/election-history)  
**Sources:**

* **Election Data**

  * 1821 and Before: http://www.archives.gov/federal-register/electoral-college/votes/1789_1821.html
  * 1824 and After: http://www.presidency.ucsb.edu/showelection.php?year=1824

* **Other Data**

  * BEA regions: http://www.bea.gov/regional/docs/regions.cfm
  * States by admission into union: https://en.wikipedia.org/wiki/List_of_U.S._states_by_date_of_admission_to_the_Union#List_of_U.S._states

---

**Brief Explanation:**

Note that before 1824, elections were decided by electoral only, not by the popular vote in each state. After 1824, the depth of color correlates to margin of victory, or `% of winning vote - % of next highest vote`. However, not all states went by popular vote after 1824, and instead some states chose candidates by electorate up until the American Civil War. These values and pre-1824 values are keyed at 75% opacity.

The only parties that have definitions in the legend are parties that have been able to secure an election. Everything else is lumped under "Other".
