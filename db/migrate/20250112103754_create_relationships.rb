class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.integer :follower_id #フォローするユーザのID
      t.integer :followed_id #フォローされるユーザのID

      t.timestamps
    end
  end
end
