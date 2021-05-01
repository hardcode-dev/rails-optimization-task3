class Optimize < ActiveRecord::Migration[5.2]
  def up
    # PK по колонке `id` в таблице`buses_services` явно не используется в проекте. Удаляем.
    execute 'ALTER TABLE buses_services DROP CONSTRAINT buses_services_pkey'

    # Вообще, колонка `id` в таблице-связке выглядит лишней. Убираем и её.
    # remove_column :buses_services, :id

    # Создаем новый композитный PK
    execute "ALTER TABLE buses_services ADD PRIMARY KEY (bus_id, service_id);"

    # Индекс в `trips` для поиска по городам
    add_index :trips, [:from_id, :to_id]
  end

  # При попытке отката произойдет IrreversableMigration, но в условиях задачи нет требования про откат миграций.
  # Понятно, что если это понадобится, составить метод `down` не будет проблемой.
end
