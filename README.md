Drupal with DDEV, managed by composer

Intended to be used as a template for starting Github projects.

Use it when creating a new project repo then clone it to local.

Assuming Composer, DDEV, and your docker host are installed, you basically just have to:
`composer install` and
`ddev start`

(swap out for `composer update` if you're feeling spicy)

and you can switch over to Gin admin theme with: `ddev drush recipe ../recipes/gin-admin-experience`
followed with `composer drupal:recipe-unpack kanopi/gin-admin-experience` for cleanup