class CreateIssues < ActiveRecord::Migration
  def up
    create_table :issues do |t|
      t.text :content
      t.integer :user_id

      t.timestamps
    end
  end

  def down
    drop_table :issues
  end
end
