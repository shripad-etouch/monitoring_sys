class CreateResponseObjects < ActiveRecord::Migration
  def change
    create_table :response_objects do |t|
      t.string :name

      t.timestamps
    end
  end
end
