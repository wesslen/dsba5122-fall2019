# DSBA 5122: Visual Analytics

![](images/dsba5122.png)

This repository contains the code for generating [dsba5122-spring2019.netlify.com](https://dsba5122-spring2019.netlify.com).

## Attribution

This course was forked from Andrew Heiss' [MPA 635 Data Visualization](https://github.com/andrewheiss/datavizf18.classes.andrewheiss.com). Many of the resources were used (although many added) and like Andrew's repo, this course is provided under CC BY-NC-SA 4.0.

<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/">Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License</a>.

## Theme

This site uses Andrew's custom [`ath-tufte-hugo_18-19` theme](https://github.com/andrewheiss/ath-tufte-hugo_18-19) as a submodule.

When cloning for the first time, use this command to get the theme too:

    git clone --recursive https://github.com/andrewheiss/ath-tufte-hugo_18-19.git

To get the theme later, use this command:

    git submodule add \
      https://github.com/andrewheiss/ath-tufte-hugo_18-19.git \
      themes/ath-tufte-hugo_18-19

To update to the latest version of the theme, use:

    git submodule update --recursive --remote
