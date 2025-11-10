This is a preconfigured [Drupal](https://drupal.org) setup designed to import a real-world based [Kaggle](https://www.kaggle.com/) data set for experimental development, feature testing, etc.

# Prerequisites:
-[Composer](https://getcomposer.org/doc/00-intro.md#installation-linux-unix-macos)
-[DDEV](https://docs.ddev.com/en/stable/users/install/ddev-installation/)
-A [Docker Provider](https://docs.ddev.com/en/stable/users/install/docker-installation/) (I'm using Rancher)
-[SQLite3](https://sqlite.org/download.html) (possibly baked into your system already)

*You can also likely install these through your package manager, including Brew on Mac. You could use another local dev container system or virtual machine if so inclined.*

# To get started:
- Clone this repository or a fork of it.

## To install preconfigured Drupal:
-    composer install
-    ddev start
-    drush site:install --existing-config

## To switch to Gin admin theme (reccomended):
    ddev drush recipe ../recipes/gin-admin-experience
    composer drupal:recipe-unpack kanopi/gin-admin-experience

## Admin Login
User 1:
- Username: `testbed@dev.null`
- Password: `password`

# Data cleaning and import:

## Data Prep
- Visit <https://www.kaggle.com/datasets/nolanbconaway/24169-pitchfork-reviews> and download the source data (registration may be required).
- Unzip if necessary and drop the `.sqlite` file in `kaggle-data/` directory.
- Run the following shell script to create importable CSVs (shown from repo root)
    -         kaggle-data/db-to-csv.sh

## Data Import
-    ddev drush migrate:import testbed_pf_reviews_artists_taxo
-    ddev drush migrate:import testbed_pf_reviews_albums_para
-    ddev drush migrate:import testbed_pf_reviews_review_node

*Note: The first two must be imported before the last one (node) as the other two entities are referenced on node fields.*



