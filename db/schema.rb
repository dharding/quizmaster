# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100117220514) do

  create_table "answers", :force => true do |t|
    t.integer  "games_question_id",                    :null => false
    t.integer  "team_id",                              :null => false
    t.text     "content"
    t.boolean  "correct",           :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "games", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "current_round",       :default => 0
    t.integer  "current_question",    :default => 0
    t.boolean  "complete",            :default => false
    t.boolean  "started",             :default => false
    t.integer  "rounds",              :default => 3
    t.integer  "questions_per_round", :default => 5
  end

  create_table "games_questions", :force => true do |t|
    t.integer "game_id",                        :null => false
    t.integer "question_id",                    :null => false
    t.boolean "locked",      :default => false
  end

  create_table "games_teams", :force => true do |t|
    t.integer "points",  :default => 0
    t.boolean "winner",  :default => false
    t.integer "game_id",                    :null => false
    t.integer "team_id",                    :null => false
  end

  create_table "questions", :force => true do |t|
    t.text    "ask",        :null => false
    t.text    "answer",     :null => false
    t.integer "difficulty", :null => false
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "taggable_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "teams", :force => true do |t|
    t.string  "name",       :limit => 50, :null => false
    t.integer "captain_id"
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email",                                  :null => false
    t.string   "crypted_password",                       :null => false
    t.string   "password_salt",                          :null => false
    t.string   "persistence_token",                      :null => false
    t.string   "single_access_token",                    :null => false
    t.string   "perishable_token",                       :null => false
    t.integer  "login_count",         :default => 0,     :null => false
    t.integer  "failed_login_count",  :default => 0,     :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",              :default => false
    t.boolean  "admin",               :default => false
    t.integer  "team_id"
  end

end
