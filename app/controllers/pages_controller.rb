class PagesController < ApplicationController
  include PagesHelper
  before_filter :authenticate_user, :only => [:update]

  def welcome
  end
  
  def update
    update_db
    Setting.first.update(:last_update => DateTime.now)
  end
end
