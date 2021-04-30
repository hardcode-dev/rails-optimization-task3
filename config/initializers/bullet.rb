Rails.application.config.after_initialize do
  Bullet.enable = true
  Bullet.console = true
  Bullet.rails_logger = true
  Bullet.add_footer = true
  Bullet.skip_html_injection = false
end if Rails.env.development?