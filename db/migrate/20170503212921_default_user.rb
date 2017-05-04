class DefaultUser < ActiveRecord::Migration
 def up
    admin = User.new
    admin.first_name = "Admin"
    admin.last_name = "Admin"
    admin.email = "admin@example.com"
    admin.phone = "9788218774"
    admin.username = "admin1"
    admin.password = "secret"
    admin.password_confirmation = "secret"
    admin.role = "admin"
    admin.save!
  end

  def down
    admin = User.find_by_email "admin@example.com"
    User.delete admin
  end
end
