class CreateProvidersClientsAndHealthJournalEntries < ActiveRecord::Migration[8.1]
  def change
    create_table :providers do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.timestamps
    end
    add_index :providers, :email, unique: true

    create_table :clients do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.timestamps
    end
    add_index :clients, :email, unique: true

    create_table :enrollments do |t|
      t.references :provider, null: false, foreign_key: true
      t.references :client, null: false, foreign_key: true
      t.string :plan, null: false
      t.timestamps
    end
    add_check_constraint :enrollments, "plan IN ('basic', 'premium')", name: "enrollments_plan_check"

    create_table :health_journal_entries do |t|
      t.references :client, null: false, foreign_key: true, index: false
      t.text :body, null: false
      t.timestamps
    end
    add_index :health_journal_entries, %i[client_id created_at], order: { created_at: :desc }
  end
end
