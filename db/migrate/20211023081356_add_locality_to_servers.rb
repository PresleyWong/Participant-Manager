class AddLocalityToServers < ActiveRecord::Migration[6.0]
  def change
    add_column :servers, :locality, :string
  end
end
