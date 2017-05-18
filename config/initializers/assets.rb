# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( print.scss )
Rails.application.config.assets.precompile += %w( footer.js )
Rails.application.config.assets.precompile += %w( characters.js )
Rails.application.config.assets.precompile += %w( wizard.js )
Rails.application.config.assets.precompile += %w( questionnaire.js )
Rails.application.config.assets.precompile += %w( charts.js )
