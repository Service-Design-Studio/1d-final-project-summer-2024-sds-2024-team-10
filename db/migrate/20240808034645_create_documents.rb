class CreateDocuments < ActiveRecord::Migration[7.1]
  def change
    create_table :documents do |t|
      t.string :proof_of_identity
      t.string :proof_of_residential_address
      t.string :employment_pass
      t.string :proof_of_mobile_phone_ownership
      t.string :proof_of_tax_residency
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
