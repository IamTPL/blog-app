class CreateArticleDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :article_details do |t|
      t.references :article, null: false, foreign_key: true
      t.integer :word_count
      t.string :topic
      t.datetime :published_at

      t.timestamps
    end
  end
end
