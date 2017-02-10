class DataController < ApplicationController
  before_action :authenticate_user!, :requires_admin

  def index

  end
end
