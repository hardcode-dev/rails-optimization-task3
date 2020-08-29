module BusServices
  class Seed
    def call
      columns = [:id, :name]
      import_data = Service::SERVICES.each_with_index.map { |v, i|
        [i + 1, v]
      }

      Service.import(columns, import_data)

      # Result of insertion in format:
      # {
      #   "WiFi" => 1,
      #   "Туалет" => 2,
      #   "Работающий туалет" => 3,
      #   "Ремни безопасности" => 4,
      #   "Кондиционер общий" => 5,
      #   "Кондиционер Индивидуальный" => 6,
      #   "Телевизор общий" => 7,
      #   "Телевизор индивидуальный" => 8,
      #   "Стюардесса" => 9,
      #   "Можно не печатать билет" => 10
      # }
      Hash[import_data.map { |id, value| [value, id] }]
    end
  end
end
