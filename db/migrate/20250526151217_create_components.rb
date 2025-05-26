class CreateComponents < ActiveRecord::Migration[8.0]
  def change
    create_table :components do |t|
      t.string :name, null: false
      t.string :component_type, null: false
      t.text :html_content
      t.json :properties, default: {}
      t.boolean :reusable, default: true
      t.timestamps
    end

    add_index :components, :component_type
  end
end
