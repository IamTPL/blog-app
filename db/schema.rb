# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_241_023_135_705) do
  create_table 'article_details', force: :cascade do |t|
    t.integer 'article_id', null: false
    t.integer 'word_count'
    t.string 'topic'
    t.datetime 'published_at'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['article_id'], name: 'index_article_details_on_article_id'
  end

  create_table 'articles', force: :cascade do |t|
    t.string 'title'
    t.text 'description'
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.integer 'author_id', null: false
    t.index ['author_id'], name: 'index_articles_on_author_id'
  end

  create_table 'authors', force: :cascade do |t|
    t.string 'name'
    t.string 'age'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'email'
    t.string 'password_digest'
    t.index ['email'], name: 'index_authors_on_email', unique: true
  end

  add_foreign_key 'article_details', 'articles'
  add_foreign_key 'articles', 'authors'
end
