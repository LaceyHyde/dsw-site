class CreateIndustryTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :industry_types do |t|
      t.string :name

      t.timestamps
    end
  end
end