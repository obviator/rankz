# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')
# Add controller specific js to asset load path
Rails.application.config.assets.paths << Rails.root.join('assets/controllers')

# Precompile additional assets.
# application.js, application.css.sass, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
# Add controller specific js to asset precompile path
Rails.application.config.assets.precompile += ['javascripts/controllers/*']
