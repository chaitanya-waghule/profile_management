class CreateAddresses < ActiveRecord::Migration[6.1]

  def change
    create_table :addresses do |t|
      t.string     :address_line
      t.string     :city
      t.string     :landmark
      t.string     :mobile_number
      t.string     :province
      t.string     :street
      t.string     :zip
      t.references :user
      t.timestamps
    end
  end

end
