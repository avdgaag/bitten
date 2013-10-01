require 'active_record'

ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"
ActiveRecord::Migration.verbose = false

ActiveRecord::Migration.create_table :posts do |t|
  t.integer :bits, null: false, default: 0
  t.timestamps
end

class Post < ActiveRecord::Base
  extend Bitten
end
