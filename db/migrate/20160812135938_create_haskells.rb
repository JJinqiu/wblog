class CreateHaskells < ActiveRecord::Migration[5.0]
  def change
    create_table :haskells do |t|
      t.string :code

      t.timestamps
    end
  end
end
