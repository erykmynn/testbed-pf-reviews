# Data Testbed
This is a preconfigured [Drupal](https://drupal.org) setup designed to import a real-world based [Kaggle](https://www.kaggle.com/) data set for experimental development, feature testing, etc.

I set this up so as to have realistic data to pilot vector search, chatbot, and data analysis and display technologies on top of Drupal.

## Contact
If you have questions or ideas please use the message and issue options here on github or find me on Drupal Slack as: `@erykmynn`

# Prerequisites
- [Composer](https://getcomposer.org/doc/00-intro.md#installation-linux-unix-macos)
- [DDEV](https://docs.ddev.com/en/stable/users/install/ddev-installation/)
- [A Docker Provider](https://docs.ddev.com/en/stable/users/install/docker-installation/) (I'm using Rancher)
- [SQLite3](https://sqlite.org/download.html) (possibly baked into your system already)
*You can also likely install these through your package manager, including Brew on Mac. You could use another local dev container system or virtual machine if so inclined.*

# Getting Started
- Clone this repository or a fork of it. **Recommended to fork unless you are just kicking the tires or working on the base install itself.**

## Install preconfigured Drupal
(From the repo's root directory)
Install all composer dependecies, contrib modules, etc:
```
composer install
```

Start DDEV
```
ddev start
```

Install Drupal using the existing config files:
```
ddev drush site:install --existing-config
```
*Drush will provide an admin username and password.*

# Data setup

## Data Prep
- Visit <https://www.kaggle.com/datasets/nolanbconaway/24169-pitchfork-reviews> and download the source data (registration may be required).
- Unzip if necessary.
- Ensure the `.sqlite` file is placed in `kaggle-data/` directory.
- Run the following shell script to create importable CSVs (shown from repo root)
```
kaggle-data/db-to-csv.sh
```

## Data Import
Import artists as taxonomy terms:
```
ddev drush migrate:import testbed_pf_reviews_artists_taxo
```

Import album-by-album paragraph data:
```
ddev drush migrate:import testbed_pf_reviews_albums_para
```

Import reviews as the main nodes:
```
ddev drush migrate:import testbed_pf_reviews_review_node
```
*Note: The first two must be imported before this last one (node) as the other two entities are referenced on node fields.*

# Next Steps

**Have fun!** Try stuff on top of here. I'm curious how a testbed like this is useful. Drop me a line!

## To-dos
- **Identify and correct remaining import errors:** A very small number of records are still not correct. Not enough to stop this being useful but there is two node records that don't import due to weird slashes in the name (though the UI only counts 1). Also the migration report shows "-1" artists unimported.
- **Configure display layer minimally:** I don't want to base install here to be very opinionated about how to display this info (hide/show, etc) but in some cases basic defaults need to be set up so it's at least navigable when used for it's other testing purposes. For example I turned on a basic teaser display beacuse lists were showing the full review records, which is unweildy.