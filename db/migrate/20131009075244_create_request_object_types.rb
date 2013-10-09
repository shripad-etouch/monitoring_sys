class CreateRequestObjectTypes < ActiveRecord::Migration
  def change
    create_table :request_object_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
