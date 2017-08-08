class AddContentTypeFieldToLayout < ActiveRecord::Migration[5.1]
  def self.up
    add_column "layouts", "content_type", :string, :limit => 40
  end

  def self.down
    remove_column "layouts", "content_type"
  end
end
