class CreatePageComponents < ActiveRecord::Migration[8.0]
  def change
    create_table :page_components do |t|
      t.references :page, null: false, foreign_key: true
      t.references :component, null: false, foreign_key: true
      t.integer :position, null: false
      t.json :custom_properties, default: {}
      t.timestamps
    end

    add_index :page_components, [ :page_id, :position ]
  end
end
