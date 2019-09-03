require_relative "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by(
    :selenium,
    using: :chrome,
    screen_size: [1400, 900],
    options: {
      desired_capabilities: {
        chromeOptions: {
          args: %w[headless disable-gpu],
          prefs: {
            'modifyheaders.headers.name' => 'Accept-Language',
            'modifyheaders.headers.value' => 'ja,en',
          }
        }
      }
    }
  )
end
