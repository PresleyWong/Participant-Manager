class CreateParticipants < ActiveRecord::Migration[6.0]
  def change
    create_table :participants do |t|
      t.string :gender
      t.string :english_name
      t.string :chinese_name
      t.string :email
      t.integer :phone, :limit => 8
      t.string :college
      t.integer :academic_year
      t.string :language
      t.text :remarks

      t.timestamps
    end

    add_index :participants, :email, unique: true
  end
end
