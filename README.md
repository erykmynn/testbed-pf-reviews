# Data Testbed
This is a preconfigured [Drupal](https://drupal.org) setup designed to import a real-world based [Kaggle](https://www.kaggle.com/) data set for experimental development, feature testing, etc.

I set this up so as to have realistic data to pilot vector search, chatbot, and data analysis and display technologies on top of Drupal.

## Contact
If you have questions or ideas please use the message and issue options here on github or find me on Drupal Slack as: `@erykmynn`

# Prerequisites
- [Composer](https://getcomposer.org/doc/00-intro.md#installation-linux-unix-macos)
- [DDEV](https://docs.ddev.com/en/stable/users/install/ddev-installation/)
- A [Docker Provider](https://docs.ddev.com/en/stable/users/install/docker-installation/) (I'm using Rancher)
- [SQLite3](https://sqlite.org/download.html) (possibly baked into your system already)
*You can also likely install these through your package manager, including Brew on Mac. You could use another local dev container system or virtual machine if so inclined.*

# Getting Started
- Clone this repository or a fork of it.

## Install preconfigured Drupal
(From the repo's root directory)
    composer install

    ddev start

    drush site:install --existing-config

## Switch to Gin admin theme (optional, reccomended):
    ddev drush recipe ../recipes/gin-admin-experience

    composer drupal:recipe-unpack kanopi/gin-admin-experience

<!-- ## Admin Login
User 1:
- Username: `testbed@dev.null`
- Password: `password` -->

# Data setup

## Data Prep
- Visit <https://www.kaggle.com/datasets/nolanbconaway/24169-pitchfork-reviews> and download the source data (registration may be required).
- Unzip if necessary and drop the `.sqlite` file in `kaggle-data/` directory.
- Run the following shell script to create importable CSVs (shown from repo root)
    -         kaggle-data/db-to-csv.sh

## Data Import
    ddev drush migrate:import testbed_pf_reviews_artists_taxo

    ddev drush migrate:import testbed_pf_reviews_albums_para

    ddev drush migrate:import testbed_pf_reviews_review_node

*Note: The first two must be imported before the last one (node) as the other two entities are referenced on node fields.*

# Next Steps
