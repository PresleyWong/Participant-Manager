class AddLocalityToParticipants < ActiveRecord::Migration[6.0]
  def change
    add_column :participants, :locality, :string
  end
end
