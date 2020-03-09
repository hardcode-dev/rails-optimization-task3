class WriteServices < ActiveRecord::Migration[5.2]

  def up
    Service.delete_all
    [
        'WiFi',
        'Туалет',
        'Работающий туалет',
        'Ремни безопасности',
        'Кондиционер общий',
        'Кондиционер Индивидуальный',
        'Телевизор общий',
        'Телевизор индивидуальный',
        'Стюардесса',
        'Можно не печатать билет'
    ].each do |name|
      ss = Service.new(name: name)
      ss.save!
    end

  end

  def down
    Service.delete_all
  end
end
