class RemindList < ActiveRecord::Base
  include Validators

  validates :email, :on => :update, :'validators/email' => true
  validates :email, :on => :create, :allow_nil => true, :'validators/email' => true
end
