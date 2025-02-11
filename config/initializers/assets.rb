# frozen_string_literal: true

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )

Rails.application.config.assets.paths << Rails.root.join('app/assets/javascripts')
Rails.application.config.assets.paths << Rails.root.join('app/assets/stylesheets')
Rails.application.config.assets.precompile += %w[application.js application.css]
