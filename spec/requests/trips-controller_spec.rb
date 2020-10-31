require "rails_helper"

RSpec.describe TripsController, type: :request do
  let(:file) { "fixtures/example.json" }

  before { ReimportDatabaseService.new(file_name: file).call }

  let(:url) { URI.encode("/автобусы/Москва/Самара").to_s }
  it "renders correct page" do
    get url
    expect(response.body).to eq(required_response)
  end

  private

  def required_response
    "<!DOCTYPE html>\n" \
      "<html>\n" \
      "  <head>\n" \
      "    <title>Task4</title>\n" \
      "    \n" \
      "    \n" \
      "\n" \
      "    <link rel=\"stylesheet\" media=\"all\" href=\"/assets/application-b324c44f04a0d0da658824105489a2676d49df561c3d06723770321fd441977c.css\" />\n" \
      "    <script src=\"/assets/application-85d9a73fda0f0681d4ef3a9b1147090e2e807aa98db37994df53a3e31b5538c9.js\"></script>\n" \
      "  </head>\n" \
      "\n" \
      "  <body>\n" \
      "    <h1>\n" \
      "  Автобусы Москва – Самара\n" \
      "</h1>\n" \
      "<h2>\n" \
      "  В расписании 5 рейсов\n" \
      "</h2>\n" \
      "\n" \
      "  <ul>\n" \
      "    <li>Отправление: 11:00</li>\n" \
      "<li>Прибытие: 13:48</li>\n" \
      "<li>В пути: 2ч. 48мин.</li>\n" \
      "<li>Цена: 4р. 74коп.</li>\n" \
      "<li>Автобус: Икарус №123</li>\n" \
      "\n" \
      "      <li>Сервисы в автобусе:</li>\n" \
      "<ul>\n" \
      "    <li>Туалет</li>\n" \
      "\n" \
      "    <li>WiFi</li>\n" \
      "\n" \
      "</ul>\n" \
      "\n" \
      "  </ul>\n" \
      "  ====================================================\n" \
      "\n" \
      "  <ul>\n" \
      "    <li>Отправление: 12:00</li>\n" \
      "<li>Прибытие: 17:23</li>\n" \
      "<li>В пути: 5ч. 23мин.</li>\n" \
      "<li>Цена: 6р. 72коп.</li>\n" \
      "<li>Автобус: Икарус №123</li>\n" \
      "\n" \
      "      <li>Сервисы в автобусе:</li>\n" \
      "<ul>\n" \
      "    <li>Туалет</li>\n" \
      "\n" \
      "    <li>WiFi</li>\n" \
      "\n" \
      "</ul>\n" \
      "\n" \
      "  </ul>\n" \
      "  ====================================================\n" \
      "\n" \
      "  <ul>\n" \
      "    <li>Отправление: 13:00</li>\n" \
      "<li>Прибытие: 18:04</li>\n" \
      "<li>В пути: 5ч. 4мин.</li>\n" \
      "<li>Цена: 6р. 41коп.</li>\n" \
      "<li>Автобус: Икарус №123</li>\n" \
      "\n" \
      "      <li>Сервисы в автобусе:</li>\n" \
      "<ul>\n" \
      "    <li>Туалет</li>\n" \
      "\n" \
      "    <li>WiFi</li>\n" \
      "\n" \
      "</ul>\n" \
      "\n" \
      "  </ul>\n" \
      "  ====================================================\n" \
      "\n" \
      "  <ul>\n" \
      "    <li>Отправление: 14:00</li>\n" \
      "<li>Прибытие: 23:58</li>\n" \
      "<li>В пути: 9ч. 58мин.</li>\n" \
      "<li>Цена: 6р. 29коп.</li>\n" \
      "<li>Автобус: Икарус №123</li>\n" \
      "\n" \
      "      <li>Сервисы в автобусе:</li>\n" \
      "<ul>\n" \
      "    <li>Туалет</li>\n" \
      "\n" \
      "    <li>WiFi</li>\n" \
      "\n" \
      "</ul>\n" \
      "\n" \
      "  </ul>\n" \
      "  ====================================================\n" \
      "\n" \
      "  <ul>\n" \
      "    <li>Отправление: 15:00</li>\n" \
      "<li>Прибытие: 17:07</li>\n" \
      "<li>В пути: 2ч. 7мин.</li>\n" \
      "<li>Цена: 7р. 95коп.</li>\n" \
      "<li>Автобус: Икарус №123</li>\n" \
      "\n" \
      "      <li>Сервисы в автобусе:</li>\n" \
      "<ul>\n" \
      "    <li>Туалет</li>\n" \
      "\n" \
      "    <li>WiFi</li>\n" \
      "\n" \
      "</ul>\n" \
      "\n" \
      "  </ul>\n" \
      "  ====================================================\n" \
      "\n" \
      "\n" \
      "  <script type='text/javascript'>(function() {\n" \
      "  var oldOpen = window.XMLHttpRequest.prototype.open;\n" \
      "  var oldSend = window.XMLHttpRequest.prototype.send;\n" \
      "\n" \
      "  /**\n" \
      "   * Return early if we've already extended prototype. This prevents\n" \
      "   * \"maximum call stack exceeded\" errors when used with Turbolinks.\n" \
      "   * See https://github.com/flyerhzm/bullet/issues/454\n" \
      "   */\n" \
      "  if (isBulletInitiated()) return;\n" \
      "\n" \
      "  function isBulletInitiated() {\n" \
      "    return oldOpen.name == 'bulletXHROpen' && oldSend.name == 'bulletXHRSend';\n" \
      "  }\n" \
      "  function bulletXHROpen(_, url) {\n" \
      "    this._storedUrl = url;\n" \
      "    return oldOpen.apply(this, arguments);\n" \
      "  }\n" \
      "  function bulletXHRSend() {\n" \
      "    if (this.onload) {\n" \
      "      this._storedOnload = this.onload;\n" \
      "    }\n" \
      "    this.addEventListener('load', bulletXHROnload);\n" \
      "    return oldSend.apply(this, arguments);\n" \
      "  }\n" \
      "  function bulletXHROnload() {\n" \
      "    if (\n" \
      "      this._storedUrl.startsWith(window.location.protocol + '//' + window.location.host) ||\n" \
      "      !this._storedUrl.startsWith('http') // For relative paths\n" \
      "    ) {\n" \
      "      var bulletFooterText = this.getResponseHeader('X-bullet-footer-text');\n" \
      "      if (bulletFooterText) {\n" \
      "        setTimeout(() => {\n" \
      "          var oldHtml = document.getElementById('bullet-footer').innerHTML.split('<br>');\n" \
      "          var header = oldHtml[0];\n" \
      "          oldHtml = oldHtml.slice(1, oldHtml.length);\n" \
      "          var newHtml = oldHtml.concat(JSON.parse(bulletFooterText));\n" \
      "          newHtml = newHtml.slice(newHtml.length - 10, newHtml.length); // rotate through 10 most recent\n" \
      "          document.getElementById('bullet-footer').innerHTML = `${header}<br>${newHtml.join('<br>')}`;\n" \
      "        }, 0);\n" \
      "      }\n" \
      "      var bulletConsoleText = this.getResponseHeader('X-bullet-console-text');\n" \
      "      if (bulletConsoleText && typeof console !== 'undefined' && console.log) {\n" \
      "        setTimeout(() => {\n" \
      "          JSON.parse(bulletConsoleText).forEach(message => {\n" \
      "            if (console.groupCollapsed && console.groupEnd) {\n" \
      "              console.groupCollapsed('Uniform Notifier');\n" \
      "              console.log(message);\n" \
      "              console.groupEnd();\n" \
      "            } else {\n" \
      "              console.log(message);\n" \
      "            }\n" \
      "          });\n" \
      "        }, 0);\n" \
      "      }\n" \
      "    }\n" \
      "    if (this._storedOnload) {\n" \
      "      return this._storedOnload.apply(this, arguments);\n" \
      "    }\n" \
      "  }\n" \
      "  window.XMLHttpRequest.prototype.open = bulletXHROpen;\n" \
      "  window.XMLHttpRequest.prototype.send = bulletXHRSend;\n" \
      "})();\n" \
      "</script></body>\n" \
      "</html>\n"
    "<!DOCTYPE html>\n<html>\n  <head>\n    <title>Task4</title>\n    \n    \n\n    <link rel=\"stylesheet\" media=\"all\" href=\"/assets/application-b324c44f04a0d0da658824105489a2676d49df561c3d06723770321fd441977c.css\" />\n    <script src=\"/assets/application-85d9a73fda0f0681d4ef3a9b1147090e2e807aa98db37994df53a3e31b5538c9.js\"></script>\n  </head>\n\n  <body>\n    <h1>\n  Автобусы Москва – Самара\n</h1>\n<h2>\n  В расписании 5 рейсов\n</h2>\n\n  <ul>\n    <li>Отправление: 11:00</li>\n<li>Прибытие: 13:48</li>\n<li>В пути: 2ч. 48мин.</li>\n<li>Цена: 4р. 74коп.</li>\n<li>Автобус: Икарус №123</li>\n\n      <li>Сервисы в автобусе:</li>\n<ul>\n    <li>Туалет</li>\n\n    <li>WiFi</li>\n\n</ul>\n\n  </ul>\n  ====================================================\n\n  <ul>\n    <li>Отправление: 12:00</li>\n<li>Прибытие: 17:23</li>\n<li>В пути: 5ч. 23мин.</li>\n<li>Цена: 6р. 72коп.</li>\n<li>Автобус: Икарус №123</li>\n\n      <li>Сервисы в автобусе:</li>\n<ul>\n    <li>Туалет</li>\n\n    <li>WiFi</li>\n\n</ul>\n\n  </ul>\n  ====================================================\n\n  <ul>\n    <li>Отправление: 13:00</li>\n<li>Прибытие: 18:04</li>\n<li>В пути: 5ч. 4мин.</li>\n<li>Цена: 6р. 41коп.</li>\n<li>Автобус: Икарус №123</li>\n\n      <li>Сервисы в автобусе:</li>\n<ul>\n    <li>Туалет</li>\n\n    <li>WiFi</li>\n\n</ul>\n\n  </ul>\n  ====================================================\n\n  <ul>\n    <li>Отправление: 14:00</li>\n<li>Прибытие: 23:58</li>\n<li>В пути: 9ч. 58мин.</li>\n<li>Цена: 6р. 29коп.</li>\n<li>Автобус: Икарус №123</li>\n\n      <li>Сервисы в автобусе:</li>\n<ul>\n    <li>Туалет</li>\n\n    <li>WiFi</li>\n\n</ul>\n\n  </ul>\n  ====================================================\n\n  <ul>\n    <li>Отправление: 15:00</li>\n<li>Прибытие: 17:07</li>\n<li>В пути: 2ч. 7мин.</li>\n<li>Цена: 7р. 95коп.</li>\n<li>Автобус: Икарус №123</li>\n\n      <li>Сервисы в автобусе:</li>\n<ul>\n    <li>Туалет</li>\n\n    <li>WiFi</li>\n\n</ul>\n\n  </ul>\n  ====================================================\n\n\n  <script type='text/javascript'>(function() {\n  var oldOpen = window.XMLHttpRequest.prototype.open;\n  var oldSend = window.XMLHttpRequest.prototype.send;\n\n  /**\n   * Return early if we've already extended prototype. This prevents\n   * \"maximum call stack exceeded\" errors when used with Turbolinks.\n   * See https://github.com/flyerhzm/bullet/issues/454\n   */\n  if (isBulletInitiated()) return;\n\n  function isBulletInitiated() {\n    return oldOpen.name == 'bulletXHROpen' && oldSend.name == 'bulletXHRSend';\n  }\n  function bulletXHROpen(_, url) {\n    this._storedUrl = url;\n    return oldOpen.apply(this, arguments);\n  }\n  function bulletXHRSend() {\n    if (this.onload) {\n      this._storedOnload = this.onload;\n    }\n    this.addEventListener('load', bulletXHROnload);\n    return oldSend.apply(this, arguments);\n  }\n  function bulletXHROnload() {\n    if (\n      this._storedUrl.startsWith(window.location.protocol + '//' + window.location.host) ||\n      !this._storedUrl.startsWith('http') // For relative paths\n    ) {\n      var bulletFooterText = this.getResponseHeader('X-bullet-footer-text');\n      if (bulletFooterText) {\n        setTimeout(() => {\n          var oldHtml = document.getElementById('bullet-footer').innerHTML.split('<br>');\n          var header = oldHtml[0];\n          oldHtml = oldHtml.slice(1, oldHtml.length);\n          var newHtml = oldHtml.concat(JSON.parse(bulletFooterText));\n          newHtml = newHtml.slice(newHtml.length - 10, newHtml.length); // rotate through 10 most recent\n          document.getElementById('bullet-footer').innerHTML = `${header}<br>${newHtml.join('<br>')}`;\n        }, 0);\n      }\n      var bulletConsoleText = this.getResponseHeader('X-bullet-console-text');\n      if (bulletConsoleText && typeof console !== 'undefined' && console.log) {\n        setTimeout(() => {\n          JSON.parse(bulletConsoleText).forEach(message => {\n            if (console.groupCollapsed && console.groupEnd) {\n              console.groupCollapsed('Uniform Notifier');\n              console.log(message);\n              console.groupEnd();\n            } else {\n              console.log(message);\n            }\n          });\n        }, 0);\n      }\n    }\n    if (this._storedOnload) {\n      return this._storedOnload.apply(this, arguments);\n    }\n  }\n  window.XMLHttpRequest.prototype.open = bulletXHROpen;\n  window.XMLHttpRequest.prototype.send = bulletXHRSend;\n})();\n</script></body>\n</html>\n"
  end
end
